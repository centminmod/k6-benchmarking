* `bench-ramping-vus.sh` wrapper script for k6 benchmarking using `ramping-vus` executor with defined duration of `3` seconds for 4 stage runs with VU user counts 5, 10, 15, 0 respectively. 
* Nginx CPU and memory usage stats are recorded via `psrecord` and parsed via [`psrecord-to-json.sh`](https://github.com/centminmod/k6-benchmarking/blob/master/tools/psrecord-to-json.md) tool for InfluxDB data format with the intention of being able to import the data into InfluxDB. [InfluxDB/Grafana charts here](#influxdb-data-source-grafana-dashboard-charts).
* `run-local` run with k6 benchmark with `--out json=summary-raw-scenarios-multi.gz` JSON logged output and convert it into [InfluxDB 1.8 batch line write format](https://docs.influxdata.com/influxdb/v1.8/guides/write_data/#writing-points-from-a-file) for post-k6 run insertion into InfluxDB 1.8 database using [`k6-log-to-influxdb`](https://github.com/centminmod/k6-benchmarking/blob/master/tools/k6-log-to-influxdb.md) tool. [InfluxDB/Grafana charts here](#influxdb-data-source-grafana-dashboard-charts).

```
./bench-ramping-vus.sh

Usage:

./bench-ramping-vus.sh run-local https://domain.com
./bench-ramping-vus.sh run-influxdb https://domain.com
./bench-ramping-vus.sh run-local https://domain.com TIME 25,50,100,0
./bench-ramping-vus.sh run-influxdb https://domain.com TIME 25,50,100,0
```
```
./bench-ramping-vus.sh run-local https://domain1.com 3 5,10,15,0
start k6 test

#####################################################################
start time (Australia/Brisbane): Wed Oct 12 00:18:46 AEST 2022
start nanosecond time (Australia/Brisbane): 1665497926000000000
start time (UTC): Tue Oct 11 14:18:46 UTC 2022
start nanosecond time (UTC): 1665497926000000000
#####################################################################

psrecord 4034 --include-children --interval 0.1 --duration 115 --log /home/k6-workdir/psrecord-ramping-15vus-nginx.log --plot plot-ramping-15vus-nginx.png &

taskset -c 0-3 k6 run --tag testname=rampingvus -e RPS=1 -e USERS=0 -e STAGETIME=3s -e STAGE_VU1=5 -e STAGE_VU2=10 -e STAGE_VU3=15 -e STAGE_VU4=0 -e URL=https://domain1.com --no-usage-report --out json=/home/k6-workdir/summary-raw-scenarios-multi.gz benchmark-scenarios-multi.js

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

Attaching to process 4034
  execution: local
     script: benchmark-scenarios-multi.js
     output: json (/home/k6-workdir/summary-raw-scenarios-multi.gz)

  scenarios: (100.00%) 1 scenario, 15 max VUs, 42s max duration (incl. graceful stop):
           * ramping_vus: Up to 15 looping VUs for 12s over 4 stages (gracefulRampDown: 1m0s, gracefulStop: 30s)


running (12.0s), 00/15 VUs, 46674 complete and 0 interrupted iterations
ramping_vus ✓ [======================================] 00/15 VUs  12s
INFO[0012] [k6-reporter v2.3.0] Generating HTML summary report  source=console
     ✓ is status 200

     checks.........................: 100.00% ✓ 46674      ✗ 0    
     data_received..................: 110 MB  9.2 MB/s
     data_sent......................: 1.8 MB  153 kB/s
     http_req_blocked...............: avg=1.57µs   min=128ns    med=218ns    max=13.79ms p(95)=298ns    p(99)=356ns   p(99.99)=2.89ms   count=46674
     http_req_connecting............: avg=182ns    min=0s       med=0s       max=4.37ms  p(95)=0s       p(99)=0s      p(99.99)=300.08µs count=46674
     http_req_duration..............: avg=1.18ms   min=165.17µs med=542.34µs max=34.23ms p(95)=3.91ms   p(99)=9.97ms  p(99.99)=26.26ms  count=46674
       { expected_response:true }...: avg=1.18ms   min=165.17µs med=542.34µs max=34.23ms p(95)=3.91ms   p(99)=9.97ms  p(99.99)=26.26ms  count=46674
     http_req_failed................: 0.00%   ✓ 0          ✗ 46674
     http_req_receiving.............: avg=441.39µs min=8.75µs   med=50.29µs  max=25.78ms p(95)=1.82ms   p(99)=3.5ms   p(99.99)=20.61ms  count=46674
     http_req_sending...............: avg=85.06µs  min=17.16µs  med=28.24µs  max=31.79ms p(95)=216.75µs p(99)=422.1µs p(99.99)=15.57ms  count=46674
     http_req_tls_handshaking.......: avg=1.11µs   min=0s       med=0s       max=12.94ms p(95)=0s       p(99)=0s      p(99.99)=2.08ms   count=46674
     http_req_waiting...............: avg=655.89µs min=0s       med=366.06µs max=26.06ms p(95)=1.88ms   p(99)=8.29ms  p(99.99)=22.07ms  count=46674
     http_reqs......................: 46674   3888.31943/s
     iteration_duration.............: avg=1.85ms   min=555µs    med=1.15ms   max=36.28ms p(95)=5.13ms   p(99)=12.22ms p(99.99)=30.84ms  count=46674
     iterations.....................: 46674   3888.31943/s
     vus............................: 1       min=1        max=14 
     vus_max........................: 15      min=15       max=15 

     ##################################################################
     parsing & converting nginx psrecord data...
     waiting for psrecord to close its log...
     ./tools/psrecord-to-json.sh influx /home/k6-workdir/psrecord-ramping-15vus-nginx.log
     start time (Australia/Brisbane : Wed Oct 12 00:18:46 AEST 2022
     end time (Australia/Brisbane ): Wed Oct 12 00:20:41 AEST 2022
     start time (UTC): Tue Oct 11 14:18:46 UTC 2022
     end time (UTC): Tue Oct 11 14:20:41 UTC 2022
     file_start_timestamp (Australia/Brisbane) = 1665497926000000000
     file_start_timestamp (UTC) = 1665497926000000000
     file_start_timestamp_epoch (UTC) = 1665497926
     file_end_timestamp (UTC) = 1665498041

     Saved InfluxDB formatted data files at:
     cpuload: /home/k6-workdir/cpuload.txt (1030)
     realmem: /home/k6-workdir/realmem.txt (1030)
     virtualmem: /home/k6-workdir/virtualmem.txt (1030)

     InfluxDB import queries

     curl -i -sX POST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE psrecord"
     curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @/home/k6-workdir/cpuload.txt
     curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @/home/k6-workdir/realmem.txt
     curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @/home/k6-workdir/virtualmem.txt

     Grafana Dashboard Time Frame
     ?orgId=1&from=1665497926&to=1665498041

     ##################################################################
     parsing & converting k6 JSON output log /home/k6-workdir/summary-raw-scenarios-multi.gz
     to InfluxDB batch write format...
     ./tools/k6-log-to-influxdb.sh convert /home/k6-workdir/summary-raw-scenarios-multi.gz

     Saved InfluxDB formatted data files (12 lines) at:
     /home/k6-workdir/influxdb-vus.log (12)

     InfluxDB import queries

     curl -i -sX POST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE k6"
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-vus.log

     Saved & Split InfluxDB formatted data files (420066 lines) at:
     /home/k6-workdir/influxdb-metrics.log-split-aa (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ab (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ac (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ad (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ae (5000)
     /home/k6-workdir/influxdb-metrics.log-split-af (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ag (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ah (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ai (5000)
     /home/k6-workdir/influxdb-metrics.log-split-aj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ak (5000)
     /home/k6-workdir/influxdb-metrics.log-split-al (5000)
     /home/k6-workdir/influxdb-metrics.log-split-am (5000)
     /home/k6-workdir/influxdb-metrics.log-split-an (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ao (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ap (5000)
     /home/k6-workdir/influxdb-metrics.log-split-aq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ar (5000)
     /home/k6-workdir/influxdb-metrics.log-split-as (5000)
     /home/k6-workdir/influxdb-metrics.log-split-at (5000)
     /home/k6-workdir/influxdb-metrics.log-split-au (5000)
     /home/k6-workdir/influxdb-metrics.log-split-av (5000)
     /home/k6-workdir/influxdb-metrics.log-split-aw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ax (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ay (5000)
     /home/k6-workdir/influxdb-metrics.log-split-az (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ba (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-be (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bh (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bi (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bk (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bo (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-br (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bs (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bt (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-by (5000)
     /home/k6-workdir/influxdb-metrics.log-split-bz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ca (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cb (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ce (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cf (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cg (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ch (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ci (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cj (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ck (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cl (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cm (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cn (5000)
     /home/k6-workdir/influxdb-metrics.log-split-co (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cp (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cq (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cr (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cs (5000)
     /home/k6-workdir/influxdb-metrics.log-split-ct (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cu (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cv (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cw (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cx (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cy (5000)
     /home/k6-workdir/influxdb-metrics.log-split-cz (5000)
     /home/k6-workdir/influxdb-metrics.log-split-da (5000)
     /home/k6-workdir/influxdb-metrics.log-split-db (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dc (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dd (5000)
     /home/k6-workdir/influxdb-metrics.log-split-de (5000)
     /home/k6-workdir/influxdb-metrics.log-split-df (5000)
     /home/k6-workdir/influxdb-metrics.log-split-dg (66)

     InfluxDB import queries

     curl -i -sX POST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE k6"
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-aa
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ab
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ac
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ad
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ae
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-af
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ag
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ah
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ai
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-aj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ak
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-al
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-am
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-an
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ao
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ap
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-aq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ar
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-as
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-at
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-au
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-av
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-aw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ax
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ay
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-az
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ba
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-be
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bh
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bi
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bk
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bo
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-br
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bs
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bt
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-by
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-bz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ca
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cb
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ce
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cf
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cg
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ch
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ci
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cj
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ck
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cl
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cm
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cn
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-co
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cp
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cq
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cr
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cs
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-ct
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cu
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cv
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cw
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cx
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cy
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-cz
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-da
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-db
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dc
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dd
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-de
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-df
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log-split-dg

k6 test completed
```

# InfluxDB data source Grafana dashboard charts

With [`psrecord-to-json.sh`](https://github.com/centminmod/k6-benchmarking/blob/master/tools/psrecord-to-json.md) tool and [`k6-log-to-influxdb`](https://github.com/centminmod/k6-benchmarking/blob/master/tools/k6-log-to-influxdb.md) tool imported k6 benchmark data into InfluxDB database `k6`.

For Nginx web server tested CPU and Memory usage

![psrecord nginx](/screenshots/psrecord/psrecord-influxdb-grafana-nginx-oc512-2022-01.png)

For k6 benchmark data

![InfluxDB/Grafana](/screenshots/influxdb-grafana/k6-influxdb-grafana-ramping-vus-oct12-2022-01.png)

![InfluxDB/Grafana](/screenshots/influxdb-grafana/k6-influxdb-grafana-ramping-vus-oct12-2022-02.png)

Grafana setup to monitor InfluxDB internal database metrics to see how much of a load on InfluxDB there is doing manual batch file insertions to InfluxDB database `k6`.

Queries executed and Point throughput rates by hostname in per minute and per second

![InfluxDB internal database metrics](/screenshots/influxdb-grafana/influxdb-internal-metrics-oct12-2022-01.png)

InfluxDB Point ingestion rate per minute and per second

![InfluxDB internal database metrics](/screenshots/influxdb-grafana/influxdb-internal-metrics-oct12-2022-02.png)
