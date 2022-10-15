# Log Parsing Tools

* [json2jqpath](https://github.com/TomConlin/json_to_paths)
* https://jsoncrack.com/

```
wget -O /usr/local/bin/json2jqpath https://github.com/TomConlin/json_to_paths/raw/master/json2jqpath.jq
chmod +x /usr/local/bin/json2jqpath
```

# Parsing k6 handleSummary

k6 benchmark script's `handleSummary` JSON log parsing

```
export function handleSummary(data) {
  return {
    "result-scenarios.html": htmlReport(data),
    stdout: textSummary(data, { indent: " ", enableColors: true }),
    "summary-scenarios-htmlreport.json": JSON.stringify(data),
  };
}
```

Example k6 run

```
./bench-ramping-vus.sh run-local https://domain1.com 2 2,5,7,0 5 10
start k6 test

#####################################################################
start time (Australia/Brisbane): Sat Oct 15 11:15:01 AEST 2022
start nanosecond time (Australia/Brisbane): 1665796501000000000
start time (UTC): Sat Oct 15 01:15:01 UTC 2022
start nanosecond time (UTC): 1665796501000000000
#####################################################################

psrecord 1013 --include-children --interval 0.1 --duration 27 --log /home/k6-workdir/psrecord-ramping-7vus-nginx.log --plot /home/k6-workdir/plot-ramping-7vus-nginx.png &

taskset -c 0-3 k6 run --tag testname=rampingvus -e RPS=5 -e REQRATE_USERS=10 -e USERS=0 -e STAGETIME=2s -e STAGE_VU1=2 -e STAGE_VU2=5 -e STAGE_VU3=7 -e STAGE_VU4=0 -e URL=https://domain1.com --no-usage-report --out json=/home/k6-workdir/summary-raw-scenarios-multi.gz benchmark-scenarios-multi.js

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

Attaching to process 1013
  execution: local
     script: benchmark-scenarios-multi.js
     output: json (/home/k6-workdir/summary-raw-scenarios-multi.gz)

  scenarios: (100.00%) 2 scenarios, 150000 max VUs, 33s max duration (incl. graceful stop):
           * constant_arrival_rate: 5.00 iterations/s for 2s (maxVUs: 10-150000, exec: constantarrival, gracefulStop: 5s)
           * ramping_vus: Up to 7 looping VUs for 8s over 4 stages (gracefulRampDown: 5s, exec: default, startTime: 20s, gracefulStop: 5s)


running (31.7s), 000000/000010 VUs, 23 complete and 0 interrupted iterations
constant_arrival_rate ✓ [======================================] 000000/000010 VUs  2s  5.00 iters/s
ramping_vus           ✓ [======================================] 0/7 VUs            8s 
INFO[0032] [k6-reporter v2.3.0] Generating HTML summary report  source=console
     ✓ is status 200

     checks.........................: 100.00% ✓ 23       ✗ 0   
     data_received..................: 72 kB   2.3 kB/s
     data_sent......................: 7.0 kB  220 B/s
     http_req_blocked...............: avg=558.72µs min=202ns    med=575ns    max=3.19ms   p(95)=1.33ms   p(99)=2.79ms   p(99.99)=3.19ms   count=23
     http_req_connecting............: avg=114.82µs min=0s       med=0s       max=1.94ms   p(95)=98.21µs  p(99)=1.54ms   p(99.99)=1.94ms   count=23
     http_req_duration..............: avg=420.48µs min=239.75µs med=341.3µs  max=1.15ms   p(95)=597.82µs p(99)=1.03ms   p(99.99)=1.15ms   count=23
       { expected_response:true }...: avg=420.48µs min=239.75µs med=341.3µs  max=1.15ms   p(95)=597.82µs p(99)=1.03ms   p(99.99)=1.15ms   count=23
     http_req_failed................: 0.00%   ✓ 0        ✗ 23  
     http_req_receiving.............: avg=63.76µs  min=18.38µs  med=30.66µs  max=152.96µs p(95)=148.31µs p(99)=152.08µs p(99.99)=152.95µs count=23
     http_req_sending...............: avg=79.82µs  min=28.13µs  med=50.21µs  max=520.29µs p(95)=103.8µs  p(99)=428.67µs p(99.99)=519.38µs count=23
     http_req_tls_handshaking.......: avg=402.13µs min=0s       med=0s       max=1.13ms   p(95)=1.11ms   p(99)=1.12ms   p(99.99)=1.13ms   count=23
     http_req_waiting...............: avg=276.89µs min=53.28µs  med=250.53µs max=1.01ms   p(95)=391.49µs p(99)=878.78µs p(99.99)=1.01ms   count=23
     http_reqs......................: 23      0.726174/s
     iteration_duration.............: avg=1.91s    min=1.31ms   med=2s       max=5s       p(95)=5s       p(99)=5s       p(99.99)=5s       count=23
     iterations.....................: 23      0.726174/s
     vus............................: 3       min=0      max=10
     vus_max........................: 10      min=10     max=10
```

Understanding the JSON data logged.

```
json2jqpath summary-scenarios-htmlreport.json
.
.metrics
.metrics|.checks
.metrics|.checks|.contains
.metrics|.checks|.type
.metrics|.checks|.values
.metrics|.checks|.values|.fails
.metrics|.checks|.values|.passes
.metrics|.checks|.values|.rate
.metrics|.data_received
.metrics|.data_received|.contains
.metrics|.data_received|.type
.metrics|.data_received|.values
.metrics|.data_received|.values|.count
.metrics|.data_received|.values|.rate
.metrics|.data_sent
.metrics|.data_sent|.contains
.metrics|.data_sent|.type
.metrics|.data_sent|.values
.metrics|.data_sent|.values|.count
.metrics|.data_sent|.values|.rate
.metrics|.http_req_blocked
.metrics|.http_req_blocked|.contains
.metrics|.http_req_blocked|.type
.metrics|.http_req_blocked|.values
.metrics|.http_req_blocked|.values|.avg
.metrics|.http_req_blocked|.values|.count
.metrics|.http_req_blocked|.values|.max
.metrics|.http_req_blocked|.values|.med
.metrics|.http_req_blocked|.values|.min
.metrics|.http_req_blocked|.values|.p(95)
.metrics|.http_req_blocked|.values|.p(99)
.metrics|.http_req_blocked|.values|.p(99.99)
.metrics|.http_req_connecting
.metrics|.http_req_connecting|.contains
.metrics|.http_req_connecting|.type
.metrics|.http_req_connecting|.values
.metrics|.http_req_connecting|.values|.avg
.metrics|.http_req_connecting|.values|.count
.metrics|.http_req_connecting|.values|.max
.metrics|.http_req_connecting|.values|.med
.metrics|.http_req_connecting|.values|.min
.metrics|.http_req_connecting|.values|.p(95)
.metrics|.http_req_connecting|.values|.p(99)
.metrics|.http_req_connecting|.values|.p(99.99)
.metrics|.http_req_duration
.metrics|.http_req_duration{expected_response:true}
.metrics|.http_req_duration{expected_response:true}|.contains
.metrics|.http_req_duration{expected_response:true}|.type
.metrics|.http_req_duration{expected_response:true}|.values
.metrics|.http_req_duration{expected_response:true}|.values|.avg
.metrics|.http_req_duration{expected_response:true}|.values|.count
.metrics|.http_req_duration{expected_response:true}|.values|.max
.metrics|.http_req_duration{expected_response:true}|.values|.med
.metrics|.http_req_duration{expected_response:true}|.values|.min
.metrics|.http_req_duration{expected_response:true}|.values|.p(95)
.metrics|.http_req_duration{expected_response:true}|.values|.p(99)
.metrics|.http_req_duration{expected_response:true}|.values|.p(99.99)
.metrics|.http_req_duration|.contains
.metrics|.http_req_duration|.type
.metrics|.http_req_duration|.values
.metrics|.http_req_duration|.values|.avg
.metrics|.http_req_duration|.values|.count
.metrics|.http_req_duration|.values|.max
.metrics|.http_req_duration|.values|.med
.metrics|.http_req_duration|.values|.min
.metrics|.http_req_duration|.values|.p(95)
.metrics|.http_req_duration|.values|.p(99)
.metrics|.http_req_duration|.values|.p(99.99)
.metrics|.http_req_failed
.metrics|.http_req_failed|.contains
.metrics|.http_req_failed|.type
.metrics|.http_req_failed|.values
.metrics|.http_req_failed|.values|.fails
.metrics|.http_req_failed|.values|.passes
.metrics|.http_req_failed|.values|.rate
.metrics|.http_req_receiving
.metrics|.http_req_receiving|.contains
.metrics|.http_req_receiving|.type
.metrics|.http_req_receiving|.values
.metrics|.http_req_receiving|.values|.avg
.metrics|.http_req_receiving|.values|.count
.metrics|.http_req_receiving|.values|.max
.metrics|.http_req_receiving|.values|.med
.metrics|.http_req_receiving|.values|.min
.metrics|.http_req_receiving|.values|.p(95)
.metrics|.http_req_receiving|.values|.p(99)
.metrics|.http_req_receiving|.values|.p(99.99)
.metrics|.http_req_sending
.metrics|.http_req_sending|.contains
.metrics|.http_req_sending|.type
.metrics|.http_req_sending|.values
.metrics|.http_req_sending|.values|.avg
.metrics|.http_req_sending|.values|.count
.metrics|.http_req_sending|.values|.max
.metrics|.http_req_sending|.values|.med
.metrics|.http_req_sending|.values|.min
.metrics|.http_req_sending|.values|.p(95)
.metrics|.http_req_sending|.values|.p(99)
.metrics|.http_req_sending|.values|.p(99.99)
.metrics|.http_req_tls_handshaking
.metrics|.http_req_tls_handshaking|.contains
.metrics|.http_req_tls_handshaking|.type
.metrics|.http_req_tls_handshaking|.values
.metrics|.http_req_tls_handshaking|.values|.avg
.metrics|.http_req_tls_handshaking|.values|.count
.metrics|.http_req_tls_handshaking|.values|.max
.metrics|.http_req_tls_handshaking|.values|.med
.metrics|.http_req_tls_handshaking|.values|.min
.metrics|.http_req_tls_handshaking|.values|.p(95)
.metrics|.http_req_tls_handshaking|.values|.p(99)
.metrics|.http_req_tls_handshaking|.values|.p(99.99)
.metrics|.http_req_waiting
.metrics|.http_req_waiting|.contains
.metrics|.http_req_waiting|.type
.metrics|.http_req_waiting|.values
.metrics|.http_req_waiting|.values|.avg
.metrics|.http_req_waiting|.values|.count
.metrics|.http_req_waiting|.values|.max
.metrics|.http_req_waiting|.values|.med
.metrics|.http_req_waiting|.values|.min
.metrics|.http_req_waiting|.values|.p(95)
.metrics|.http_req_waiting|.values|.p(99)
.metrics|.http_req_waiting|.values|.p(99.99)
.metrics|.http_reqs
.metrics|.http_reqs|.contains
.metrics|.http_reqs|.type
.metrics|.http_reqs|.values
.metrics|.http_reqs|.values|.count
.metrics|.http_reqs|.values|.rate
.metrics|.iteration_duration
.metrics|.iteration_duration|.contains
.metrics|.iteration_duration|.type
.metrics|.iteration_duration|.values
.metrics|.iteration_duration|.values|.avg
.metrics|.iteration_duration|.values|.count
.metrics|.iteration_duration|.values|.max
.metrics|.iteration_duration|.values|.med
.metrics|.iteration_duration|.values|.min
.metrics|.iteration_duration|.values|.p(95)
.metrics|.iteration_duration|.values|.p(99)
.metrics|.iteration_duration|.values|.p(99.99)
.metrics|.iterations
.metrics|.iterations|.contains
.metrics|.iterations|.type
.metrics|.iterations|.values
.metrics|.iterations|.values|.count
.metrics|.iterations|.values|.rate
.metrics|.vus
.metrics|.vus_max
.metrics|.vus_max|.contains
.metrics|.vus_max|.type
.metrics|.vus_max|.values
.metrics|.vus_max|.values|.max
.metrics|.vus_max|.values|.min
.metrics|.vus_max|.values|.value
.metrics|.vus|.contains
.metrics|.vus|.type
.metrics|.vus|.values
.metrics|.vus|.values|.max
.metrics|.vus|.values|.min
.metrics|.vus|.values|.value
.options
.options|.noColor
.options|.summaryTimeUnit
.options|.summaryTrendStats
.options|.summaryTrendStats|.[]
.root_group
.root_group|.checks
.root_group|.checks|.[]
.root_group|.checks|.[]|.fails
.root_group|.checks|.[]|.id
.root_group|.checks|.[]|.name
.root_group|.checks|.[]|.passes
.root_group|.checks|.[]|.path
.root_group|.groups
.root_group|.id
.root_group|.name
.root_group|.path
.state
.state|.isStdErrTTY
.state|.isStdOutTTY
.state|.testRunDurationMs
```

Summary metrics

```
cat summary-scenarios-htmlreport.json | jq -r '.metrics'
{
  "iterations": {
    "type": "counter",
    "contains": "default",
    "values": {
      "count": 23,
      "rate": 0.7261743194872999
    }
  },
  "http_req_duration": {
    "type": "trend",
    "contains": "time",
    "values": {
      "avg": 0.42048634782608696,
      "min": 0.239758,
      "med": 0.341306,
      "max": 1.159394,
      "p(95)": 0.5978299999999999,
      "p(99)": 1.0366507200000006,
      "p(99.99)": 1.158166567199999,
      "count": 23
    }
  },
  "http_req_waiting": {
    "type": "trend",
    "contains": "time",
    "values": {
      "p(99.99)": 1.0131705361999988,
      "count": 23,
      "avg": 0.2768996521739131,
      "min": 0.05328,
      "med": 0.250536,
      "max": 1.014528,
      "p(95)": 0.3914959999999999,
      "p(99)": 0.8787816200000007
    }
  },
  "http_req_blocked": {
    "type": "trend",
    "contains": "time",
    "values": {
      "avg": 0.5587212173913045,
      "min": 0.000202,
      "med": 0.000575,
      "max": 3.199224,
      "p(95)": 1.3378047,
      "p(99)": 2.791910940000002,
      "p(99.99)": 3.1951508693999964,
      "count": 23
    }
  },
  "data_received": {
    "values": {
      "count": 71874,
      "rate": 2269.263175601313
    },
    "type": "counter",
    "contains": "data"
  },
  "checks": {
    "type": "rate",
    "contains": "default",
    "values": {
      "rate": 1,
      "passes": 23,
      "fails": 0
    }
  },
  "vus_max": {
    "type": "gauge",
    "contains": "default",
    "values": {
      "value": 10,
      "min": 10,
      "max": 10
    }
  },
  "vus": {
    "type": "gauge",
    "contains": "default",
    "values": {
      "value": 3,
      "min": 0,
      "max": 10
    }
  },
  "http_req_sending": {
    "contains": "time",
    "values": {
      "p(95)": 0.1038034,
      "p(99)": 0.4286760400000004,
      "p(99.99)": 0.5193827703999991,
      "count": 23,
      "avg": 0.07982617391304346,
      "min": 0.02813,
      "med": 0.050218,
      "max": 0.520299
    },
    "type": "trend"
  },
  "http_req_failed": {
    "type": "rate",
    "contains": "default",
    "values": {
      "fails": 23,
      "rate": 0,
      "passes": 0
    }
  },
  "http_req_connecting": {
    "type": "trend",
    "contains": "time",
    "values": {
      "p(95)": 0.09821919999999999,
      "p(99)": 1.5419803000000023,
      "p(99.99)": 1.9450921629999964,
      "count": 23,
      "avg": 0.11482747826086957,
      "min": 0,
      "med": 0,
      "max": 1.949164
    }
  },
  "iteration_duration": {
    "type": "trend",
    "contains": "time",
    "values": {
      "p(99)": 5001.3872043,
      "p(99.99)": 5001.4184226630005,
      "count": 23,
      "avg": 1914.5429676956521,
      "min": 1.314252,
      "med": 2000.529359,
      "max": 5001.418738,
      "p(95)": 5001.2310413
    }
  },
  "http_req_tls_handshaking": {
    "values": {
      "p(99.99)": 1.1323951034,
      "count": 23,
      "avg": 0.40213043478260874,
      "min": 0,
      "med": 0,
      "max": 1.132428,
      "p(95)": 1.1109289,
      "p(99)": 1.12913834
    },
    "type": "trend",
    "contains": "time"
  },
  "http_req_receiving": {
    "values": {
      "p(95)": 0.1483146,
      "p(99)": 0.15208038,
      "p(99.99)": 0.1529561538,
      "count": 23,
      "avg": 0.06376052173913042,
      "min": 0.018382,
      "med": 0.030668,
      "max": 0.152965
    },
    "type": "trend",
    "contains": "time"
  },
  "data_sent": {
    "type": "counter",
    "contains": "data",
    "values": {
      "count": 6980,
      "rate": 220.3781195661458
    }
  },
  "http_reqs": {
    "type": "counter",
    "contains": "default",
    "values": {
      "count": 23,
      "rate": 0.7261743194872999
    }
  },
  "http_req_duration{expected_response:true}": {
    "values": {
      "p(95)": 0.5978299999999999,
      "p(99)": 1.0366507200000006,
      "p(99.99)": 1.158166567199999,
      "count": 23,
      "avg": 0.42048634782608696,
      "min": 0.239758,
      "med": 0.341306,
      "max": 1.159394
    },
    "type": "trend",
    "contains": "time"
  }
}
```

CSV formatted `http_req_duration{expected_response:true}` metrics

```
cat summary-scenarios-htmlreport.json | jq -r '.metrics | ."http_req_duration{expected_response:true}".values | to_entries|map(.key),(map(.value)) | @csv' | sed -e 's|\"||g'

p(95),p(99),p(99.99),count,avg,min,med,max
0.5978299999999999,1.0366507200000006,1.158166567199999,23,0.42048634782608696,0.239758,0.341306,1.159394
```

sorted

```
cat summary-scenarios-htmlreport.json | jq -r '.metrics | ."http_req_duration{expected_response:true}".values | to_entries|map(.key),(map(.value)) | sort | @csv' | sed -e 's|\"||g'

avg,count,max,med,min,p(95),p(99),p(99.99)
0.239758,0.341306,0.42048634782608696,0.5978299999999999,1.0366507200000006,1.158166567199999,1.159394,23
```

table format

```
cat summary-scenarios-htmlreport.json | jq -r '.metrics | ."http_req_duration{expected_response:true}".values | to_entries|map(.key),(map(.value)) | @tsv' | column -t

p(95)               p(99)               p(99.99)           count  avg                  min       med       max
0.5978299999999999  1.0366507200000006  1.158166567199999  23     0.42048634782608696  0.239758  0.341306  1.159394
```

CSV formatted `http_reqs` metrics

```
cat summary-scenarios-htmlreport.json | jq -r '.metrics | ."http_reqs".values | to_entries|map(.key),(map(.value)) | @csv' | sed -e 's|\"||g'

count,rate
23,0.7261743194872999
```

table format

```
cat summary-scenarios-htmlreport.json | jq -r '.metrics | ."http_reqs".values | to_entries|map(.key),(map(.value)) | @tsv' | column -t

count  rate
23     0.7261743194872999
```

Filter for `http_reqs` and `http_req_duration{expected_response:true}`

```
cat summary-scenarios-htmlreport.json | jq -r '.metrics | [ ."http_reqs", ."http_req_duration{expected_response:true}" ] | .[]'
{
  "type": "counter",
  "contains": "default",
  "values": {
    "count": 23,
    "rate": 0.7261743194872999
  }
}
{
  "values": {
    "p(95)": 0.5978299999999999,
    "p(99)": 1.0366507200000006,
    "p(99.99)": 1.158166567199999,
    "count": 23,
    "avg": 0.42048634782608696,
    "min": 0.239758,
    "med": 0.341306,
    "max": 1.159394
  },
  "type": "trend",
  "contains": "time"
}
```

Combining respective values

```
cat summary-scenarios-htmlreport.json | jq -r '.metrics | [ ."http_reqs", ."http_req_duration{expected_response:true}" ] | .[]' | jq -n 'reduce inputs as $item ({}; . *= $item) | .values'
{
  "count": 23,
  "rate": 0.7261743194872999,
  "p(95)": 0.5978299999999999,
  "p(99)": 1.0366507200000006,
  "p(99.99)": 1.158166567199999,
  "avg": 0.42048634782608696,
  "min": 0.239758,
  "med": 0.341306,
  "max": 1.159394
}
```

Into CSV format

```
at summary-scenarios-htmlreport.json | jq -r '.metrics | [ ."http_reqs", ."http_req_duration{expected_response:true}" ] | .[]' | jq -n 'reduce inputs as $item ({}; . *= $item) | .values' | jq 'to_entries|map(.key),(map(.value)) | @csv' | sed -e 's|\"||g' -e 's|\\||g'

count,rate,p(95),p(99),p(99.99),avg,min,med,max
23,0.7261743194872999,0.5978299999999999,1.0366507200000006,1.158166567199999,0.42048634782608696,0.239758,0.341306,1.159394
```

Into table format

```
cat summary-scenarios-htmlreport.json | jq -r '.metrics | [ ."http_reqs", ."http_req_duration{expected_response:true}" ] | .[]' | jq -n 'reduce inputs as $item ({}; . *= $item) | .values' | jq 'to_entries|map(.key),(map(.value)) | @tsv' | sed -e 's|\\t| |g' -e 's|\"||g' | column -t

count  rate                p(95)               p(99)               p(99.99)           avg                  min       med       max
23     0.7261743194872999  0.5978299999999999  1.0366507200000006  1.158166567199999  0.42048634782608696  0.239758  0.341306  1.159394
```