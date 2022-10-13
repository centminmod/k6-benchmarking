* `bench-ramping-vus.sh` wrapper script for k6 benchmarking using `ramping-vus` executor with defined duration of `180` seconds for 4 stage runs with VU user counts 5000, 10000, 15000, 0 respectively + `constant-arrival-rate` executor with constant request rate of 5,000 requests/s with 16,000 to 150,000 range of VUs with defined duration of `180` seconds. Also a random sleep time of between 1.5s to 4.5s for more realistic visitor usage patterns.
* Nginx CPU and memory usage stats are recorded via `psrecord` and parsed via [`psrecord-to-json.sh`](https://github.com/centminmod/k6-benchmarking/blob/master/tools/psrecord-to-json.md) tool for InfluxDB data format with the intention of being able to import the data into InfluxDB. [InfluxDB/Grafana charts here](#influxdb-data-source-grafana-dashboard-charts).
* `run-local` run with k6 benchmark with `--out json=summary-raw-scenarios-multi.gz` JSON logged output and convert it into [InfluxDB 1.8 batch line write format](https://docs.influxdata.com/influxdb/v1.8/guides/write_data/#writing-points-from-a-file) for post-k6 run insertion into InfluxDB 1.8 database using [`k6-log-to-influxdb`](https://github.com/centminmod/k6-benchmarking/blob/master/tools/k6-log-to-influxdb.md) tool. [InfluxDB/Grafana charts here](#influxdb-data-source-grafana-dashboard-charts).

```
./bench-ramping-vus.sh

Usage:

./bench-ramping-vus.sh run-local https://domain.com
./bench-ramping-vus.sh run-influxdb https://domain.com
./bench-ramping-vus.sh run-local https://domain.com TIME 25,50,100,0
./bench-ramping-vus.sh run-influxdb https://domain.com TIME 25,50,100,0
./bench-ramping-vus.sh run-local https://domain.com TIME 25,50,100,0 REQRATE
./bench-ramping-vus.sh run-influxdb https://domain.com TIME 25,50,100,0 REQRATE
./bench-ramping-vus.sh run-local https://domain.com TIME 25,50,100,0 REQRATE REQRATE_USERS
./bench-ramping-vus.sh run-influxdb https://domain.com TIME 25,50,100,0 REQRATE REQRATE_USERS
```
```
./bench-ramping-vus.sh run-local https://domain1.com 180 5000,10000,15000,0 5000 16000
start k6 test

#####################################################################
start time (Australia/Brisbane): Fri Oct 14 02:40:54 AEST 2022
start nanosecond time (Australia/Brisbane): 1665679254000000000
start time (UTC): Thu Oct 13 16:40:54 UTC 2022
start nanosecond time (UTC): 1665679254000000000
#####################################################################

psrecord 19359 --include-children --interval 0.1 --duration 1095 --log /home/k6-workdir/psrecord-ramping-15000vus-nginx.log --plot /home/k6-workdir/plot-ramping-15000vus-nginx.png &

taskset -c 0-3 k6 run --tag testname=rampingvus -e RPS=5000 -e REQRATE_USERS=16000 -e USERS=0 -e STAGETIME=180s -e STAGE_VU1=5000 -e STAGE_VU2=10000 -e STAGE_VU3=15000 -e STAGE_VU4=0 -e URL=https://domain1.com --no-usage-report --out json=/home/k6-workdir/summary-raw-scenarios-multi.gz benchmark-scenarios-multi.js

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

Attaching to process 19359
  execution: local
     script: benchmark-scenarios-multi.js
     output: json (/home/k6-workdir/summary-raw-scenarios-multi.gz)

  scenarios: (100.00%) 2 scenarios, 150000 max VUs, 15m23s max duration (incl. graceful stop):
           * constant_arrival_rate: 5000.00 iterations/s for 3m0s (maxVUs: 16000-150000, exec: constantarrival, gracefulStop: 5s)
           * ramping_vus: Up to 15000 looping VUs for 12m0s over 4 stages (gracefulRampDown: 5s, exec: default, startTime: 3m18s, gracefulStop: 5s)


running (15m22.6s), 000000/016000 VUs, 2707350 complete and 2 interrupted iterations
constant_arrival_rate ✓ [======================================] 000000/016000 VUs  3m0s  5000.00 iters/s
ramping_vus           ✓ [======================================] 00000/15000 VUs    12m0s
INFO[0931] [k6-reporter v2.3.0] Generating HTML summary report  source=console
     ✓ is status 200

     checks.........................: 100.00% ✓ 2707352     ✗ 0      
     data_received..................: 6.5 GB  7.0 MB/s
     data_sent......................: 122 MB  132 kB/s
     http_req_blocked...............: avg=7.18ms   min=132ns    med=248ns    max=2.41s    p(95)=367ns    p(99)=792.56µs p(99.99)=1.94s    count=2707352
     http_req_connecting............: avg=3.38ms   min=0s       med=0s       max=1.73s    p(95)=0s       p(99)=70.6µs   p(99.99)=1.02s    count=2707352
     http_req_duration..............: avg=3.93ms   min=167.36µs med=241.02µs max=1.75s    p(95)=1.32ms   p(99)=17.46ms  p(99.99)=1.03s    count=2707352
       { expected_response:true }...: avg=3.93ms   min=167.36µs med=241.02µs max=1.75s    p(95)=1.32ms   p(99)=17.46ms  p(99.99)=1.03s    count=2707352
     http_req_failed................: 0.00%   ✓ 0           ✗ 2707352
     http_req_receiving.............: avg=176.86µs min=7.85µs   med=19.12µs  max=1.11s    p(95)=205.75µs p(99)=2.1ms    p(99.99)=70.45ms  count=2707352
     http_req_sending...............: avg=87.23µs  min=18.38µs  med=28.61µs  max=890.98ms p(95)=262.05µs p(99)=601.72µs p(99.99)=27.21ms  count=2707352
     http_req_tls_handshaking.......: avg=3.77ms   min=0s       med=0s       max=1.58s    p(95)=0s       p(99)=645.25µs p(99.99)=928.06ms count=2707352
     http_req_waiting...............: avg=3.67ms   min=0s       med=174.41µs max=1.16s    p(95)=860.58µs p(99)=14.12ms  p(99.99)=995.83ms count=2707352
     http_reqs......................: 2707352 2934.531442/s
     iteration_duration.............: avg=2.01s    min=206.09µs med=2s       max=5.03s    p(95)=5s       p(99)=5s       p(99.99)=5.01s    count=2707351
     iterations.....................: 2707351 2934.530359/s
     vus............................: 1       min=0         max=16000
     vus_max........................: 16000   min=3089      max=16000

     ##################################################################
     parsing & converting nginx psrecord data...
     waiting for psrecord to close its log...
     ./tools/psrecord-to-json.sh influx-auto /home/k6-workdir/psrecord-ramping-15000vus-nginx.log
     start time (Australia/Brisbane : Fri Oct 14 02:40:54 AEST 2022
     end time (Australia/Brisbane ): Fri Oct 14 02:56:57 AEST 2022
     start time (UTC): Thu Oct 13 16:40:54 UTC 2022
     end time (UTC): Thu Oct 13 16:56:57 UTC 2022
     file_start_timestamp (Australia/Brisbane) = 1665679254000000000
     file_start_timestamp (UTC) = 1665679254000000000
     file_start_timestamp_epoch (UTC) = 1665679254
     file_end_timestamp (UTC) = 1665680217

     Saved InfluxDB formatted data files at:
     cpuload: /home/k6-workdir/cpuload-split-aa (5000)
     cpuload: /home/k6-workdir/cpuload-split-ab (3628)
     realmem: /home/k6-workdir/realmem-split-aa (5000)
     realmem: /home/k6-workdir/realmem-split-ab (3628)
     virtualmem: /home/k6-workdir/virtualmem-split-aa (5000)
     virtualmem: /home/k6-workdir/virtualmem-split-ab (3628)

     InfluxDB import queries

     curl -i -sX POST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE psrecord"
     # create InfluxDB database: psrecord...
     HTTP/1.1 200 OK
     curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @/home/k6-workdir/cpuload-split-aa
     # auto insert data into InfluxDB database: psrecord...
     HTTP/1.1 204 No Content
     curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @/home/k6-workdir/cpuload-split-ab
     # auto insert data into InfluxDB database: psrecord...
     HTTP/1.1 204 No Content
     curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @/home/k6-workdir/realmem-split-aa
     # auto insert data into InfluxDB database: psrecord...
     HTTP/1.1 204 No Content
     curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @/home/k6-workdir/realmem-split-ab
     # auto insert data into InfluxDB database: psrecord...
     HTTP/1.1 204 No Content
     curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @/home/k6-workdir/virtualmem-split-aa
     # auto insert data into InfluxDB database: psrecord...
     HTTP/1.1 204 No Content
     curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @/home/k6-workdir/virtualmem-split-ab
     # auto insert data into InfluxDB database: psrecord...
     HTTP/1.1 204 No Content

     ##################################################################
     parsing & converting k6 JSON output log /home/k6-workdir/summary-raw-scenarios-multi.gz
     to InfluxDB batch write format...
     ./tools/k6-log-to-influxdb.sh convert-auto /home/k6-workdir/summary-raw-scenarios-multi.gz

     filter VUs metrics to /home/k6-workdir/filtered-vus.log
     filter all metrics to /home/k6-workdir/filtered-metrics.log
     convert VUs log to InfluxDB format at /home/k6-workdir/influxdb-vus.log
     convert all metrics logs to InfluxDB format at /home/k6-workdir/influxdb-metrics.log

     Saved InfluxDB formatted data files (928 lines) at:
     /home/k6-workdir/influxdb-vus.log (928)

     InfluxDB import queries

     curl -i -sX POST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE k6"
     # create InfluxDB database: k6...
     HTTP/1.1 200 OK
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-vus.log
     # auto insert /home/k6-workdir/ into InfluxDB database: k6...
     HTTP/1.1 204 No Content

     Saved & Split InfluxDB formatted data files (24366168 lines) at:
     /home/k6-workdir/influxdb-metrics.log-split-aa (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ab (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ac (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ad (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ae (50000)
     /home/k6-workdir/influxdb-metrics.log-split-af (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ag (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ah (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ai (50000)
     /home/k6-workdir/influxdb-metrics.log-split-aj (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ak (50000)
     /home/k6-workdir/influxdb-metrics.log-split-al (50000)
     /home/k6-workdir/influxdb-metrics.log-split-am (50000)
     /home/k6-workdir/influxdb-metrics.log-split-an (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ao (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ap (50000)
     /home/k6-workdir/influxdb-metrics.log-split-aq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ar (50000)
     /home/k6-workdir/influxdb-metrics.log-split-as (50000)
     /home/k6-workdir/influxdb-metrics.log-split-at (50000)
     /home/k6-workdir/influxdb-metrics.log-split-au (50000)
     /home/k6-workdir/influxdb-metrics.log-split-av (50000)
     /home/k6-workdir/influxdb-metrics.log-split-aw (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ax (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ay (50000)
     /home/k6-workdir/influxdb-metrics.log-split-az (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ba (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bb (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bc (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bd (50000)
     /home/k6-workdir/influxdb-metrics.log-split-be (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bf (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bg (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bh (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bi (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bj (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bk (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bl (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bm (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bn (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bo (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bp (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-br (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bs (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bt (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bu (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bv (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bw (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bx (50000)
     /home/k6-workdir/influxdb-metrics.log-split-by (50000)
     /home/k6-workdir/influxdb-metrics.log-split-bz (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ca (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cb (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cc (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cd (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ce (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cf (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cg (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ch (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ci (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cj (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ck (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cl (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cm (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cn (50000)
     /home/k6-workdir/influxdb-metrics.log-split-co (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cp (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cr (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cs (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ct (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cu (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cv (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cw (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cx (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cy (50000)
     /home/k6-workdir/influxdb-metrics.log-split-cz (50000)
     /home/k6-workdir/influxdb-metrics.log-split-da (50000)
     /home/k6-workdir/influxdb-metrics.log-split-db (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dc (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dd (50000)
     /home/k6-workdir/influxdb-metrics.log-split-de (50000)
     /home/k6-workdir/influxdb-metrics.log-split-df (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dg (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dh (50000)
     /home/k6-workdir/influxdb-metrics.log-split-di (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dj (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dk (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dl (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dm (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dn (50000)
     /home/k6-workdir/influxdb-metrics.log-split-do (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dp (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dr (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ds (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dt (50000)
     /home/k6-workdir/influxdb-metrics.log-split-du (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dv (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dw (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dx (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dy (50000)
     /home/k6-workdir/influxdb-metrics.log-split-dz (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ea (50000)
     /home/k6-workdir/influxdb-metrics.log-split-eb (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ec (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ed (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ee (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ef (50000)
     /home/k6-workdir/influxdb-metrics.log-split-eg (50000)
     /home/k6-workdir/influxdb-metrics.log-split-eh (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ei (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ej (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ek (50000)
     /home/k6-workdir/influxdb-metrics.log-split-el (50000)
     /home/k6-workdir/influxdb-metrics.log-split-em (50000)
     /home/k6-workdir/influxdb-metrics.log-split-en (50000)
     /home/k6-workdir/influxdb-metrics.log-split-eo (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ep (50000)
     /home/k6-workdir/influxdb-metrics.log-split-eq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-er (50000)
     /home/k6-workdir/influxdb-metrics.log-split-es (50000)
     /home/k6-workdir/influxdb-metrics.log-split-et (50000)
     /home/k6-workdir/influxdb-metrics.log-split-eu (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ev (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ew (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ex (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ey (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ez (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fa (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fb (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fc (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fd (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fe (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ff (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fg (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fh (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fi (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fj (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fk (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fl (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fm (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fn (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fo (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fp (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fr (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fs (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ft (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fu (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fv (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fw (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fx (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fy (50000)
     /home/k6-workdir/influxdb-metrics.log-split-fz (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ga (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gb (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gc (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gd (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ge (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gf (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gg (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gh (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gi (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gj (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gk (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gl (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gm (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gn (50000)
     /home/k6-workdir/influxdb-metrics.log-split-go (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gp (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gr (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gs (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gt (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gu (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gv (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gw (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gx (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gy (50000)
     /home/k6-workdir/influxdb-metrics.log-split-gz (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ha (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hb (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hc (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hd (50000)
     /home/k6-workdir/influxdb-metrics.log-split-he (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hf (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hg (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hh (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hi (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hj (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hk (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hl (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hm (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hn (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ho (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hp (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hr (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hs (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ht (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hu (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hv (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hw (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hx (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hy (50000)
     /home/k6-workdir/influxdb-metrics.log-split-hz (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ia (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ib (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ic (50000)
     /home/k6-workdir/influxdb-metrics.log-split-id (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ie (50000)
     /home/k6-workdir/influxdb-metrics.log-split-if (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ig (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ih (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ii (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ij (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ik (50000)
     /home/k6-workdir/influxdb-metrics.log-split-il (50000)
     /home/k6-workdir/influxdb-metrics.log-split-im (50000)
     /home/k6-workdir/influxdb-metrics.log-split-in (50000)
     /home/k6-workdir/influxdb-metrics.log-split-io (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ip (50000)
     /home/k6-workdir/influxdb-metrics.log-split-iq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ir (50000)
     /home/k6-workdir/influxdb-metrics.log-split-is (50000)
     /home/k6-workdir/influxdb-metrics.log-split-it (50000)
     /home/k6-workdir/influxdb-metrics.log-split-iu (50000)
     /home/k6-workdir/influxdb-metrics.log-split-iv (50000)
     /home/k6-workdir/influxdb-metrics.log-split-iw (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ix (50000)
     /home/k6-workdir/influxdb-metrics.log-split-iy (50000)
     /home/k6-workdir/influxdb-metrics.log-split-iz (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ja (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jb (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jc (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jd (50000)
     /home/k6-workdir/influxdb-metrics.log-split-je (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jf (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jg (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jh (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ji (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jj (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jk (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jl (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jm (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jn (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jo (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jp (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jr (50000)
     /home/k6-workdir/influxdb-metrics.log-split-js (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jt (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ju (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jv (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jw (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jx (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jy (50000)
     /home/k6-workdir/influxdb-metrics.log-split-jz (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ka (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kb (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kc (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kd (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ke (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kf (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kg (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kh (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ki (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kj (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kk (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kl (50000)
     /home/k6-workdir/influxdb-metrics.log-split-km (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kn (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ko (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kp (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kr (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ks (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kt (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ku (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kv (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kw (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kx (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ky (50000)
     /home/k6-workdir/influxdb-metrics.log-split-kz (50000)
     /home/k6-workdir/influxdb-metrics.log-split-la (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lb (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lc (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ld (50000)
     /home/k6-workdir/influxdb-metrics.log-split-le (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lf (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lg (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lh (50000)
     /home/k6-workdir/influxdb-metrics.log-split-li (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lj (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lk (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ll (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lm (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ln (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lo (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lp (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lr (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ls (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lt (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lu (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lv (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lw (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lx (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ly (50000)
     /home/k6-workdir/influxdb-metrics.log-split-lz (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ma (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mb (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mc (50000)
     /home/k6-workdir/influxdb-metrics.log-split-md (50000)
     /home/k6-workdir/influxdb-metrics.log-split-me (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mf (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mg (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mh (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mi (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mj (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mk (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ml (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mm (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mn (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mo (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mp (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mr (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ms (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mt (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mu (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mv (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mw (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mx (50000)
     /home/k6-workdir/influxdb-metrics.log-split-my (50000)
     /home/k6-workdir/influxdb-metrics.log-split-mz (50000)
     /home/k6-workdir/influxdb-metrics.log-split-na (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nb (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nc (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nd (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ne (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nf (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ng (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nh (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ni (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nj (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nk (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nl (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nm (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nn (50000)
     /home/k6-workdir/influxdb-metrics.log-split-no (50000)
     /home/k6-workdir/influxdb-metrics.log-split-np (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nr (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ns (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nt (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nu (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nv (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nw (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nx (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ny (50000)
     /home/k6-workdir/influxdb-metrics.log-split-nz (50000)
     /home/k6-workdir/influxdb-metrics.log-split-oa (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ob (50000)
     /home/k6-workdir/influxdb-metrics.log-split-oc (50000)
     /home/k6-workdir/influxdb-metrics.log-split-od (50000)
     /home/k6-workdir/influxdb-metrics.log-split-oe (50000)
     /home/k6-workdir/influxdb-metrics.log-split-of (50000)
     /home/k6-workdir/influxdb-metrics.log-split-og (50000)
     /home/k6-workdir/influxdb-metrics.log-split-oh (50000)
     /home/k6-workdir/influxdb-metrics.log-split-oi (50000)
     /home/k6-workdir/influxdb-metrics.log-split-oj (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ok (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ol (50000)
     /home/k6-workdir/influxdb-metrics.log-split-om (50000)
     /home/k6-workdir/influxdb-metrics.log-split-on (50000)
     /home/k6-workdir/influxdb-metrics.log-split-oo (50000)
     /home/k6-workdir/influxdb-metrics.log-split-op (50000)
     /home/k6-workdir/influxdb-metrics.log-split-oq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-or (50000)
     /home/k6-workdir/influxdb-metrics.log-split-os (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ot (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ou (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ov (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ow (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ox (50000)
     /home/k6-workdir/influxdb-metrics.log-split-oy (50000)
     /home/k6-workdir/influxdb-metrics.log-split-oz (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pa (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pb (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pc (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pd (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pe (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pf (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pg (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ph (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pi (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pj (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pk (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pl (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pm (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pn (50000)
     /home/k6-workdir/influxdb-metrics.log-split-po (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pp (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pr (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ps (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pt (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pu (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pv (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pw (50000)
     /home/k6-workdir/influxdb-metrics.log-split-px (50000)
     /home/k6-workdir/influxdb-metrics.log-split-py (50000)
     /home/k6-workdir/influxdb-metrics.log-split-pz (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qa (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qb (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qc (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qd (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qe (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qf (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qg (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qh (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qi (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qj (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qk (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ql (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qm (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qn (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qo (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qp (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qr (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qs (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qt (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qu (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qv (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qw (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qx (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qy (50000)
     /home/k6-workdir/influxdb-metrics.log-split-qz (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ra (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rb (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rc (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rd (50000)
     /home/k6-workdir/influxdb-metrics.log-split-re (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rf (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rg (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rh (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ri (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rj (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rk (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rl (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rm (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rn (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ro (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rp (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rr (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rs (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rt (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ru (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rv (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rw (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rx (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ry (50000)
     /home/k6-workdir/influxdb-metrics.log-split-rz (50000)
     /home/k6-workdir/influxdb-metrics.log-split-sa (50000)
     /home/k6-workdir/influxdb-metrics.log-split-sb (50000)
     /home/k6-workdir/influxdb-metrics.log-split-sc (50000)
     /home/k6-workdir/influxdb-metrics.log-split-sd (50000)
     /home/k6-workdir/influxdb-metrics.log-split-se (50000)
     /home/k6-workdir/influxdb-metrics.log-split-sf (50000)
     /home/k6-workdir/influxdb-metrics.log-split-sg (50000)
     /home/k6-workdir/influxdb-metrics.log-split-sh (50000)
     /home/k6-workdir/influxdb-metrics.log-split-si (50000)
     /home/k6-workdir/influxdb-metrics.log-split-sj (50000)
     /home/k6-workdir/influxdb-metrics.log-split-sk (50000)
     /home/k6-workdir/influxdb-metrics.log-split-sl (50000)
     /home/k6-workdir/influxdb-metrics.log-split-sm (50000)
     /home/k6-workdir/influxdb-metrics.log-split-sn (50000)
     /home/k6-workdir/influxdb-metrics.log-split-so (50000)
     /home/k6-workdir/influxdb-metrics.log-split-sp (50000)
     /home/k6-workdir/influxdb-metrics.log-split-sq (50000)
     /home/k6-workdir/influxdb-metrics.log-split-sr (50000)
     /home/k6-workdir/influxdb-metrics.log-split-ss (50000)
     /home/k6-workdir/influxdb-metrics.log-split-st (16168)

     InfluxDB import queries

     curl -i -sX POST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE k6"
     # create InfluxDB database: k6...
     HTTP/1.1 200 OK
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/cpuload-split-aa
     # auto insert /home/k6-workdir/cpuload-split-aa into InfluxDB database: k6...
     HTTP/1.1 204 No Content
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/cpuload-split-ab
     # auto insert /home/k6-workdir/cpuload-split-ab into InfluxDB database: k6...
     HTTP/1.1 204 No Content
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-aa
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-aa into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ab
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ab into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ac
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ac into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ad
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ad into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ae
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ae into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-af
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-af into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ag
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ag into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ah
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ah into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ai
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ai into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-aj
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-aj into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ak
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ak into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-al
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-al into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-am
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-am into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-an
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-an into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ao
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ao into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ap
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ap into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-aq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-aq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ar
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ar into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-as
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-as into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-at
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-at into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-au
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-au into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-av
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-av into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-aw
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-aw into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ax
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ax into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ay
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ay into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-az
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-az into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ba
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ba into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bb
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bb into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bc
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bc into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bd
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bd into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-be
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-be into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bf
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bf into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bg
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bg into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bh
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bh into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bi
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bi into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bj
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bj into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bk
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bk into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bl
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bl into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bm
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bm into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bn
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bn into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bo
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bo into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bp
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bp into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-br
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-br into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bs
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bs into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bt
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bt into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bu
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bu into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bv
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bv into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bw
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bw into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bx
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bx into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-by
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-by into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bz
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-bz into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ca
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ca into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cb
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cb into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cc
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cc into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cd
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cd into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ce
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ce into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cf
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cf into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cg
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cg into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ch
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ch into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ci
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ci into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cj
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cj into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ck
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ck into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cl
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cl into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cm
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cm into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cn
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cn into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-co
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-co into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cp
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cp into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cr
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cr into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cs
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cs into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ct
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ct into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cu
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cu into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cv
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cv into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cw
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cw into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cx
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cx into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cy
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cy into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cz
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-cz into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-da
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-da into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-db
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-db into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dc
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dc into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dd
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dd into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-de
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-de into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-df
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-df into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dg
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dg into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dh
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dh into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-di
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-di into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dj
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dj into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dk
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dk into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dl
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dl into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dm
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dm into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dn
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dn into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-do
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-do into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dp
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dp into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dr
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dr into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ds
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ds into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dt
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dt into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-du
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-du into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dv
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dv into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dw
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dw into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dx
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dx into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dy
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dy into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dz
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-dz into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ea
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ea into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-eb
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-eb into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ec
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ec into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ed
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ed into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ee
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ee into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ef
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ef into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-eg
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-eg into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-eh
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-eh into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ei
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ei into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ej
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ej into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ek
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ek into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-el
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-el into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-em
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-em into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-en
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-en into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-eo
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-eo into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ep
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ep into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-eq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-eq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-er
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-er into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-es
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-es into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-et
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-et into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-eu
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-eu into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ev
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ev into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ew
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ew into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ex
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ex into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ey
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ey into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ez
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ez into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fa
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fa into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fb
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fb into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fc
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fc into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fd
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fd into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fe
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fe into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ff
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ff into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fg
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fg into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fh
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fh into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fi
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fi into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fj
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fj into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fk
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fk into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fl
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fl into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fm
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fm into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fn
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fn into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fo
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fo into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fp
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fp into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fr
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fr into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fs
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fs into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ft
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ft into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fu
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fu into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fv
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fv into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fw
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fw into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fx
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fx into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fy
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fy into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-fz
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-fz into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ga
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ga into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gb
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gb into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gc
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gc into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gd
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gd into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ge
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ge into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gf
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gf into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gg
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gg into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gh
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gh into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gi
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gi into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gj
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gj into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gk
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gk into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gl
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gl into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gm
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gm into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gn
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gn into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-go
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-go into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gp
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gp into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gr
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gr into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gs
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gs into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gt
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gt into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gu
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gu into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gv
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gv into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gw
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gw into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gx
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gx into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gy
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gy into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-gz
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-gz into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ha
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ha into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hb
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hb into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hc
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hc into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hd
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hd into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-he
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-he into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hf
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hf into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hg
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hg into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hh
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hh into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hi
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hi into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hj
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hj into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hk
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hk into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hl
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hl into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hm
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hm into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hn
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hn into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ho
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ho into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hp
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hp into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hr
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hr into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hs
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hs into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ht
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ht into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hu
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hu into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hv
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hv into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hw
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hw into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hx
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hx into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hy
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hy into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-hz
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-hz into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ia
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ia into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ib
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ib into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ic
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ic into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-id
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-id into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ie
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ie into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-if
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-if into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ig
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ig into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ih
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ih into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ii
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ii into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ij
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ij into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ik
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ik into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-il
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-il into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-im
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-im into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-in
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-in into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-io
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-io into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ip
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ip into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-iq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-iq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ir
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ir into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-is
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-is into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-it
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-it into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-iu
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-iu into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-iv
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-iv into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-iw
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-iw into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ix
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ix into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-iy
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-iy into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-iz
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-iz into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ja
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ja into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jb
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jb into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jc
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jc into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jd
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jd into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-je
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-je into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jf
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jf into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jg
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jg into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jh
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jh into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ji
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ji into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jj
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jj into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jk
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jk into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jl
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jl into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jm
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jm into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jn
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jn into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jo
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jo into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jp
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jp into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jr
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jr into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-js
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-js into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jt
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jt into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ju
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ju into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jv
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jv into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jw
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jw into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jx
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jx into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jy
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jy into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-jz
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-jz into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ka
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ka into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kb
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kb into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kc
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kc into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kd
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kd into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ke
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ke into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kf
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kf into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kg
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kg into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kh
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kh into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ki
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ki into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kj
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kj into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kk
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kk into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kl
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kl into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-km
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-km into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kn
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kn into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ko
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ko into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kp
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kp into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kr
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kr into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ks
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ks into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kt
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kt into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ku
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ku into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kv
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kv into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kw
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kw into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kx
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kx into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ky
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ky into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-kz
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-kz into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-la
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-la into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lb
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lb into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lc
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lc into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ld
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ld into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-le
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-le into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lf
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lf into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lg
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lg into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lh
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lh into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-li
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-li into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lj
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lj into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lk
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lk into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ll
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ll into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lm
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lm into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ln
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ln into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lo
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lo into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lp
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lp into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lr
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lr into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ls
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ls into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lt
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lt into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lu
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lu into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lv
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lv into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lw
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lw into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lx
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lx into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ly
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ly into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-lz
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-lz into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ma
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ma into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mb
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mb into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mc
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mc into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-md
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-md into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-me
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-me into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mf
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mf into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mg
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mg into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mh
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mh into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mi
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mi into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mj
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mj into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mk
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mk into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ml
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ml into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mm
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mm into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mn
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mn into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mo
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mo into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mp
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mp into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mr
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mr into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ms
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ms into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mt
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mt into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mu
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mu into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mv
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mv into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mw
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mw into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mx
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mx into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-my
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-my into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-mz
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-mz into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-na
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-na into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nb
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nb into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nc
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nc into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nd
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nd into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ne
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ne into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nf
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nf into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ng
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ng into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nh
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nh into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ni
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ni into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nj
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nj into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nk
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nk into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nl
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nl into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nm
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nm into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nn
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nn into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-no
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-no into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-np
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-np into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nr
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nr into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ns
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ns into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nt
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nt into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nu
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nu into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nv
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nv into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nw
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nw into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nx
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nx into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ny
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ny into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-nz
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-nz into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oa
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-oa into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ob
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ob into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oc
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-oc into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-od
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-od into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oe
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-oe into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-of
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-of into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-og
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-og into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oh
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-oh into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oi
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-oi into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oj
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-oj into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ok
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ok into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ol
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ol into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-om
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-om into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-on
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-on into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oo
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-oo into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-op
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-op into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-oq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-or
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-or into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-os
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-os into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ot
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ot into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ou
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ou into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ov
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ov into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ow
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ow into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ox
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ox into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oy
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-oy into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-oz
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-oz into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pa
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pa into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pb
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pb into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pc
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pc into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pd
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pd into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pe
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pe into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pf
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pf into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pg
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pg into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ph
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ph into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pi
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pi into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pj
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pj into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pk
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pk into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pl
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pl into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pm
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pm into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pn
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pn into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-po
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-po into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pp
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pp into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pr
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pr into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ps
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ps into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pt
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pt into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pu
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pu into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pv
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pv into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pw
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pw into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-px
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-px into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-py
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-py into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-pz
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-pz into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qa
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qa into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qb
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qb into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qc
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qc into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qd
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qd into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qe
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qe into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qf
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qf into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qg
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qg into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qh
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qh into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qi
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qi into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qj
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qj into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qk
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qk into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ql
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ql into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qm
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qm into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qn
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qn into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qo
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qo into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qp
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qp into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qr
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qr into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qs
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qs into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qt
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qt into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qu
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qu into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qv
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qv into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qw
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qw into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qx
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qx into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qy
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qy into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-qz
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-qz into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ra
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ra into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rb
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rb into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rc
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rc into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rd
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rd into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-re
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-re into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rf
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rf into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rg
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rg into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rh
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rh into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ri
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ri into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rj
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rj into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rk
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rk into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rl
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rl into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rm
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rm into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rn
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rn into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ro
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ro into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rp
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rp into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rr
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rr into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rs
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rs into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rt
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rt into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ru
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ru into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rv
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rv into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rw
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rw into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rx
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rx into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ry
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ry into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-rz
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-rz into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sa
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-sa into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sb
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-sb into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sc
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-sc into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sd
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-sd into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-se
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-se into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sf
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-sf into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sg
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-sg into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sh
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-sh into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-si
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-si into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sj
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-sj into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sk
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-sk into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sl
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-sl into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sm
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-sm into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sn
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-sn into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-so
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-so into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sp
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-sp into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sq
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-sq into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-sr
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-sr into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ss
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-ss into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-st
     # auto insert /home/k6-workdir/influxdb-metrics.log-split-st into InfluxDB database: k6...
     HTTP/1.1 100 Continue
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/realmem-split-aa
     # auto insert /home/k6-workdir/realmem-split-aa into InfluxDB database: k6...
     HTTP/1.1 204 No Content
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/realmem-split-ab
     # auto insert /home/k6-workdir/realmem-split-ab into InfluxDB database: k6...
     HTTP/1.1 204 No Content
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/virtualmem-split-aa
     # auto insert /home/k6-workdir/virtualmem-split-aa into InfluxDB database: k6...
     HTTP/1.1 204 No Content
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/virtualmem-split-ab
     # auto insert /home/k6-workdir/virtualmem-split-ab into InfluxDB database: k6...
     HTTP/1.1 204 No Content

k6 test completed
```

# InfluxDB data source Grafana dashboard charts

With [`psrecord-to-json.sh`](https://github.com/centminmod/k6-benchmarking/blob/master/tools/psrecord-to-json.md) tool and [`k6-log-to-influxdb`](https://github.com/centminmod/k6-benchmarking/blob/master/tools/k6-log-to-influxdb.md) tool imported k6 benchmark data into InfluxDB database `k6`.

For Nginx web server tested CPU and Memory usage

![psrecord nginx](/screenshots/psrecord/psrecord-influxdb-grafana-nginx-oct14-2022-01.png)

original psrecord plot created chart

![psrecord nginx](/screenshots/psrecord/psrecord-influxdb-grafana-nginx-oct14-2022-02.png)

k6 HTML report

![k6 HTML report](/screenshots/htmlreports/k6-htmlreport-oct14-2022-01.png)

![k6 HTML report](/screenshots/htmlreports/k6-htmlreport-oct14-2022-02.png)

For k6 benchmark data

![InfluxDB/Grafana](/screenshots/influxdb-grafana/k6-influxdb-grafana-ramping-vus-oct14-2022-01.png)

![InfluxDB/Grafana](/screenshots/influxdb-grafana/k6-influxdb-grafana-ramping-vus-oct14-2022-02.png)

Grafana setup to monitor InfluxDB internal database metrics to see how much of a load on InfluxDB there is doing manual batch file insertions to InfluxDB database `k6`.

Queries executed and Point throughput rates by hostname in per minute and per second

![InfluxDB internal database metrics](/screenshots/influxdb-grafana/influxdb-internal-metrics-oct14-2022-01.png)

InfluxDB Point ingestion rate per minute and per second

![InfluxDB internal database metrics](/screenshots/influxdb-grafana/influxdb-internal-metrics-oct14-2022-02.png)
