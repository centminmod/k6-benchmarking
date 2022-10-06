#!/bin/bash
###############################################################################
# wrapper for k6 ramping-vus executor based benchmark-scenarios-multi.js
# https://github.com/centminmod/k6-benchmarking
###############################################################################
# starting VU count
VU=0
TIME=5
REQRATE=1
STAGEVU1=25
STAGEVU2=50
STAGEVU3=100
STAGEVU4=0

export K6_INFLUXDB_PUSH_INTERVAL=1.9s
export K6_INFLUXDB_CONCURRENT_WRITES=30
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
  psrecord $spid --include-children --interval 0.1 --duration $((TIME*5+90)) --log psrecord-ramping-vus-nginx.log --plot plot-ramping-vus-nginx.png &
  if [[ "$INFLUXDB" = [yY] ]]; then
    psrecord "taskset -c 0-3 k6 run -e RPS=${REQRATE} -e USERS=${VU} -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e URL=$DOMAIN --no-usage-report --out influxdb=http://localhost:8186/k6 benchmark-scenarios-multi.js" --include-children --interval 0.1 --duration $((TIME*5+90)) --log psrecord-ramping-vus.log --plot plot-ramping-vus.png
  else
    taskset -c 0-3 k6 run -e RPS=${REQRATE} -e USERS=${VU} -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e URL=$DOMAIN --no-usage-report --out json=summary-raw-scenarios-multi.gz benchmark-scenarios-multi.js
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