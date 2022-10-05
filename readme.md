[k6 benchmarking](https://k6.io/docs/)

* [Install](#install)
* [Benchmarks](#benchmarks)
  * [Constant Request Rate Benchmarks](#constant-request-rate-benchmarks)
  * [User Concurrency Benchmarks Without Random Sleep](#user-concurrency-benchmarks-without-random-sleep)
  * [User Concurrency Benchmarks With Random Sleep](#user-concurrency-benchmarks-with-random-sleep)

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
```
k6 --help

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

Usage:
  k6 [command]

Available Commands:
  archive     Create an archive
  cloud       Run a test on the cloud
  completion  Generate the autocompletion script for the specified shell
  convert     Convert a HAR file to a k6 script
  help        Help about any command
  inspect     Inspect a script or archive
  login       Authenticate with a service
  pause       Pause a running test
  resume      Resume a paused test
  run         Start a load test
  scale       Scale a running test
  stats       Show test metrics
  status      Show test status
  version     Show application version

Flags:
  -a, --address string      address for the REST API server (default "localhost:6565")
  -c, --config string       JSON config file (default "/root/.config/loadimpact/k6/config.json")
  -h, --help                help for k6
      --log-format string   log output format
      --log-output string   change the output for k6 logs, possible values are stderr,stdout,none,loki[=host:port],file[=./path.fileformat] (default "stderr")
      --no-color            disable colored output
  -q, --quiet               disable progress updates
  -v, --verbose             enable verbose logging

Use "k6 [command] --help" for more information about a command.
```

Install psrecord

```
pip install psrecord
```
```
psrecord --help
usage: psrecord [-h] [--log LOG] [--plot PLOT] [--duration DURATION]
                [--interval INTERVAL] [--include-children]
                process_id_or_command

Record CPU and memory usage for a process

positional arguments:
  process_id_or_command
                        the process id or command

optional arguments:
  -h, --help            show this help message and exit
  --log LOG             output the statistics to a file
  --plot PLOT           output the statistics to a plot
  --duration DURATION   how long to record for (in seconds). If not specified,
                        the recording is continuous until the job exits.
  --interval INTERVAL   how long to wait between each sample (in seconds). By
                        default the process is sampled as often as possible.
  --include-children    include sub-processes in statistics (results in a
                        slower maximum sampling rate).
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

## User Concurrency Benchmarks Without Random Sleep

User 25, 50, 100, 0 concurrency 4 stage benchmarks without random sleep with [`psrecord`](https://github.com/astrofrog/psrecord/)

```
TIME=30
DOMAIN=https://yourdomain.com/

# method 1 run psrecord in background
# get Nginx MainPID value using Centmin Mod cminfo server-info tool
spid=$(cminfo service-info nginx | jq -r '.MainPID')
# set duration to 180 seconds as benchmark.js uses 4x 30s stages + 30s = 2 1/2 min run time
psrecord $spid --include-children --interval 0.1 --duration 180 --log psrecord-user-no-sleep.log --plot plot-user-no-sleep.png &
taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw.gz benchmark.js

# method 2 initiated via psrecord
psrecord "taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw.gz benchmark.js" --include-children --interval 0.1 --duration 180 --log psrecord-user-no-sleep.log --plot plot-user-no-sleep.png
```

```
TIME=30
DOMAIN=https://yourdomain.com/

psrecord "taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw.gz benchmark.js" --include-children --interval 0.1 --duration 180 --log psrecord-user-no-sleep.log --plot plot-user-no-sleep.png

Starting up command 'taskset -c 0-3 k6 run -e STAGETIME=30s -e URL=https://domain1.com/ --no-usage-report --out json=summary-raw.gz benchmark.js' and attaching to process

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

  execution: local
     script: benchmark.js
     output: json (summary-raw.gz)

  scenarios: (100.00%) 1 scenario, 100 max VUs, 2m30s max duration (incl. graceful stop):
           * default: Up to 100 looping VUs for 2m0s over 4 stages (gracefulRampDown: 30s, gracefulStop: 30s)


running (2m00.0s), 000/100 VUs, 515498 complete and 0 interrupted iterations
default ✓ [======================================] 000/100 VUs  2m0s
     █ main index page

       ✓ is status 200

     checks.........................: 100.00% ✓ 515498      ✗ 0     
     data_received..................: 1.2 GB  10 MB/s
     data_sent......................: 20 MB   168 kB/s
     group_duration.................: avg=9.28ms   min=206.71µs med=6.03ms  max=118.51ms p(95)=29.06ms  p(99)=45.52ms p(99.99)=89.95ms count=515498
     http_req_blocked...............: avg=3.61µs   min=107ns    med=221ns   max=65.82ms  p(95)=326ns    p(99)=427ns   p(99.99)=13.44ms count=515498
     http_req_connecting............: avg=1.59µs   min=0s       med=0s      max=38.03ms  p(95)=0s       p(99)=0s      p(99.99)=3.46ms  count=515498
     http_req_duration..............: avg=9.15ms   min=162.86µs med=5.94ms  max=118.46ms p(95)=28.73ms  p(99)=44.83ms p(99.99)=88.63ms count=515498
       { expected_response:true }...: avg=9.15ms   min=162.86µs med=5.94ms  max=118.46ms p(95)=28.73ms  p(99)=44.83ms p(99.99)=88.63ms count=515498
     ✓ { gzip:yes }.................: avg=9.15ms   min=162.86µs med=5.94ms  max=118.46ms p(95)=28.73ms  p(99)=44.83ms p(99.99)=88.63ms count=515498
     http_req_failed................: 0.00%   ✓ 0           ✗ 515498
     http_req_receiving.............: avg=3.77ms   min=9µs      med=1.73ms  max=107.19ms p(95)=14.31ms  p(99)=31.21ms p(99.99)=67.59ms count=515498
     http_req_sending...............: avg=126.79µs min=13.99µs  med=29.29µs max=73.17ms  p(95)=185.48µs p(99)=1.7ms   p(99.99)=39.06ms count=515498
     http_req_tls_handshaking.......: avg=1.66µs   min=0s       med=0s      max=52.81ms  p(95)=0s       p(99)=0s      p(99.99)=4.81ms  count=515498
     http_req_waiting...............: avg=5.25ms   min=0s       med=2.39ms  max=91.08ms  p(95)=19.37ms  p(99)=26.88ms p(99.99)=51.61ms count=515498
     http_reqs......................: 515498  4295.760443/s
     iteration_duration.............: avg=10.14ms  min=618.59µs med=6.8ms   max=119.03ms p(95)=30.72ms  p(99)=48.28ms p(99.99)=91.41ms count=515498
     iterations.....................: 515498  4295.760443/s
     vus............................: 1       min=1         max=99  
     vus_max........................: 100     min=100       max=100 Process finished (121.29 seconds)
```

Using `jq` to filter `summary-raw.gz` summary log for the 4 stages via the tags for each stage.

```
pzcat summary-raw.gz | jq -r 'select(.data.tags | .stage == "3")'
pzcat summary-raw.gz | jq -r 'select(.data.tags | .stage == "2")'
pzcat summary-raw.gz | jq -r 'select(.data.tags | .stage == "1")'
pzcat summary-raw.gz | jq -r 'select(.data.tags | .stage == "0")'
```

To filter for `http_req_duration` entries for tag for `expected_response = true`

```
pzcat summary-raw.gz | jq -c 'select(.metric == "http_req_duration" and .data.tags.expected_response == "true")'
```

psrecord recorded cpu and memory usage on 4x core/8x thread Intel i7 4790K server.

![benchmark.js](/screenshots/users/plot-user-no-sleep.png)

## User Concurrency Benchmarks With Random Sleep

User 25, 50, 100, 0 concurrency 4 stage benchmarks with random sleep between 1 to 5 seconds with [`psrecord`](https://github.com/astrofrog/psrecord/) in `benchmark2.js` for `export default function ()`

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