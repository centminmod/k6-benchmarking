#!/bin/bash
###############################################################################
# wrapper for k6 ramping-vus executor based benchmark-scenarios-multi.js
# https://github.com/centminmod/k6-benchmarking
###############################################################################
# starting VU count
VU=0
TIME=30
REQRATE=1
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
PSRECORD_DELAY='100'
###############################################################################
if [ ! -f benchmark-scenarios-multi.js ]; then
  echo "error: benchmark-scenarios-multi.js not found"
  exit 1
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
  LOCAL_OUT_OPT="--out json=summary-raw-scenarios-multi.gz "
else
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

parse_psrecord() {
  input_psrecord_file="$1"
  echo
  echo
  echo "     parsing and converting nginx psrecord data..."
  echo "     waiting for psrecord to close its log..."
  sleep 102
  echo "     ./tools/psrecord-to-json.sh influx $input_psrecord_file"
  ./tools/psrecord-to-json.sh influx "$input_psrecord_file"
}

end_test() {
  psrecord_file="$1"
  sysctl -w net.ipv4.tcp_tw_reuse=0 >/dev/null 2>&1
  parse_psrecord "${psrecord_file}.log"
  echo
  echo "k6 test completed"
}

run_test() {
  INFLUXDB="$1"
  DOMAIN="$2"
  INPUT_TIME="$3"
  INPUT_STAGEVUS="$4"

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
  rm -f "psrecord-ramping-${STAGEVU3}vus-nginx.log"
  rm -f "psrecord-ramping-${STAGEVU3}vus-nginx.time.epoch.txt"
  rm -f "psrecord-ramping-${STAGEVU3}vus-nginx.time.human.txt"
  rm -f "psrecord-ramping-${STAGEVU3}vus-nginx.time.nanoseconds.txt"
  rm -f "psrecord-ramping-${STAGEVU3}vus-nginx.time.nanoseconds.original.txt"
  rm -f "psrecord-ramping-${STAGEVU3}vus-nginx.time.nanoseconds_brisbane.txt"
  # log psrecord date timestamps
  file_start_timestamp_epoch=$(date +%s)
  file_start_timestamp_human=$(date -d @$file_start_timestamp_epoch)
  file_start_timestamp_epoch_brisbane=$(TZ=Australia/Brisbane date -d "$file_start_timestamp_human" +%s)
  file_start_timestamp_human_brisbane=$(TZ=Australia/Brisbane date -d "$file_start_timestamp_human")
  file_start_timestamp_nanoseconds_brisbane=$(($file_start_timestamp_epoch_brisbane*1000000000))
  file_start_timestamp_nanoseconds=$(($file_start_timestamp_epoch*1000000000))
  echo "$file_start_timestamp_epoch" > psrecord-ramping-${STAGEVU3}vus-nginx.time.epoch.txt
  echo "$file_start_timestamp_human" > psrecord-ramping-${STAGEVU3}vus-nginx.time.human.txt
  echo "$file_start_timestamp_nanoseconds" > psrecord-ramping-${STAGEVU3}vus-nginx.time.nanoseconds.txt
  echo "$file_start_timestamp_nanoseconds_brisbane" > psrecord-ramping-${STAGEVU3}vus-nginx.time.nanoseconds_brisbane.txt
  # preserve timestamp
  touch -r psrecord-ramping-${STAGEVU3}vus-nginx.time.nanoseconds.txt psrecord-ramping-${STAGEVU3}vus-nginx.time.nanoseconds.original.txt
  touch -r psrecord-ramping-${STAGEVU3}vus-nginx.time.nanoseconds_brisbane.txt psrecord-ramping-${STAGEVU3}vus-nginx.time.nanoseconds_brisbane.original.txt
  echo "#####################################################################"
  echo "start time (Australia/Brisbane): $file_start_timestamp_human_brisbane"
  echo "start nanosecond time (Australia/Brisbane): $file_start_timestamp_nanoseconds_brisbane"
  echo "start time (UTC): $file_start_timestamp_human"
  echo "start nanosecond time (UTC): $file_start_timestamp_nanoseconds"
  echo "#####################################################################"
  echo
  spid=$(cminfo service-info nginx | jq -r '.MainPID')

  echo "psrecord $spid --include-children --interval 0.1 --duration $((TIME*5+PSRECORD_DELAY)) --log psrecord-ramping-${STAGEVU3}vus-nginx.log --plot plot-ramping-${STAGEVU3}vus-nginx.png &"
  psrecord $spid --include-children --interval 0.1 --duration $((TIME*5+PSRECORD_DELAY)) --log psrecord-ramping-${STAGEVU3}vus-nginx.log --plot plot-ramping-${STAGEVU3}vus-nginx.png &
  echo
  if [[ "$INFLUXDB" = [yY] ]]; then
    rm -f "psrecord-ramping-${STAGEVU3}vus.log"
    echo "psrecord \"${TASKSET_OPT}k6 run${VOPT}${GLOBAL_TAG_OPTS} -e RPS=${REQRATE} -e USERS=${VU} -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e URL=$DOMAIN --no-usage-report --out influxdb=http://localhost:8186/k6 benchmark-scenarios-multi.js\" --include-children --interval 0.1 --duration $((TIME*5+PSRECORD_DELAY)) --log psrecord-ramping-${STAGEVU3}vus.log --plot plot-ramping-${STAGEVU3}vus.png"
    psrecord "${TASKSET_OPT}k6 run${VOPT}${GLOBAL_TAG_OPTS} -e RPS=${REQRATE} -e USERS=${VU} -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e URL=$DOMAIN --no-usage-report --out influxdb=http://localhost:8186/k6 benchmark-scenarios-multi.js" --include-children --interval 0.1 --duration $((TIME*5+PSRECORD_DELAY)) --log psrecord-ramping-${STAGEVU3}vus.log --plot plot-ramping-${STAGEVU3}vus.png
  else
    echo "${TASKSET_OPT}k6 run${VOPT}${GLOBAL_TAG_OPTS} -e RPS=${REQRATE} -e USERS=${VU} -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e URL=$DOMAIN --no-usage-report ${LOCAL_OUT_OPT}benchmark-scenarios-multi.js"
    ${TASKSET_OPT}k6 run${VOPT}${GLOBAL_TAG_OPTS} -e RPS=${REQRATE} -e USERS=${VU} -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e URL=$DOMAIN --no-usage-report ${LOCAL_OUT_OPT}benchmark-scenarios-multi.js
  fi
  end_test "psrecord-ramping-${STAGEVU3}vus-nginx"
}

help() {
  echo
  echo "Usage:"
  echo
  echo "$0 run-local https://domain.com"
  echo "$0 run-influxdb https://domain.com"
  echo "$0 run-local https://domain.com TIME 25,50,100,0"
  echo "$0 run-influxdb https://domain.com TIME 25,50,100,0"
}

case "$1" in
  run-local )
    if [ -n "$2" ]; then
      run_test n "$2" "$3" "$4"
    else
      help
    fi
    ;;
  run-influxdb )
    if [ -n "$2" ]; then
      run_test y "$2" "$3" "$4"
    else
      help
    fi
    ;;
  * )
    help
    ;;
esac