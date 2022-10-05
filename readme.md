[k6 benchmarking](https://k6.io/docs/)

* [Install](#install)
* [Benchmarks](#benchmarks)
  * [Constant Request Rate Benchmarks](#constant-request-rate-benchmarks)
  * [User Concurrency Benchmarks Without Random Sleep](#user-concurrency-benchmarks-without-random-sleep)
  * [User Concurrency Benchmarks With Random Sleep](#user-concurrency-benchmarks-with-random-sleep)
* [InfluxDB + Grafana](#influxdb--grafana)

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

For REQRATE = 100 request/s constant rate test with [`psrecord`](https://github.com/astrofrog/psrecord/).   Where `--duration $((TIME+30))` is the `TIME` + 30s defined in `benchmark-rps.js`

```
VU=20
REQRATE=100
TIME=30
DOMAIN=https://yourdomain.com/

# gather nginx resource usage via psrecord in background
# get Nginx MainPID value using Centmin Mod cminfo server-info tool
spid=$(cminfo service-info nginx | jq -r '.MainPID')
# set duration to 180 seconds as benchmark.js uses 4x 30s stages + 30s = 2 1/2 min run time
psrecord $spid --include-children --interval 0.1 --duration $((TIME+30)) --log psrecord-rps-nginx.log --plot plot-rps-nginx.png &

psrecord "taskset -c 0-3 k6 run -e RPS=${REQRATE} -e DURATION=${TIME}s -e USERS=${VU} -e URL=$DOMAIN --no-usage-report --out json=summary-raw-rps.gz benchmark-rps.js" --include-children --interval 0.1 --duration $((TIME+30)) --log psrecord.log --plot plot.png
```
```
VU=20
REQRATE=100
TIME=30
DOMAIN=https://yourdomain.com/

# gather nginx resource usage via psrecord in background
# get Nginx MainPID value using Centmin Mod cminfo server-info tool
spid=$(cminfo service-info nginx | jq -r '.MainPID')
# set duration to 180 seconds as benchmark.js uses 4x 30s stages + 30s = 2 1/2 min run time
psrecord $spid --include-children --interval 0.1 --duration $((TIME+30)) --log psrecord-rps-nginx.log --plot plot-rps-nginx.png &

psrecord "taskset -c 0-3 k6 run -e RPS=${REQRATE} -e DURATION=${TIME}s -e USERS=${VU} -e URL=$DOMAIN --no-usage-report --out json=summary-raw-rps.gz benchmark-rps.js" --include-children --interval 0.1 --duration $((TIME+30)) --log psrecord.log --plot plot.png

Starting up command 'taskset -c 0-3 k6 run -e RPS=100 -e DURATION=30s -e USERS=20 -e URL=https://domain1.com/ --no-usage-report --out json=summary-raw-rps.gz benchmark-rps.js' and attaching to process

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

  execution: local
     script: benchmark-rps.js
     output: json (summary-raw-rps.gz)

  scenarios: (100.00%) 1 scenario, 1000 max VUs, 1m0s max duration (incl. graceful stop):
           * open_model: 100.00 iterations/s for 30s (maxVUs: 20-1000, gracefulStop: 30s)


running (0m30.0s), 0000/0020 VUs, 3000 complete and 0 interrupted iterations
open_model ✓ [======================================] 0000/0020 VUs  30s  100.00 iters/s
     █ main index page

       ✓ is status 200

     checks.........................: 100.00% ✓ 3000      ✗ 0   
     data_received..................: 7.1 MB  238 kB/s
     data_sent......................: 131 kB  4.4 kB/s
     group_duration.................: avg=288.4µs  min=232.7µs  med=271.13µs max=6.36ms   p(95)=330.81µs p(99)=437.09µs p(99.99)=5.79ms   count=3000
     http_req_blocked...............: avg=5.98µs   min=154ns    med=259ns    max=3.93ms   p(95)=360ns    p(99)=799ns    p(99.99)=3.04ms   count=3000
     http_req_connecting............: avg=1.05µs   min=0s       med=0s       max=2.15ms   p(95)=0s       p(99)=0s       p(99.99)=1.53ms   count=3000
     http_req_duration..............: avg=228.72µs min=186.45µs med=219.13µs max=6.29ms   p(95)=258.79µs p(99)=305.58µs p(99.99)=5.67ms   count=3000
       { expected_response:true }...: avg=228.72µs min=186.45µs med=219.13µs max=6.29ms   p(95)=258.79µs p(99)=305.58µs p(99.99)=5.67ms   count=3000
     ✓ { gzip:yes }.................: avg=228.72µs min=186.45µs med=219.13µs max=6.29ms   p(95)=258.79µs p(99)=305.58µs p(99.99)=5.67ms   count=3000
     http_req_failed................: 0.00%   ✓ 0         ✗ 3000
     http_req_receiving.............: avg=21.41µs  min=14.37µs  med=20.19µs  max=136.93µs p(95)=27.72µs  p(99)=36.52µs  p(99.99)=130.43µs count=3000
     http_req_sending...............: avg=60.9µs   min=25.83µs  med=33.25µs  max=317.2µs  p(95)=208.82µs p(99)=226.07µs p(99.99)=311.65µs count=3000
     http_req_tls_handshaking.......: avg=4.19µs   min=0s       med=0s       max=1.63ms   p(95)=0s       p(99)=0s       p(99.99)=1.37ms   count=3000
     http_req_waiting...............: avg=146.39µs min=0s       med=162.22µs max=6.22ms   p(95)=184.61µs p(99)=229.52µs p(99.99)=5.59ms   count=3000
     http_reqs......................: 3000    99.994163/s
     iteration_duration.............: avg=302.56µs min=245.1µs  med=284.47µs max=6.38ms   p(95)=348.05µs p(99)=462.9µs  p(99.99)=5.82ms   count=3000
     iterations.....................: 3000    99.994163/s
     vus............................: 20      min=20      max=20
     vus_max........................: 20      min=20      max=20Process finished (33.45 seconds)
```

psrecord recorded cpu and memory usage on 4x core/8x thread Intel i7 4790K server.

For k6 run itself

![benchmark-rps.js](/screenshots/rps/plot.png)

For Nginx web server tested

![nginx](/screenshots/rps/plot-rps-nginx.png)

## User Concurrency Benchmarks Without Random Sleep

User 25, 50, 100, 0 concurrency 4 stage benchmarks without random sleep with [`psrecord`](https://github.com/astrofrog/psrecord/). Where `--duration $((TIME*5+30))` is the time multiple by the 4+1 stage runs + 30s defined in `benchmark.js`

```
TIME=30
DOMAIN=https://yourdomain.com/

# gather nginx resource usage via psrecord in background
# get Nginx MainPID value using Centmin Mod cminfo server-info tool
spid=$(cminfo service-info nginx | jq -r '.MainPID')
# set duration to 180 seconds as benchmark.js uses 4x 30s stages + 30s = 2 1/2 min run time
psrecord $spid --include-children --interval 0.1 --duration $((TIME*5+30)) --log psrecord-user-no-sleep-nginx.log --plot plot-user-no-sleep-nginx.png &

# run k6 initiated via psrecord
psrecord "taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw.gz benchmark.js" --include-children --interval 0.1 --duration $((TIME*5+30)) --log psrecord-user-no-sleep.log --plot plot-user-no-sleep.png
```

```
TIME=30
DOMAIN=https://yourdomain.com/

# gather nginx resource usage via psrecord in background
# get Nginx MainPID value using Centmin Mod cminfo server-info tool
spid=$(cminfo service-info nginx | jq -r '.MainPID')
# set duration to 180 seconds as benchmark.js uses 4x 30s stages + 30s = 2 1/2 min run time
psrecord $spid --include-children --interval 0.1 --duration $((TIME*5+30)) --log psrecord-user-no-sleep-nginx.log --plot plot-user-no-sleep-nginx.png &

psrecord "taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw.gz benchmark.js" --include-children --interval 0.1 --duration $((TIME*5+30)) --log psrecord-user-no-sleep.log --plot plot-user-no-sleep.png

Starting up command 'taskset -c 0-3 k6 run -e STAGETIME=30s -e URL=https://domain1.com/ --no-usage-report --out json=summary-raw.gz benchmark.js' and attaching to process

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

  execution: local
     script: benchmark.js
     output: json (summary-raw.gz)

  scenarios: (100.00%) 1 scenario, 10 max VUs, 2m30s max duration (incl. graceful stop):
           * default: Up to 10 looping VUs for 2m0s over 4 stages (gracefulRampDown: 30s, gracefulStop: 30s)


running (2m00.0s), 00/10 VUs, 372061 complete and 0 interrupted iterations
default ✓ [======================================] 00/10 VUs  2m0s
     █ main index page

       ✓ is status 200

     checks.........................: 100.00% ✓ 372061      ✗ 0     
     data_received..................: 881 MB  7.3 MB/s
     data_sent......................: 15 MB   121 kB/s
     group_duration.................: avg=716.71µs min=202.28µs med=366.9µs  max=27.68ms  p(95)=1.98ms   p(99)=7.51ms   p(99.99)=18.26ms count=372061
     http_req_blocked...............: avg=295ns    min=109ns    med=218ns    max=3.58ms   p(95)=296ns    p(99)=338ns    p(99.99)=9.46µs  count=372061
     http_req_connecting............: avg=5ns      min=0s       med=0s       max=871.71µs p(95)=0s       p(99)=0s       p(99.99)=0s      count=372061
     http_req_duration..............: avg=660.38µs min=159.34µs med=309.89µs max=36.12ms  p(95)=1.9ms    p(99)=7.39ms   p(99.99)=21.27ms count=372061
       { expected_response:true }...: avg=660.38µs min=159.34µs med=309.89µs max=36.12ms  p(95)=1.9ms    p(99)=7.39ms   p(99.99)=21.27ms count=372061
     ✓ { gzip:yes }.................: avg=660.38µs min=159.34µs med=309.89µs max=36.12ms  p(95)=1.9ms    p(99)=7.39ms   p(99.99)=21.27ms count=372061
     http_req_failed................: 0.00%   ✓ 0           ✗ 372061
     http_req_receiving.............: avg=129.3µs  min=8.84µs   med=19.65µs  max=25.19ms  p(95)=699.68µs p(99)=1.29ms   p(99.99)=12.77ms count=372061
     http_req_sending...............: avg=49.92µs  min=16.27µs  med=28.76µs  max=22.97ms  p(95)=182.66µs p(99)=248.71µs p(99.99)=11.58ms count=372061
     http_req_tls_handshaking.......: avg=45ns     min=0s       med=0s       max=3.41ms   p(95)=0s       p(99)=0s       p(99.99)=0s      count=372061
     http_req_waiting...............: avg=481.15µs min=0s       med=241.92µs max=27.27ms  p(95)=1.09ms   p(99)=6.73ms   p(99.99)=15.53ms count=372061
     http_reqs......................: 372061  3100.424592/s
     iteration_duration.............: avg=1.28ms   min=614.18µs med=901.1µs  max=33.76ms  p(95)=2.83ms   p(99)=8.93ms   p(99.99)=22.37ms count=372061
     iterations.....................: 372061  3100.424592/s
     vus............................: 1       min=1         max=10  
     vus_max........................: 10      min=10        max=10  Process finished (121.11 seconds)
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

To filter for `http_req_duration` entries that have status >= 200

```
pzcat summary-raw.gz | jq '. | select(.type=="Point" and .metric == "http_req_duration" and .data.tags.status >= "200")'
```

To average the value for `http_req_duration` entries that have status >= 200

```
pzcat summary-raw.gz | jq '. | select(.type=="Point" and .metric == "http_req_duration" and .data.tags.status >= "200") | .data.value' | jq -s 'add/length'
```

To min the value for `http_req_duration` entries that have status >= 200

```
pzcat summary-raw.gz | jq '. | select(.type=="Point" and .metric == "http_req_duration" and .data.tags.status >= "200") | .data.value' | jq -s min
```

To max the value for `http_req_duration` entries that have status >= 200

```
pzcat summary-raw.gz | jq '. | select(.type=="Point" and .metric == "http_req_duration" and .data.tags.status >= "200") | .data.value' | jq -s max
```

psrecord recorded cpu and memory usage on 4x core/8x thread Intel i7 4790K server.

For k6 run itself

![benchmark.js](/screenshots/users/plot-user-no-sleep.png)

For Nginx web server tested

![nginx](/screenshots/users/plot-user-no-sleep-nginx.png)

## User Concurrency Benchmarks With Random Sleep

User 25, 50, 100, 0 concurrency 4 stage benchmarks with random sleep between 1 to 5 seconds with [`psrecord`](https://github.com/astrofrog/psrecord/) in `benchmark2.js` for `export default function ()`.  Where `--duration $((TIME*5+30))` is the time multiple by the 4+1 stage runs + 30s defined in `benchmark2.js`

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

# gather nginx resource usage via psrecord in background
# get Nginx MainPID value using Centmin Mod cminfo server-info tool
spid=$(cminfo service-info nginx | jq -r '.MainPID')
# set duration to 180 seconds as benchmark2.js uses 4x 30s stages + 30s = 2 1/2 min run time
psrecord $spid --include-children --interval 0.1 --duration $((TIME*5+30)) --log psrecord-user-nginx.log --plot plot-user-nginx.png &

# run k6 initiated via psrecord
psrecord "taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw2.gz benchmark2.js" --include-children --interval 0.1 --duration $((TIME*5+30)) --log psrecord-user.log --plot plot-user.png
```

```
TIME=30
DOMAIN=https://yourdomain.com/

# run k6 initiated via psrecord
psrecord "taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw2.gz benchmark2.js" --include-children --interval 0.1 --duration $((TIME*5+30)) --log psrecord-user-nginx.log --plot plot-user.png

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


running (2m01.3s), 000/100 VUs, 1839 complete and 0 interrupted iterations
default ✓ [======================================] 000/100 VUs  2m0s
     █ main index page

       ✓ is status 200

     checks.........................: 100.00% ✓ 1839     ✗ 0    
     data_received..................: 4.5 MB  37 kB/s
     data_sent......................: 142 kB  1.2 kB/s
     group_duration.................: avg=2.94s    min=1s       med=3s       max=5.01s    p(95)=5s       p(99)=5s       p(99.99)=5.01s    count=1839
     http_req_blocked...............: avg=62.14µs  min=199ns    med=312ns    max=10.03ms  p(95)=822.43µs p(99)=1.07ms   p(99.99)=9.88ms   count=1839
     http_req_connecting............: avg=16.21µs  min=0s       med=0s       max=8.95ms   p(95)=70.09µs  p(99)=93.41µs  p(99.99)=8.83ms   count=1839
     http_req_duration..............: avg=269.03µs min=188.43µs med=245.08µs max=11.23ms  p(95)=352.24µs p(99)=479.78µs p(99.99)=9.31ms   count=1839
       { expected_response:true }...: avg=269.03µs min=188.43µs med=245.08µs max=11.23ms  p(95)=352.24µs p(99)=479.78µs p(99.99)=9.31ms   count=1839
     ✓ { gzip:yes }.................: avg=269.03µs min=188.43µs med=245.08µs max=11.23ms  p(95)=352.24µs p(99)=479.78µs p(99.99)=9.31ms   count=1839
     http_req_failed................: 0.00%   ✓ 0        ✗ 1839 
     http_req_receiving.............: avg=27.11µs  min=11.11µs  med=22.3µs   max=178.46µs p(95)=39.61µs  p(99)=115.98µs p(99.99)=177.74µs count=1839
     http_req_sending...............: avg=68.49µs  min=29.51µs  med=40.3µs   max=399.02µs p(95)=237.77µs p(99)=303.61µs p(99.99)=398.04µs count=1839
     http_req_tls_handshaking.......: avg=40.37µs  min=0s       med=0s       max=1.22ms   p(95)=664.3µs  p(99)=843.76µs p(99.99)=1.19ms   count=1839
     http_req_waiting...............: avg=173.42µs min=0s       med=175.37µs max=11.16ms  p(95)=239.56µs p(99)=342.52µs p(99.99)=9.24ms   count=1839
     http_reqs......................: 1839    15.15872/s
     iteration_duration.............: avg=2.94s    min=1s       med=3s       max=5.01s    p(95)=5s       p(99)=5s       p(99.99)=5.01s    count=1839
     iterations.....................: 1839    15.15872/s
     vus............................: 3       min=1      max=100
     vus_max........................: 100     min=100    max=100Process finished (121.99 seconds)
```

psrecord recorded cpu and memory usage on 4x core/8x thread Intel i7 4790K server.

For k6 run itself

![benchmark2.js](/screenshots/users/plot-user.png)

For Nginx web server tested

![nginx](/screenshots/users/plot-user-nginx.png)

# InfluxDB + Grafana

Send results to InfluxDB database using `--out influxdb=http://localhost:8186/k6` where `--duration $((TIME*5+30))` is the time multiple by the 4+1 stage runs + 30s defined in `benchmark.js`.

```
TIME=60
DOMAIN=https://yourdomain.com/
export K6_INFLUXDB_USERNAME=
export K6_INFLUXDB_PASSWORD=

# gather nginx resource usage via psrecord in background
# get Nginx MainPID value using Centmin Mod cminfo server-info tool
spid=$(cminfo service-info nginx | jq -r '.MainPID')
# set duration to 180 seconds as benchmark2.js uses 4x 30s stages + 30s = 2 1/2 min run time
psrecord $spid --include-children --interval 0.1 --duration $((TIME*5+30)) --log psrecord-user-nginx.log --plot plot-user-nginx.png &

# run k6 initiated via psrecord
psrecord "taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out influxdb=http://localhost:8186/k6 benchmark.js" --include-children --interval 0.1 --duration $((TIME*5+30)) --log psrecord-user-no-sleep.log --plot plot-user-no-sleep.png
```
```
IME=60
DOMAIN=https://yourdomain.com/
export K6_INFLUXDB_USERNAME=
export K6_INFLUXDB_PASSWORD=

# gather nginx resource usage via psrecord in background
# get Nginx MainPID value using Centmin Mod cminfo server-info tool
spid=$(cminfo service-info nginx | jq -r '.MainPID')
# set duration to 180 seconds as benchmark2.js uses 4x 30s stages + 30s = 2 1/2 min run time
psrecord $spid --include-children --interval 0.1 --duration $((TIME*5+30)) --log psrecord-user-nginx.log --plot plot-user-nginx.png &

# run k6 initiated via psrecord
psrecord "taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out influxdb=http://localhost:8186/k6 benchmark.js" --include-children --interval 0.1 --duration $((TIME*5+30)) --log psrecord-user-no-sleep.log --plot plot-user-no-sleep.png

Starting up command 'taskset -c 0-3 k6 run -e STAGETIME=60s -e URL=https://domain1.com/ --no-usage-report --out influxdb=http://localhost:8186/k6 benchmark.js' and attaching to process

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

  execution: local
     script: benchmark.js
     output: InfluxDBv1 (http://localhost:8186)

  scenarios: (100.00%) 1 scenario, 10 max VUs, 4m30s max duration (incl. graceful stop):
           * default: Up to 10 looping VUs for 4m0s over 4 stages (gracefulRampDown: 30s, gracefulStop: 30s)


running (4m00.0s), 00/10 VUs, 662696 complete and 0 interrupted iterations
default ✓ [======================================] 00/10 VUs  4m0s
     █ main index page

       ✓ is status 200

     checks.........................: 100.00% ✓ 662696      ✗ 0     
     data_received..................: 1.6 GB  6.5 MB/s
     data_sent......................: 26 MB   108 kB/s
     group_duration.................: avg=835.65µs min=204.7µs  med=391.48µs max=44.95ms p(95)=2.5ms    p(99)=8.66ms   p(99.99)=22.5ms  count=662696
     http_req_blocked...............: avg=282ns    min=108ns    med=219ns    max=6.66ms  p(95)=306ns    p(99)=373ns    p(99.99)=6.96µs  count=662696
     http_req_connecting............: avg=7ns      min=0s       med=0s       max=2.51ms  p(95)=0s       p(99)=0s       p(99.99)=0s      count=662696
     http_req_duration..............: avg=778.74µs min=160.25µs med=332.7µs  max=48.17ms p(95)=2.4ms    p(99)=8.53ms   p(99.99)=25.54ms count=662696
       { expected_response:true }...: avg=778.74µs min=160.25µs med=332.7µs  max=48.17ms p(95)=2.4ms    p(99)=8.53ms   p(99.99)=25.54ms count=662696
     ✓ { gzip:yes }.................: avg=778.74µs min=160.25µs med=332.7µs  max=48.17ms p(95)=2.4ms    p(99)=8.53ms   p(99.99)=25.54ms count=662696
     http_req_failed................: 0.00%   ✓ 0           ✗ 662696
     http_req_receiving.............: avg=191.2µs  min=8.58µs   med=21.11µs  max=35.75ms p(95)=949.41µs p(99)=1.96ms   p(99.99)=16.61ms count=662696
     http_req_sending...............: avg=58.95µs  min=16.99µs  med=29.45µs  max=24.3ms  p(95)=188.91µs p(99)=256.45µs p(99.99)=13.62ms count=662696
     http_req_tls_handshaking.......: avg=31ns     min=0s       med=0s       max=5.16ms  p(95)=0s       p(99)=0s       p(99.99)=0s      count=662696
     http_req_waiting...............: avg=528.58µs min=0s       med=255.01µs max=34.53ms p(95)=1.31ms   p(99)=7.42ms   p(99.99)=18.2ms  count=662696
     http_reqs......................: 662696  2761.210042/s
     iteration_duration.............: avg=1.44ms   min=623.59µs med=962.19µs max=45.39ms p(95)=3.51ms   p(99)=10.27ms  p(99.99)=26.91ms count=662696
     iterations.....................: 662696  2761.210042/s
     vus............................: 1       min=1         max=10  
     vus_max........................: 10      min=10        max=10  Process finished (241.43 seconds)
```