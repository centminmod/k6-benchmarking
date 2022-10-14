#!/bin/bash
###############################################################################
# take k6 run with --out json=summary-raw-scenarios-multi.gz JSON logged output
# and convert it into InfluxDB 1.8 batch line write format for post-k6 run
# insertion into InfluxDB 1.8 database
# https://github.com/centminmod/k6-benchmarking/blob/master/logs/k6-log-parsing.md
###############################################################################
# break to 5000 size batches for InfluxDB
SPLITSIZE='20000'
INFLUXDB_NAME='k6'
INFLUXDB_PORT='8186'
INFLUXDB_HOST='localhost'

WORKDIR="/home/k6-workdir"
LOGS_VU="${WORKDIR}/filtered-vus.log"
LOGS_METRICS="${WORKDIR}/filtered-metrics.log"
INFLUX_FORMAT_VU="${WORKDIR}/influxdb-vus.log"
INFLUX_FORMAT_METRICS="${WORKDIR}/influxdb-metrics.log"
###############################################################################
if [ ! -d "$WORKDIR" ]; then
  mkdir -p "$WORKDIR"
fi
if [ ! -f /usr/bin/jq ]; then
  yum -y -q install jq
fi
if [ -f /usr/bin/pzcat ]; then
  ZCATBIN=/usr/bin/pzcat
else
  ZCATBIN=/usr/bin/zcat
fi

convert_to_influx() {
  cd "$WORKDIR"
  mode="$1"
  file="$2"
  insert="$3"
  if [[ "$mode" = 'influx' ]]; then
    # grab vus metric
    echo
    echo "     filter VUs metrics to $LOGS_VU"
    $ZCATBIN "$file" | jq -c '. | select(.type=="Point" and .metric == "vus")' > "$LOGS_VU"
    # grab the rest of the metrics
    echo "     filter all metrics to $LOGS_METRICS"
    $ZCATBIN "$file" | jq -c '. | select(.type=="Point" and .data.tags.expected_response == "true" and .data.tags.status >= "200")' > "$LOGS_METRICS"
    # parse into InfluxDB batch write formats
    # vus metrics
    echo "     convert VUs log to InfluxDB format at $INFLUX_FORMAT_VU"
    cat "$LOGS_VU" | jq -r '"\(.metric),\(.data.tags|to_entries|map("\(.key)=\(.value|tostring)")|[.[]]|sort|join(",")) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000000000 + (.data.time[20:24-27]|tonumber))"' > "$INFLUX_FORMAT_VU"
    # rest of metrics
    echo "     convert all metrics logs to InfluxDB format at $INFLUX_FORMAT_METRICS"
    cat "$LOGS_METRICS" | jq -r '"\(.metric),\(.data.tags|to_entries|map("\(.key)=\(.value|tostring)")|[.[]]|sort|join(",")) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000000000 + (.data.time[20:24-27]|tonumber))"' > "$INFLUX_FORMAT_METRICS"
    # count lines
    _array=("$INFLUX_FORMAT_VU" "$INFLUX_FORMAT_METRICS")

    for c in "${_array[@]}"; do
      fdirname=$(dirname "$c")
      fbasename=$(basename "$c")
      counter=$(cat "$c"|wc -l)
      if [[ "$counter" -le '999999' ]]; then
        SPLITSIZE='10000'
      elif [[ "$counter" -ge '1000000' && "$counter" -le '4999999' ]]; then
        SPLITSIZE='20000'
      elif [[ "$counter" -ge '5000000' && "$counter" -le '9999999' ]]; then
        SPLITSIZE='30000'
      elif [[ "$counter" -ge '10000000' && "$counter" -le '14999999' ]]; then
        SPLITSIZE='40000'
      elif [[ "$counter" -ge '15000000' ]]; then
        SPLITSIZE='50000'
      fi
      if [[ "$counter" -gt "$SPLITSIZE" ]]; then
        numberfiles=$(($counter/$SPLITSIZE))
        if [[ "$numberfiles" -le '100' ]]; then
          insert_sleep=0.25
        elif [[ "$numberfiles" -ge '101' && "$numberfiles" -le '199' ]]; then
          insert_sleep=0.50
        elif [[ "$numberfiles" -ge '200' && "$numberfiles" -le '299' ]]; then
          insert_sleep=0.75
        elif [[ "$numberfiles" -ge '300' ]]; then
          insert_sleep=1.00
        fi
        # remove previous files
        find $fdirname -type f -name "${fbasename}-split-*" -delete
        split -l "$SPLITSIZE" $c ${fbasename}-split-
        echo
        echo "     Saved & Split InfluxDB formatted data files ($counter lines) at:"
        find $fdirname -type f -name "${fbasename}-split-*" | sort | while read f; do
          fn=$(basename $f)
          count_file=$(cat $fn|wc -l)
          if [ -f "${WORKDIR}/$fn" ]; then
            echo "     ${WORKDIR}/$fn ($count_file)"
          else
            echo "     ${WORKDIR}/$fn (error: missing)"
          fi
        done
        echo
        echo "     InfluxDB import queries"
        echo
        echo "     curl -i -sX POST http://${INFLUXDB_HOST}:${INFLUXDB_PORT}/query --data-urlencode \"q=CREATE DATABASE "$INFLUXDB_NAME"\""
        if [[ "$insert" = 'auto' ]]; then
          # echo "     # create InfluxDB database: ${INFLUXDB_NAME}..."
          # automatically run curl batch line insertions into InfluxDB database
          curl -i -w 'HTTP %{http_version} %{http_code} d:%{size_download} u:%{size_upload} %header{x-request-id} %header{x-influxdb-error}' -sX POST "http://${INFLUXDB_HOST}:${INFLUXDB_PORT}/query" --data-urlencode "q=CREATE DATABASE $INFLUXDB_NAME" | awk '{print "     " $0}' | tail -1
        fi
        find $fdirname -type f -name "*-split-*" | sort | while read f; do
          fn=$(basename $f)
          if [ -f "${WORKDIR}/$fn" ]; then
            echo "     curl -i -sX POST 'http://${INFLUXDB_HOST}:${INFLUXDB_PORT}/write?db="$INFLUXDB_NAME"' --data-binary @${WORKDIR}/$fn"
            if [[ "$insert" = 'auto' ]]; then
              # echo "     # auto insert ${WORKDIR}/$fn into InfluxDB database: ${INFLUXDB_NAME}..."
            # automatically run curl batch line insertions into InfluxDB database
            curl -i -w 'HTTP %{http_version} %{http_code} d:%{size_download} u:%{size_upload} %header{x-request-id} %header{x-influxdb-error}' -sX POST "http://${INFLUXDB_HOST}:${INFLUXDB_PORT}/write?db=$INFLUXDB_NAME" --data-binary @${WORKDIR}/$fn | awk '{print "     " $0}' | tail -1
            sleep "$insert_sleep"
            fi
          else
            echo "     ${WORKDIR}/$fn (error: missing)"
          fi
        done
      else
        echo
        echo "     Saved InfluxDB formatted data files ($counter lines) at:"
        echo "     ${WORKDIR}/$fbasename ($counter)"
        echo
        echo "     InfluxDB import queries"
        echo
        echo "     curl -i -sX POST http://${INFLUXDB_HOST}:${INFLUXDB_PORT}/query --data-urlencode \"q=CREATE DATABASE "$INFLUXDB_NAME"\""
        if [[ "$insert" = 'auto' ]]; then
          # echo "     # create InfluxDB database: ${INFLUXDB_NAME}..."
          # automatically run curl batch line insertions into InfluxDB database
          curl -i -w 'HTTP %{http_version} %{http_code} d:%{size_download} u:%{size_upload} %header{x-request-id} %header{x-influxdb-error}' -sX POST "http://${INFLUXDB_HOST}:${INFLUXDB_PORT}/query" --data-urlencode "q=CREATE DATABASE $INFLUXDB_NAME" | awk '{print "     " $0}' | tail -1
        fi
        echo "     curl -i -sX POST 'http://${INFLUXDB_HOST}:${INFLUXDB_PORT}/write?db="$INFLUXDB_NAME"' --data-binary @$c"
        if [[ "$insert" = 'auto' ]]; then
          # echo "     # auto insert ${WORKDIR}/$fn into InfluxDB database: ${INFLUXDB_NAME}..."
          # automatically run curl batch line insertions into InfluxDB database
          curl -i -w 'HTTP %{http_version} %{http_code} d:%{size_download} u:%{size_upload} %header{x-request-id} %header{x-influxdb-error}' -sX POST "http://${INFLUXDB_HOST}:${INFLUXDB_PORT}/write?db=$INFLUXDB_NAME" --data-binary @$c | awk '{print "     " $0}' | tail -1
        fi
      fi
    done
  fi
}

help() {
  echo
  echo "Usage:"
  echo
  echo "$0 convert /path/to/summary-raw-scenarios-multi.gz"
}

case "$1" in
  convert )
    if [ -f "$2" ]; then
      convert_to_influx influx "$2"
    else
      echo "error: $2 not does not exist"
    fi
    ;;
  convert-auto )
    if [ -f "$2" ]; then
      convert_to_influx influx "$2" auto
    else
      echo "error: $2 not does not exist"
    fi
    ;;
  * )
    help
    ;;
esac