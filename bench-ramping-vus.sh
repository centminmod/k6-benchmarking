#!/bin/bash
###############################################################################
# wrapper for k6 ramping-vus executor based benchmark-scenarios-multi.js
# https://github.com/centminmod/k6-benchmarking
###############################################################################
VER=0.8
WORKDIR="/home/k6-workdir"
SCRIPT_TESTNAME=ramping
# starting VU count
VU=0
# constant arrival rate VUs
VUS=10
TIME=30
REQRATE=100
STAGEVU1=25
STAGEVU2=50
STAGEVU3=100
STAGEVU4=0
VERBOSE='n'

# test wide tags
# https://k6.io/docs/using-k6/tags-and-groups/#test-wide-tags
ENABLE_GLOBAL_TAGS='y'
GLOBAL_TAG_VALUE='testname=rampingvus'

# Gzip compression test
GZIP_HTTP='y'

# 4 CPUS = 0-3
# 2 CPUS = 0-1
TASKSET_CPUS='0-3'
TASKSET_ENABLE='y'

# local -out
ENABLE_LOCAL_OUT='y'

# psrecord
PSRECORD_DELAY='15'

# InfluxDB data conversion
CONVERT_JSONLOG_INFLUXDB='y'
AUTO_INSERT_INFLUX_BATCH_DATA='y'
###############################################################################
if [ ! -f benchmark-scenarios-multi.js ]; then
  echo "error: benchmark-scenarios-multi.js not found"
  exit 1
fi
if [ ! -d "$WORKDIR" ]; then
  mkdir -p "$WORKDIR"
fi
if [[ "$ENABLE_GLOBAL_TAGS" = [Yy] ]]; then
  GLOBAL_TAG_OPTS=" --tag $GLOBAL_TAG_VALUE"
else
  GLOBAL_TAG_OPTS=""
fi
if [[ "$TASKSET_ENABLE" = [Yy] ]]; then
  TASKSET_OPT="taskset -c ${TASKSET_CPUS} "
else
  TASKSET_OPT=""
fi
if [[ "$ENABLE_LOCAL_OUT" = [yY] ]]; then
  LOCAL_OUT_FILENAME='summary-raw-scenarios-multi.gz'
  LOCAL_OUT_OPT="--out json=${WORKDIR}/$LOCAL_OUT_FILENAME "
else
  LOCAL_OUT_FILENAME=""
  LOCAL_OUT_OPT=""
fi
if [[ "$VERBOSE" = [yY] ]]; then
  VOPT=' -v'
else
  VOPT=""
  export XK6_BROWSER_LOG=error
fi
if [[ "$GZIP_HTTP" = [yY] ]]; then
  sed -i "s|\/\/    \"accept-encoding\": \"gzip, deflate\",|      \"accept-encoding\": \"gzip, deflate\",|" benchmark-scenarios-multi.js
else
  sed -i "s|      \"accept-encoding\": \"gzip, deflate\",|\/\/    \"accept-encoding\": \"gzip, deflate\",|" benchmark-scenarios-multi.js
fi

export K6_INFLUXDB_PAYLOAD_SIZE=100000
export K6_INFLUXDB_TAGS_AS_FIELDS=vu,tls_version,url,group,protocol
# export K6_INFLUXDB_USERNAME=
# export K6_INFLUXDB_PASSWORD=
###############################################################################

start_test() {
  echo "start k6 test"
  echo
  sysctl -w net.ipv4.tcp_tw_reuse=1 >/dev/null 2>&1
  ngxrestart >/dev/null 2>&1
  sleep 10
}

handlesummary_parsed() {
  input_summary=$1
  echo
  echo
  echo "     ##################################################################"
  cat $input_summary | jq -r '.metrics | [ ."http_reqs", ."http_req_duration{expected_response:true}" ] | .[]' | jq -n 'reduce inputs as $item ({}; . *= $item) | .values' | jq 'to_entries|map(.key),(map(.value)) | @tsv' | sed -e 's|\\t| |g' -e 's|\"||g' | column -t | awk '{print "     " $0}'
  echo
}

convert_benchlog() {
  input_output_file="$1"
  echo
  echo "     ##################################################################"
  echo "     parsing & converting k6 JSON output log $input_output_file"
  echo "     to InfluxDB batch write format..."
  sleep 5
  if [ -f ./tools/k6-log-to-influxdb.sh ]; then
    chmod +x ./tools/k6-log-to-influxdb.sh
  fi
  if [[ "$AUTO_INSERT_INFLUX_BATCH_DATA" = [yY] ]]; then
    echo "     ./tools/k6-log-to-influxdb.sh convert-auto $input_output_file"
    ./tools/k6-log-to-influxdb.sh convert-auto "$input_output_file"
  else
    echo "     ./tools/k6-log-to-influxdb.sh convert $input_output_file"
    ./tools/k6-log-to-influxdb.sh convert "$input_output_file"
  fi
}

parse_psrecord() {
  input_psrecord_file="$1"
  input_psrecord_sleep="$2"
  echo
  echo
  echo "     ##################################################################"
  echo "     parsing & converting nginx psrecord data..."
  echo "     waiting for psrecord to close its log..."
  sleep $input_psrecord_sleep
  if [ -f ./tools/psrecord-to-json.sh ]; then
    chmod +x ./tools/psrecord-to-json.sh
  fi
  if [[ "$AUTO_INSERT_INFLUX_BATCH_DATA" = [yY] ]]; then
    echo "     ./tools/psrecord-to-json.sh influx-auto $input_psrecord_file"
    ./tools/psrecord-to-json.sh influx-auto "$input_psrecord_file"
  else
    echo "     ./tools/psrecord-to-json.sh influx $input_psrecord_file"
    ./tools/psrecord-to-json.sh influx "$input_psrecord_file"
  fi
}

end_test() {
  sysctl -w net.ipv4.tcp_tw_reuse=0 >/dev/null 2>&1
  echo
  echo "k6 test completed"
}

cleanup() {
  find "$WORKDIR" -type f -name "*-split-*" -delete
  find "$WORKDIR" -type f -name "psrecord-ramping-*" -delete
  find "$WORKDIR" -type f -name "filtered-*" -delete
  find "$WORKDIR" -type f -name "influxdb-*" -delete
  find "$WORKDIR" -type f -name "*-nginx.png" -delete
  rm -f filtered-vus.log filtered-metrics.log influxdb-vus.log influxdb-metrics.log summary-raw-scenarios-multi.gz
  sleep 5
}

run_test() {
  INFLUXDB="$1"
  DOMAIN="$2"
  INPUT_TIME="$3"
  INPUT_STAGEVUS="$4"
  INPUT_REQRATE="$5"
  INPUT_VUS="$6"

  if [ -n "$INPUT_TIME" ]; then
    TIME="$INPUT_TIME"
  fi
  if [ -n "$INPUT_STAGEVUS" ]; then
    STAGEVU_ARRAY=($(echo "$INPUT_STAGEVUS"| sed 's|,| |g'))
    STAGEVU1="${STAGEVU_ARRAY[0]}"
    STAGEVU2="${STAGEVU_ARRAY[1]}"
    STAGEVU3="${STAGEVU_ARRAY[2]}"
    STAGEVU4="${STAGEVU_ARRAY[3]}"
  fi
  if [ -n "$INPUT_REQRATE" ]; then
    REQRATE="$INPUT_REQRATE"
  fi
  if [ -n "$INPUT_VUS" ]; then
    VUS="$INPUT_VUS"
  fi

  if [[ "$STAGEVU3" -le '299' ]]; then
    INFLUXDB_PUSH_INTERVAL_OPT=1.2s
    INFLUXDB_CONCURRENT_WRITES_OPT=200
  elif [[ "$STAGEVU3" -ge '300' && "$STAGEVU3" -le '599' ]]; then
    INFLUXDB_PUSH_INTERVAL_OPT=1.5s
    INFLUXDB_CONCURRENT_WRITES_OPT=200
  elif [[ "$STAGEVU3" -ge '600' && "$STAGEVU3" -le '899' ]]; then
    INFLUXDB_PUSH_INTERVAL_OPT=1.9s
    INFLUXDB_CONCURRENT_WRITES_OPT=200
  elif [[ "$STAGEVU3" -ge '900' && "$STAGEVU3" -le '1199' ]]; then
    INFLUXDB_PUSH_INTERVAL_OPT=1.9s
    INFLUXDB_CONCURRENT_WRITES_OPT=600
  elif [[ "$STAGEVU3" -ge '1200' && "$STAGEVU3" -le '1499' ]]; then
    INFLUXDB_PUSH_INTERVAL_OPT=2.9s
    INFLUXDB_CONCURRENT_WRITES_OPT=1000
  elif [[ "$STAGEVU3" -ge '1500' && "$STAGEVU3" -le '1799' ]]; then
    INFLUXDB_PUSH_INTERVAL_OPT=4.7s
    INFLUXDB_CONCURRENT_WRITES_OPT=2400
  elif [[ "$STAGEVU3" -ge '1800' && "$STAGEVU3" -le '1999' ]]; then
    INFLUXDB_PUSH_INTERVAL_OPT=6.1s
    INFLUXDB_CONCURRENT_WRITES_OPT=4800
  elif [[ "$STAGEVU3" -ge '2000' && "$STAGEVU3" -le '2199' ]]; then
    INFLUXDB_PUSH_INTERVAL_OPT=7.5s
    INFLUXDB_CONCURRENT_WRITES_OPT=16000
  fi
  export K6_INFLUXDB_PUSH_INTERVAL="$INFLUXDB_PUSH_INTERVAL_OPT"
  export K6_INFLUXDB_CONCURRENT_WRITES="$INFLUXDB_CONCURRENT_WRITES_OPT"

  start_test
  rm -f "${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.log"
  rm -f "${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.time.epoch.txt"
  rm -f "${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.time.human.txt"
  rm -f "${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.time.nanoseconds.txt"
  rm -f "${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.time.nanoseconds.original.txt"
  rm -f "${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.time.nanoseconds_brisbane.txt"
  # log psrecord date timestamps
  file_start_timestamp_epoch=$(date +%s)
  file_start_timestamp_human=$(date -d @$file_start_timestamp_epoch)
  file_start_timestamp_epoch_brisbane=$(TZ=Australia/Brisbane date -d "$file_start_timestamp_human" +%s)
  file_start_timestamp_human_brisbane=$(TZ=Australia/Brisbane date -d "$file_start_timestamp_human")
  file_start_timestamp_nanoseconds_brisbane=$(($file_start_timestamp_epoch_brisbane*1000000000))
  file_start_timestamp_nanoseconds=$(($file_start_timestamp_epoch*1000000000))
  echo "$file_start_timestamp_epoch" > ${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.time.epoch.txt
  echo "$file_start_timestamp_human" > ${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.time.human.txt
  echo "$file_start_timestamp_nanoseconds" > ${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.time.nanoseconds.txt
  echo "$file_start_timestamp_nanoseconds_brisbane" > ${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.time.nanoseconds_brisbane.txt
  # preserve timestamp
  touch -r ${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.time.nanoseconds.txt ${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.time.nanoseconds.original.txt
  touch -r ${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.time.nanoseconds_brisbane.txt ${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.time.nanoseconds_brisbane.original.txt
  echo "#####################################################################"
  echo "start time (Australia/Brisbane): $file_start_timestamp_human_brisbane"
  echo "start nanosecond time (Australia/Brisbane): $file_start_timestamp_nanoseconds_brisbane"
  echo "start time (UTC): $file_start_timestamp_human"
  echo "start nanosecond time (UTC): $file_start_timestamp_nanoseconds"
  echo "#####################################################################"
  echo
  spid=$(cminfo service-info nginx | jq -r '.MainPID')

  if [ -n "$spid" ]; then
    echo "psrecord $spid --include-children --interval 0.1 --duration $((TIME*6+PSRECORD_DELAY)) --log ${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.log --plot $WORKDIR/plot-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.png &"
    psrecord $spid --include-children --interval 0.1 --duration $((TIME*6+PSRECORD_DELAY)) --log ${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.log --plot $WORKDIR/plot-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.png &
    echo
  fi
  if [[ "$INFLUXDB" = [yY] ]]; then
    rm -f "psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus.log"
    echo "psrecord \"${TASKSET_OPT}k6 run${VOPT}${GLOBAL_TAG_OPTS} -e RPS=${REQRATE} -e REQRATE_USERS=${VUS} -e USERS=${VU} -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e URL=$DOMAIN --no-usage-report --out influxdb=http://localhost:8186/k6 benchmark-scenarios-multi.js\" --include-children --interval 0.1 --duration $((TIME*6+PSRECORD_DELAY)) --log ${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus.log --plot $WORKDIR/plot-${SCRIPT_TESTNAME}-${STAGEVU3}vus.png"
    psrecord "${TASKSET_OPT}k6 run${VOPT}${GLOBAL_TAG_OPTS} -e RPS=${REQRATE} -e REQRATE_USERS=${VUS} -e USERS=${VU} -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e URL=$DOMAIN --no-usage-report --out influxdb=http://localhost:8186/k6 benchmark-scenarios-multi.js" --include-children --interval 0.1 --duration $((TIME*6+PSRECORD_DELAY)) --log ${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus.log --plot $WORKDIR/plot-${SCRIPT_TESTNAME}-${STAGEVU3}vus.png
  else
    if [[ "$INFLUXDB" != [yY] && "$CONVERT_JSONLOG_INFLUXDB" = [yY] ]]; then
      # remove vu,tls_version,group,protocol from 
      # K6_INFLUXDB_TAGS_AS_FIELDS for local runs which opt to convert 
      # k6 JSON log output to InfluxDB batch line format as overhead for 
      # InfluxDB realtime ingestion is removed so no need to reduce tag count
      export K6_INFLUXDB_TAGS_AS_FIELDS=url
    fi
    echo "${TASKSET_OPT}k6 run${VOPT}${GLOBAL_TAG_OPTS} -e RPS=${REQRATE} -e REQRATE_USERS=${VUS} -e USERS=${VU} -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e URL=$DOMAIN --no-usage-report ${LOCAL_OUT_OPT}benchmark-scenarios-multi.js"
    ${TASKSET_OPT}k6 run${VOPT}${GLOBAL_TAG_OPTS} -e RPS=${REQRATE} -e REQRATE_USERS=${VUS} -e USERS=${VU} -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e URL=$DOMAIN --no-usage-report ${LOCAL_OUT_OPT}benchmark-scenarios-multi.js
  fi
  if [ -f summary-scenarios-htmlreport.json ]; then
    mv -f summary-scenarios-htmlreport.json "${WORKDIR}/summary-scenarios-htmlreport.json"
    handlesummary_parsed "${WORKDIR}/summary-scenarios-htmlreport.json"
  fi
  if [ -n "$spid" ]; then
    parse_psrecord "${WORKDIR}/psrecord-${SCRIPT_TESTNAME}-${STAGEVU3}vus-nginx.log" $((PSRECORD_DELAY*2))
  fi
  if [[ "$INFLUXDB" != [yY] && "$CONVERT_JSONLOG_INFLUXDB" = [yY] ]]; then
    convert_benchlog "${WORKDIR}/$LOCAL_OUT_FILENAME"
  fi
  end_test
}

help() {
  echo
  echo "Usage:"
  echo
  echo "$0 run-local https://domain.com"
  echo "$0 run-influxdb https://domain.com"
  echo "$0 run-local https://domain.com TIME 25,50,100,0"
  echo "$0 run-influxdb https://domain.com TIME 25,50,100,0"
  echo "$0 run-local https://domain.com TIME 25,50,100,0 REQRATE"
  echo "$0 run-influxdb https://domain.com TIME 25,50,100,0 REQRATE"
  echo "$0 run-local https://domain.com TIME 25,50,100,0 REQRATE REQRATE_USERS"
  echo "$0 run-influxdb https://domain.com TIME 25,50,100,0 REQRATE REQRATE_USERS"
}

case "$1" in
  run-local )
    if [ -n "$2" ]; then
      cleanup
      run_test n "$2" "$3" "$4" "$5" "$6"
    else
      help
    fi
    ;;
  run-influxdb )
    if [ -n "$2" ]; then
      cleanup
      run_test y "$2" "$3" "$4" "$5" "$6"
    else
      help
    fi
    ;;
  * )
    help
    ;;
esac