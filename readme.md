[k6 benchmarking](https://k6.io/docs/)

# Install

* https://k6.io/docs/getting-started/installation/#linux

```
wget -4 https://github.com/grafana/k6/releases/download/v0.40.0/k6-v0.40.0-linux-amd64.tar.gz -O k6-v0.40.0-linux-amd64.tar.gz
tar xvzf k6-v0.40.0-linux-amd64.tar.gz
\cp -af k6-v0.40.0-linux-amd64/k6 /usr/local/bin/k6
rm -rf k6-v0.40.0-linux-amd64/k6
```
```
k6 version
k6 v0.40.0 (2022-09-08T09:06:02+0000/v0.39.0-92-gdcbe2f9c, go1.18.6, linux/amd64)
```

# Benchmarks

## Constant Request Rate Benchmarks

For REQRATE = 100 request/s constant rate test with [`psrecord`](https://github.com/astrofrog/psrecord/)

```
VU=20
REQRATE=100
TIME=30
DOMAIN=https://yourdomain.com/

psrecord "taskset -c 0-3 k6 run -e RPS=${REQRATE} -e DURATION=${TIME}s -e USERS=${VU} -e URL=$DOMAIN --no-usage-report --out json=summary-raw-rps.gz benchmark-rps.js" --include-children --interval 0.1 --duration 30 --log psrecord.log --plot plot.png
```
```
VU=20
REQRATE=100
TIME=30
DOMAIN=https://yourdomain.com/

psrecord "taskset -c 0-3 k6 run -e RPS=${REQRATE} -e DURATION=${TIME}s -e USERS=${VU} -e URL=$DOMAIN --no-usage-report --out json=summary-raw-rps.gz benchmark-rps.js" --include-children --interval 0.1 --duration 30 --log psrecord.log --plot plot.png

Starting up command 'taskset -c 0-3 k6 run -e RPS=100 -e DURATION=15s -e USERS=20 -e URL=https://domain1.com/ --no-usage-report --out json=summary-raw-rps.gz benchmark-rps.js' and attaching to process

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

  execution: local
     script: benchmark-rps.js
     output: json (summary-raw-rps.gz)

  scenarios: (100.00%) 1 scenario, 1000 max VUs, 45s max duration (incl. graceful stop):
           * open_model: 100.00 iterations/s for 15s (maxVUs: 20-1000, gracefulStop: 30s)


running (15.0s), 0000/0020 VUs, 1501 complete and 0 interrupted iterations
open_model ✓ [======================================] 0000/0020 VUs  15s  100.00 iters/s
     █ main index page

       ✓ is status 200

     checks.........................: 100.00% ✓ 1501       ✗ 0   
     data_received..................: 3.6 MB  239 kB/s
     data_sent......................: 73 kB   4.8 kB/s
     group_duration.................: avg=278.22µs min=225.94µs med=260.97µs max=4.7ms    p(95)=304.74µs p(99)=963.37µs p(99.99)=4.21ms   count=1501
     http_req_blocked...............: avg=9.72µs   min=160ns    med=262ns    max=922.33µs p(95)=361ns    p(99)=649.83µs p(99.99)=919.25µs count=1501
     http_req_connecting............: avg=700ns    min=0s       med=0s       max=99.76µs  p(95)=0s       p(99)=44.79µs  p(99.99)=96.78µs  count=1501
     http_req_duration..............: avg=213.93µs min=181.89µs med=209.62µs max=588.97µs p(95)=238.92µs p(99)=327.53µs p(99.99)=586.16µs count=1501
       { expected_response:true }...: avg=213.93µs min=181.89µs med=209.62µs max=588.97µs p(95)=238.92µs p(99)=327.53µs p(99.99)=586.16µs count=1501
     ✓ { gzip:yes }.................: avg=213.93µs min=181.89µs med=209.62µs max=588.97µs p(95)=238.92µs p(99)=327.53µs p(99.99)=586.16µs count=1501
     http_req_failed................: 0.00%   ✓ 0          ✗ 1501
     http_req_receiving.............: avg=21.72µs  min=14.74µs  med=19.78µs  max=194.79µs p(95)=27.82µs  p(99)=93.34µs  p(99.99)=193.84µs count=1501
     http_req_sending...............: avg=57.33µs  min=25.28µs  med=31.96µs  max=312.68µs p(95)=202.96µs p(99)=211.36µs p(99.99)=309.35µs count=1501
     http_req_tls_handshaking.......: avg=7.8µs    min=0s       med=0s       max=744.19µs p(95)=0s       p(99)=547.02µs p(99.99)=740.18µs count=1501
     http_req_waiting...............: avg=134.87µs min=0s       med=152.74µs max=520.46µs p(95)=174.36µs p(99)=230.68µs p(99.99)=510.61µs count=1501
     http_reqs......................: 1501    100.053087/s
     iteration_duration.............: avg=291.89µs min=236.67µs med=273.92µs max=4.72ms   p(95)=319.85µs p(99)=983.59µs p(99.99)=4.24ms   count=1501
     iterations.....................: 1501    100.053087/s
     vus............................: 20      min=20       max=20
     vus_max........................: 20      min=20       max=20Process finished (15.58 seconds)
```

psrecord recorded cpu and memory usage on 4x core/8x thread Intel i7 4790K server.

![benchmark-rps.js](/screenshots/rps/plot.png)

## User Concurrency Benchmarks

User 100 concurrency 4 stage benchmarks with random sleep between 1 to 5 seconds with [`psrecord`](https://github.com/astrofrog/psrecord/) in `benchmark2.js` for `export default function ()`

```javascript
  const sleepMin = 1;
  const sleepMax = 5;
```

and `group('main index page', function ()`

```
sleep(randomIntBetween(sleepMin, sleepMax));
```

```
TIME=30
DOMAIN=https://yourdomain.com/

# method 1 run psrecord in background
# get Nginx MainPID value using Centmin Mod cminfo server-info tool
spid=$(cminfo service-info nginx | jq -r '.MainPID')
# set duration to 180 seconds as benchmark2.js uses 4x 30s stages + 30s = 2 1/2 min run time
psrecord $spid --include-children --interval 0.1 --duration 180 --log psrecord-user.log --plot plot-user.png &
taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw2.gz benchmark2.js

# method 2 initiated via psrecord
psrecord "taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw2.gz benchmark2.js" --include-children --interval 0.1 --duration 180 --log psrecord-user.log --plot plot-user.png
```

```
TIME=30
DOMAIN=https://yourdomain.com/

# method 2 initiated via psrecord
psrecord "taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw2.gz benchmark2.js" --include-children --interval 0.1 --duration 180 --log psrecord-user.log --plot plot-user.png

Starting up command 'taskset -c 0-3 k6 run -e STAGETIME=30s -e URL=https://domain1.com/ --no-usage-report --out json=summary-raw2.gz benchmark2.js' and attaching to process

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

  execution: local
     script: benchmark2.js
     output: json (summary-raw2.gz)

  scenarios: (100.00%) 1 scenario, 100 max VUs, 2m30s max duration (incl. graceful stop):
           * default: Up to 100 looping VUs for 2m0s over 4 stages (gracefulRampDown: 30s, gracefulStop: 30s)


running (2m03.8s), 000/100 VUs, 1769 complete and 0 interrupted iterations
default ✓ [======================================] 000/100 VUs  2m0s
     █ main index page

       ✓ is status 200

     checks.........................: 100.00% ✓ 1769      ✗ 0    
     data_received..................: 4.4 MB  35 kB/s
     data_sent......................: 139 kB  1.1 kB/s
     group_duration.................: avg=3.06s    min=1s       med=3s       max=5.01s    p(95)=5s       p(99)=5s       p(99.99)=5.01s    count=1769
     http_req_blocked...............: avg=55.87µs  min=201ns    med=301ns    max=7.78ms   p(95)=807.56µs p(99)=882.42µs p(99.99)=7.59ms   count=1769
     http_req_connecting............: avg=11.34µs  min=0s       med=0s       max=6.73ms   p(95)=66.46µs  p(99)=84.49µs  p(99.99)=6.6ms    count=1769
     http_req_duration..............: avg=265.87µs min=190.27µs med=238.09µs max=9.56ms   p(95)=331.85µs p(99)=418.32µs p(99.99)=9.42ms   count=1769
       { expected_response:true }...: avg=265.87µs min=190.27µs med=238.09µs max=9.56ms   p(95)=331.85µs p(99)=418.32µs p(99.99)=9.42ms   count=1769
     ✓ { gzip:yes }.................: avg=265.87µs min=190.27µs med=238.09µs max=9.56ms   p(95)=331.85µs p(99)=418.32µs p(99.99)=9.42ms   count=1769
     http_req_failed................: 0.00%   ✓ 0         ✗ 1769 
     http_req_receiving.............: avg=26.87µs  min=11.35µs  med=21.96µs  max=271.43µs p(95)=85.08µs  p(99)=107.91µs p(99.99)=255.28µs count=1769
     http_req_sending...............: avg=59.23µs  min=29.96µs  med=37.79µs  max=466.93µs p(95)=217.3µs  p(99)=268.22µs p(99.99)=456.12µs count=1769
     http_req_tls_handshaking.......: avg=39.06µs  min=0s       med=0s       max=905.93µs p(95)=654.55µs p(99)=700.41µs p(99.99)=900.07µs count=1769
     http_req_waiting...............: avg=179.76µs min=0s       med=172.86µs max=9.49ms   p(95)=228.64µs p(99)=311.14µs p(99.99)=9.34ms   count=1769
     http_reqs......................: 1769    14.289059/s
     iteration_duration.............: avg=3.06s    min=1s       med=3s       max=5.01s    p(95)=5s       p(99)=5s       p(99.99)=5.01s    count=1769
     iterations.....................: 1769    14.289059/s
     vus............................: 1       min=1       max=100
     vus_max........................: 100     min=100     max=100Process finished (124.47 seconds)
```

psrecord recorded cpu and memory usage on 4x core/8x thread Intel i7 4790K server.

![benchmark2.js](/screenshots/users/plot-user.png)