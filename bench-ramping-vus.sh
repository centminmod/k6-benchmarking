#!/bin/bash
###############################################################################
# wrapper for k6 ramping-vus executor based benchmark-scenarios-multi.js
# https://github.com/centminmod/k6-benchmarking
###############################################################################
# starting VU count
VU=0
TIME=15
REQRATE=1
STAGEVU1=10
STAGEVU2=15
STAGEVU3=20
STAGEVU4=0
VERBOSE='n'

# 4 CPUS = 0-3
# 2 CPUS = 0-1
TASKSET_CPUS='0-3'
###############################################################################
if [[ "$VERBOSE" = [yY] ]]; then
  VOPT=' -v'
else
  VOPT=""
fi
if [[ "$STAGEVU3" -le '599' ]]; then
  K6_INFLUXDB_PUSH_INTERVAL_OPT=1.2s
  K6_INFLUXDB_CONCURRENT_WRITES_OPT=100
elif [[ "$STAGEVU3" -ge '600' && "$STAGEVU3" -le '899' ]]; then
  K6_INFLUXDB_PUSH_INTERVAL_OPT=1.9s
  K6_INFLUXDB_CONCURRENT_WRITES_OPT=200
elif [[ "$STAGEVU3" -ge '900' && "$STAGEVU3" -le '1199' ]]; then
  K6_INFLUXDB_PUSH_INTERVAL_OPT=1.9s
  K6_INFLUXDB_CONCURRENT_WRITES_OPT=600
elif [[ "$STAGEVU3" -ge '1200' && "$STAGEVU3" -le '1499' ]]; then
  K6_INFLUXDB_PUSH_INTERVAL_OPT=2.9s
  K6_INFLUXDB_CONCURRENT_WRITES_OPT=1000
elif [[ "$STAGEVU3" -ge '1500' && "$STAGEVU3" -le '1799' ]]; then
  K6_INFLUXDB_PUSH_INTERVAL_OPT=4.7s
  K6_INFLUXDB_CONCURRENT_WRITES_OPT=2400
elif [[ "$STAGEVU3" -ge '1800' && "$STAGEVU3" -le '1999' ]]; then
  K6_INFLUXDB_PUSH_INTERVAL_OPT=6.1s
  K6_INFLUXDB_CONCURRENT_WRITES_OPT=4800
elif [[ "$STAGEVU3" -ge '2000' && "$STAGEVU3" -le '2199' ]]; then
  K6_INFLUXDB_PUSH_INTERVAL_OPT=7.5s
  K6_INFLUXDB_CONCURRENT_WRITES_OPT=16000
fi
export K6_INFLUXDB_PUSH_INTERVAL="$K6_INFLUXDB_PUSH_INTERVAL_OPT"
export K6_INFLUXDB_CONCURRENT_WRITES="$K6_INFLUXDB_CONCURRENT_WRITES_OPT"
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

end_test() {
  sysctl -w net.ipv4.tcp_tw_reuse=0 >/dev/null 2>&1
  echo
  echo "k6 test completed"
}

run_test() {
  INFLUXDB="$1"
  DOMAIN="$2"
  start_test
  spid=$(cminfo service-info nginx | jq -r '.MainPID')
  echo "psrecord $spid --include-children --interval 0.1 --duration $((TIME*5+100)) --log psrecord-ramping-${STAGEVU3}vus-nginx.log --plot plot-ramping-${STAGEVU3}vus-nginx.png &"
  psrecord $spid --include-children --interval 0.1 --duration $((TIME*5+100)) --log psrecord-ramping-${STAGEVU3}vus-nginx.log --plot plot-ramping-${STAGEVU3}vus-nginx.png &
  echo
  if [[ "$INFLUXDB" = [yY] ]]; then
    echo "psrecord \"taskset -c ${TASKSET_CPUS} k6 run${VOPT} -e RPS=${REQRATE} -e USERS=${VU} -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e URL=$DOMAIN --no-usage-report --out influxdb=http://localhost:8186/k6 benchmark-scenarios-multi.js\" --include-children --interval 0.1 --duration $((TIME*5+100)) --log psrecord-ramping-${STAGEVU3}vus.log --plot plot-ramping-${STAGEVU3}vus.png"
    psrecord "taskset -c ${TASKSET_CPUS} k6 run${VOPT} -e RPS=${REQRATE} -e USERS=${VU} -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e URL=$DOMAIN --no-usage-report --out influxdb=http://localhost:8186/k6 benchmark-scenarios-multi.js" --include-children --interval 0.1 --duration $((TIME*5+100)) --log psrecord-ramping-${STAGEVU3}vus.log --plot plot-ramping-${STAGEVU3}vus.png
  else
    echo "taskset -c ${TASKSET_CPUS} k6 run${VOPT} -e RPS=${REQRATE} -e USERS=${VU} -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e URL=$DOMAIN --no-usage-report --out json=summary-raw-scenarios-multi.gz benchmark-scenarios-multi.js"
    taskset -c ${TASKSET_CPUS} k6 run${VOPT} -e RPS=${REQRATE} -e USERS=${VU} -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e URL=$DOMAIN --no-usage-report --out json=summary-raw-scenarios-multi.gz benchmark-scenarios-multi.js
  fi
  end_test
}

help() {
  echo
  echo "Usage:"
  echo
  echo "$0 run-local https://domain.com"
  echo "$0 run-influxdb https://domain.com"
}

case "$1" in
  run-local )
    if [ -n "$2" ]; then
      run_test n "$2"
    else
      help
    fi
    ;;
  run-influxdb )
    if [ -n "$2" ]; then
      run_test y "$2"
    else
      help
    fi
    ;;
  * )
    help
    ;;
esac