* `bench-ramping-vus.sh` wrapper script for k6 benchmarking using `ramping-vus` executor with defined duration of `30` seconds for 4 stage runs with VU user counts 25, 50, 100, 0 respectively. 
* Nginx CPU and memory usage stats are recorded via `psrecord` and parsed via [`psrecord-to-json.sh`](https://github.com/centminmod/k6-benchmarking/blob/master/tools/psrecord-to-json.md) tool for InfluxDB data format with the intention of being able to import the data into InfluxDB.

```
./bench-ramping-vus.sh

Usage:

./bench-ramping-vus.sh run-local https://domain.com
./bench-ramping-vus.sh run-influxdb https://domain.com
./bench-ramping-vus.sh run-local https://domain.com TIME 25,50,100,0
./bench-ramping-vus.sh run-influxdb https://domain.com TIME 25,50,100,0
```
```
./bench-ramping-vus.sh run-local https://domain1.com 30 25,50,100,0
start k6 test

psrecord 22558 --include-children --interval 0.1 --duration 250 --log psrecord-ramping-100vus-nginx.log --plot plot-ramping-100vus-nginx.png &

taskset -c 0-3 k6 run -e RPS=1 -e USERS=0 -e STAGETIME=30s -e STAGE_VU1=25 -e STAGE_VU2=50 -e STAGE_VU3=100 -e STAGE_VU4=0 -e URL=https://domain1.com --no-usage-report --out json=summary-raw-scenarios-multi.gz benchmark-scenarios-multi.js

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

Attaching to process 22558
  execution: local
     script: benchmark-scenarios-multi.js
     output: json (summary-raw-scenarios-multi.gz)

  scenarios: (100.00%) 1 scenario, 100 max VUs, 2m30s max duration (incl. graceful stop):
           * ramping_vus: Up to 100 looping VUs for 2m0s over 4 stages (gracefulRampDown: 1m0s, gracefulStop: 30s)


running (2m00.0s), 000/100 VUs, 633107 complete and 0 interrupted iterations
ramping_vus ✓ [======================================] 000/100 VUs  2m0s
INFO[0121] [k6-reporter v2.3.0] Generating HTML summary report  source=console
     ✓ is status 200

     checks.........................: 100.00% ✓ 633107      ✗ 0     
     data_received..................: 1.5 GB  13 MB/s
     data_sent......................: 25 MB   206 kB/s
     http_req_blocked...............: avg=2.2µs   min=96ns     med=213ns   max=49.74ms  p(95)=298ns    p(99)=388ns    p(99.99)=5.99ms   count=633107
     http_req_connecting............: avg=781ns   min=0s       med=0s      max=26.28ms  p(95)=0s       p(99)=0s       p(99.99)=918.32µs count=633107
     http_req_duration..............: avg=7.49ms  min=78.96µs  med=4.28ms  max=107.97ms p(95)=25ms     p(99)=38.42ms  p(99.99)=76.6ms   count=633107
       { expected_response:true }...: avg=7.49ms  min=78.96µs  med=4.28ms  max=107.97ms p(95)=25ms     p(99)=38.42ms  p(99.99)=76.6ms   count=633107
     http_req_failed................: 0.00%   ✓ 0           ✗ 633107
     http_req_receiving.............: avg=3.2ms   min=8.79µs   med=1.35ms  max=95.64ms  p(95)=12.73ms  p(99)=27.11ms  p(99.99)=62.24ms  count=633107
     http_req_sending...............: avg=94.48µs min=17.51µs  med=28.88µs max=80.25ms  p(95)=104.59µs p(99)=664.89µs p(99.99)=34.88ms  count=633107
     http_req_tls_handshaking.......: avg=1.17µs  min=0s       med=0s      max=33.73ms  p(95)=0s       p(99)=0s       p(99.99)=3.32ms   count=633107
     http_req_waiting...............: avg=4.2ms   min=0s       med=1.59ms  max=70.82ms  p(95)=16.45ms  p(99)=23ms     p(99.99)=47.48ms  count=633107
     http_reqs......................: 633107  5275.792054/s
     iteration_duration.............: avg=8.23ms  min=465.41µs med=4.92ms  max=108.85ms p(95)=26.39ms  p(99)=41.24ms  p(99.99)=79.75ms  count=633107
     iterations.....................: 633107  5275.792054/s
     vus............................: 1       min=0         max=99  
     vus_max........................: 100     min=100       max=100 

     parsing and converting nginx psrecord data...
     waiting for psrecord to close its log...
     ./tools/psrecord-to-json.sh influx psrecord-ramping-100vus-nginx.log
     2022-10-09 04:32:24.478233729 +0000
     file_start_timestamp_epoch=1665289944
     file_start_timestamp=1665289944000000000

     Saved InfluxDB formatted data files at:
     cpuload: cpuload.txt (761)
     realmem: realmem.txt (761)
     virtualmem: virtualmem.txt (761)

     InfluxDB import queries

     curl -i -sX POST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE psrecord"
     curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @cpuload.txt
     curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @realmem.txt
     curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @virtualmem.txt

k6 test completed
```