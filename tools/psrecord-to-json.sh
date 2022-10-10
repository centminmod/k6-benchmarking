#!/bin/bash
###############################################################################
# convert psrecord activity files to json format for use with influxdb
# https://docs.influxdata.com/influxdb/v1.8/guides/write_data/#writing-points-from-a-file
###############################################################################
# break to 5000 size batches for InfluxDB
SPLITSIZE='5000'
###############################################################################
if [ ! -f /usr/bin/jq ]; then
  yum -y -q install jq
fi

converter() {
  mode="$1"
  file="$2"
  file_ns=$(echo "$file" | sed -e 's|.log|.time.nanoseconds.txt|')
  file_ns_brisbane=$(echo "$file" | sed -e 's|.log|.time.nanoseconds_brisbane.txt|')
  file_ns_original=$(echo "$file" | sed -e 's|.log|.time.nanoseconds.original.txt|')
  file_ns_original_brisbane=$(echo "$file" | sed -e 's|.log|.time.nanoseconds_brisbane.original.txt|')
  # use preserved timestamp
  touch -r "$file_ns_original" "$file"
  if [[ "$mode" = 'json' ]]; then
    cat "$file" | sed -e '1d' | column -t | tr -s ' ' | jq -nR '[inputs | split(" ") | { "time": .[0], "cpuload": .[1], "realmem": .[2], "virtualmem": .[3] }]'
  elif [[ "$mode" = 'influx' ]]; then
    # split produced json data into 3 measurements for
    # cpuload, realmem, virtualmem and their respective values

    # nanoseconds of file last access
    if [ -f "$file_ns" ]; then
      file_time="$file_ns"
      file_start_timestamp_nanoseconds=$(cat $file_time)
      file_start_timestamp="$file_start_timestamp_nanoseconds"
      file_start_timestamp_epoch=$(($file_start_timestamp/1000000000))
      file_start_timestamp_brisbane=$(TZ=Australia/Brisbane date -d @"$(($file_start_timestamp/1000000000))")
      file_start_timestamp_nanoseconds_brisbane=$(TZ=Australia/Brisbane date -d @"$(($file_start_timestamp/1000000000))" +%s%N)
      file_end_timestamp=$(stat --format='%Z' $file)
      file_end_timestamp_human=$(date -d @$file_end_timestamp)
      file_end_timestamp_human_brisbane=$(TZ=Australia/Brisbane date -d @$file_end_timestamp)
      file_end_timestamp_nanoseconds=$(($file_end_timestamp * 1000000000))
    else
      file_time="$file"
      file_start_timestamp_epoch=$(stat --format='%Z' $file_time)
      file_start_timestamp=$(date -d @${file_start_timestamp_epoch} +%s%N)
      file_start_timestamp_epoch=$(($file_start_timestamp/1000000000))
      file_start_timestamp_brisbane=$(TZ=Australia/Brisbane date -d @"$(($file_start_timestamp/1000000000))")
      file_start_timestamp_nanoseconds_brisbane=$(TZ=Australia/Brisbane date -d @"$(($file_start_timestamp/1000000000))" +%s%N)
      file_end_timestamp=$(stat --format='%Z' $file)
      file_end_timestamp_human=$(date -d @$file_end_timestamp)
      file_end_timestamp_human_brisbane=$(TZ=Australia/Brisbane date -d @$file_end_timestamp)
      file_end_timestamp_nanoseconds=$(($file_end_timestamp * 1000000000))
    fi
    echo "     start time (Australia/Brisbane : $(TZ=Australia/Brisbane date -d @$file_start_timestamp_epoch)"
    echo "     end time (Australia/Brisbane ): $file_end_timestamp_human_brisbane"
    echo "     start time (UTC): $(date -d @$file_start_timestamp_epoch)"
    echo "     end time (UTC): $file_end_timestamp_human"
    echo "     file_start_timestamp (Australia/Brisbane) = $file_start_timestamp_nanoseconds_brisbane"
    echo "     file_start_timestamp (UTC) = $file_start_timestamp"
    echo "     file_start_timestamp_epoch (UTC) = $file_start_timestamp_epoch"
    echo "     file_end_timestamp (UTC) = $file_end_timestamp"
    jsondata=$(cat "$file" | sed -e '1d' | column -t | tr -s ' ' | jq -nR '[inputs | split(" ") | { "time": .[0], "cpuload": .[1], "realmem": .[2], "virtualmem": .[3] }]')
    jsondata_cpu=$(echo "$jsondata" | jq -r '.[] | {time: .time, cpuload: .cpuload}' | jq --arg t "$file_start_timestamp" -r '"cpuload,app=nginx value=\(.cpuload) \((.time|tonumber*1000000000)+($t|tonumber))"')
    jsondata_rmem=$(echo "$jsondata" | jq -r '.[] | {time: .time, realmem: .realmem}' | jq --arg t "$file_start_timestamp" -r '"realmem,app=nginx value=\(.realmem) \((.time|tonumber*1000000000)+($t|tonumber))"')
    jsondata_vmem=$(echo "$jsondata" | jq -r '.[] | {time: .time, virtualmem: .virtualmem}' | jq --arg t "$file_start_timestamp" -r '"virtualmem,app=nginx value=\(.virtualmem) \((.time|tonumber*1000000000)+($t|tonumber))"')

    # save influxdb formatted data files to be inserted via
    # curl -i -sX POST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE psrecord"
    # curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @cpuload.txt
    # curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @realmem.txt
    # curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @virtualmem.txt
    rm -f cpuload.txt realmem.txt virtualmem.txt
    echo "$jsondata_cpu" > cpuload.txt
    echo "$jsondata_rmem" > realmem.txt
    echo "$jsondata_vmem" > virtualmem.txt
    count_cpu=$(cat cpuload.txt|wc -l)
    count_rmem=$(cat realmem.txt|wc -l)
    count_vmem=$(cat virtualmem.txt|wc -l)
    # optimize for influxdb 5000 batch size
    if [[ "$count_cpu" -gt "$SPLITSIZE" ]]; then
      split -l "$SPLITSIZE" cpuload.txt cpuload-split-
      split -l "$SPLITSIZE" realmem.txt realmem-split-
      split -l "$SPLITSIZE" virtualmem.txt virtualmem-split-
      echo
      echo "     Saved InfluxDB formatted data files at:"
      find . -type f -name "cpuload-split-*" | while read f; do
        fn=$(basename $f)
        count_cpu=$(cat $fn|wc -l)
        echo "     cpuload: $fn ($count_cpu)"
      done
      find . -type f -name "realmem-split-*" | while read f; do
        fn=$(basename $f)
        count_rmem=$(cat $fn|wc -l)
        echo "     realmem: $fn ($count_rmem)"
      done
      find . -type f -name "virtualmem-split-*" | while read f; do
        fn=$(basename $f)
        count_vmem=$(cat $fn|wc -l)
        echo "     virtualmem: $fn ($count_vmem)"
      done
      echo
      echo "     InfluxDB import queries"
      echo
      echo "curl -i -sX POST http://localhost:8186/query --data-urlencode \"q=CREATE DATABASE psrecord\""
      find . -type f -name "*-split-*" | sort | while read f; do
        fn=$(basename $f)
        echo "     curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @$fn"
      done
    else
      echo
      echo "     Saved InfluxDB formatted data files at:"
      echo "     cpuload: cpuload.txt ($count_cpu)"
      echo "     realmem: realmem.txt ($count_rmem)"
      echo "     virtualmem: virtualmem.txt ($count_vmem)"
      echo
      echo "     InfluxDB import queries"
      echo
      echo "     curl -i -sX POST http://localhost:8186/query --data-urlencode \"q=CREATE DATABASE psrecord\""
      echo "     curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @cpuload.txt"
      echo "     curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @realmem.txt"
      echo "     curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @virtualmem.txt"
      echo
      echo "     Grafana Dashboard Time Frame"
      echo "     ?orgId=1&from=$file_start_timestamp_epoch&to=$file_end_timestamp"
    fi
  fi
}

nano_to_epoch() {
  ep=$1
  epo=$(echo $((ep/1000000000)))
  epoh=$(date -d @$epo)
  echo $epo
  echo $epoh
}

epoch_to_nano() {
  ep=$1
  epoh=$(date -d @$ep)
  epo=$(echo $((ep * 1000000000)))
  echo $epo
  echo $epoh
}

help() {
  echo
  echo "Usage:"
  echo
  echo "$0 json psrecord_file.log"
  echo "$0 influx psrecord_file.log"
  echo
  echo "nanosecond to epoch converter"
  echo "$0 nsepoch 1665324009800353614"
  echo
  echo "epoch to nanosecond converter"
  echo "$0 epochns 1665324009"
}

case "$1" in
  json )
    if [ -f "$2" ]; then
      converter json "$2"
    else
      echo "error: $2 not does not exist"
    fi
    ;;
  influx )
    if [ -f "$2" ]; then
      converter influx "$2"
    else
      echo "error: $2 not does not exist"
    fi
    ;;
  nsepoch )
    nano_to_epoch "$2"
    ;;
  epochns )
    epoch_to_nano "$2"
    ;;
  * )
    help
    ;;
esac