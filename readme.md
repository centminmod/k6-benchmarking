[k6 benchmarking](https://k6.io/docs/)

```
TIME=10
DOMAIN=https://domain.com/
taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw.gz benchmark.js
```

```
TIME=10
DOMAIN=https://domain.com/

taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw.gz benchmark.js

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

  execution: local
     script: benchmark.js
     output: -

  scenarios: (100.00%) 1 scenario, 50 max VUs, 1m0s max duration (incl. graceful stop):
           * default: Up to 50 looping VUs for 30s over 3 stages (gracefulRampDown: 30s, gracefulStop: 30s)


running (0m30.0s), 00/50 VUs, 17044 complete and 0 interrupted iterations
default ✓ [======================================] 00/50 VUs  30s
     ✓ is status 200

     checks.........................: 100.00% ✓ 17044      ✗ 0    
     data_received..................: 384 MB  13 MB/s
     data_sent......................: 2.4 MB  82 kB/s
     http_req_blocked...............: avg=56.54µs min=158ns   med=220ns   max=34.51ms  p(95)=265ns   p(99)=381ns    p(99.99)=22.27ms  count=17044
     http_req_connecting............: avg=23.01µs min=0s      med=0s      max=10.37ms  p(95)=0s      p(99)=0s       p(99.99)=8.04ms   count=17044
   ✓ http_req_duration..............: avg=43.53ms min=23.3ms  med=39.68ms max=1.26s    p(95)=59.66ms p(99)=109.76ms p(99.99)=1.08s    count=17044
       { expected_response:true }...: avg=43.53ms min=23.3ms  med=39.68ms max=1.26s    p(95)=59.66ms p(99)=109.76ms p(99.99)=1.08s    count=17044
     http_req_failed................: 0.00%   ✓ 0          ✗ 17044
     http_req_receiving.............: avg=34.81ms min=58.6µs  med=31.1ms  max=1.26s    p(95)=50.37ms p(99)=100.51ms p(99.99)=1.07s    count=17044
     http_req_sending...............: avg=26.95µs min=16.45µs med=26.55µs max=651.37µs p(95)=32.2µs  p(99)=40.73µs  p(99.99)=205.81µs count=17044
     http_req_tls_handshaking.......: avg=32.12µs min=0s      med=0s      max=13.87ms  p(95)=0s      p(99)=0s       p(99.99)=12.83ms  count=17044
     http_req_waiting...............: avg=8.69ms  min=7.29ms  med=8.23ms  max=63.82ms  p(95)=11.42ms p(99)=17.43ms  p(99.99)=47.18ms  count=17044
     http_reqs......................: 17044   567.961859/s
     iteration_duration.............: avg=44.15ms min=23.8ms  med=40.26ms max=1.26s    p(95)=60.53ms p(99)=110.3ms  p(99.99)=1.08s    count=17044
     iterations.....................: 17044   567.961859/s
     vus............................: 1       min=1        max=49 
     vus_max........................: 50      min=50       max=50
```

```
cat summary.json | jq -r '.metrics.iterations.values'
{
  "count": 16510,
  "rate": 549.995877862512
}

total_reqs=$(cat summary.json | jq -r '.metrics.iterations.values.count')
echo $total_reqs
16510

total_time_ms=$(cat summary.json | jq -r '.state.testRunDurationMs')
echo $total_time_ms
30018.4068

req_avg=$(echo "scale=4; (($total_reqs*1000)+1)/$total_time_ms" | bc)
echo $req_avg
549.9959
```
```
cat summary.json | jq -r
{
  "root_group": {
    "name": "",
    "path": "",
    "id": "d41d8cd98f00b204e9800998ecf8427e",
    "groups": [],
    "checks": [
      {
        "path": "::is status 200",
        "id": "548d37ca5f33793206f7832e7cea54fb",
        "passes": 16510,
        "fails": 0,
        "name": "is status 200"
      }
    ]
  },
  "options": {
    "summaryTrendStats": [
      "avg",
      "min",
      "med",
      "max",
      "p(95)",
      "p(99)",
      "p(99.99)",
      "count"
    ],
    "summaryTimeUnit": "",
    "noColor": false
  },
  "state": {
    "isStdOutTTY": true,
    "isStdErrTTY": true,
    "testRunDurationMs": 30018.4068
  },
  "metrics": {
    "iterations": {
      "type": "counter",
      "contains": "default",
      "values": {
        "count": 16510,
        "rate": 549.995877862512
      }
    },
    "http_req_receiving": {
      "type": "trend",
      "contains": "time",
      "values": {
        "count": 16510,
        "avg": 36.10654372192611,
        "min": 0.059631,
        "med": 31.0860625,
        "max": 1339.348538,
        "p(95)": 54.239267049999995,
        "p(99)": 132.0235648099999,
        "p(99.99)": 1252.4198957093668
      }
    },
    "checks": {
      "type": "rate",
      "contains": "default",
      "values": {
        "rate": 1,
        "passes": 16510,
        "fails": 0
      }
    },
    "data_sent": {
      "type": "counter",
      "contains": "data",
      "values": {
        "count": 2369335,
        "rate": 78929.4054073516
      }
    },
    "iteration_duration": {
      "type": "trend",
      "contains": "time",
      "values": {
        "count": 16510,
        "avg": 45.59901832755892,
        "min": 25.148598,
        "med": 40.4515685,
        "max": 1348.143286,
        "p(95)": 64.59459915000001,
        "p(99)": 143.66649320999957,
        "p(99.99)": 1261.8934037913673
      }
    },
    "data_received": {
      "type": "counter",
      "contains": "data",
      "values": {
        "count": 372009371,
        "rate": 12392708.696318952
      }
    },
    "http_req_tls_handshaking": {
      "type": "trend",
      "contains": "time",
      "values": {
        "p(95)": 0,
        "p(99)": 0,
        "p(99.99)": 14.321864458399698,
        "count": 16510,
        "avg": 0.03539912822531798,
        "min": 0,
        "med": 0,
        "max": 16.66999
      }
    },
    "http_req_failed": {
      "type": "rate",
      "contains": "default",
      "values": {
        "rate": 0,
        "passes": 0,
        "fails": 16510
      }
    },
    "http_req_blocked": {
      "values": {
        "p(99.99)": 22.952176860398826,
        "count": 16510,
        "avg": 0.06179921380982189,
        "min": 0.000127,
        "med": 0.000219,
        "max": 59.246316,
        "p(95)": 0.000239,
        "p(99)": 0.00036290999999999987
      },
      "type": "trend",
      "contains": "time"
    },
    "vus": {
      "values": {
        "value": 1,
        "min": 1,
        "max": 49
      },
      "type": "gauge",
      "contains": "default"
    },
    "http_reqs": {
      "type": "counter",
      "contains": "default",
      "values": {
        "count": 16510,
        "rate": 549.995877862512
      }
    },
    "http_req_waiting": {
      "type": "trend",
      "contains": "time",
      "values": {
        "p(99.99)": 59.61232987369813,
        "count": 16510,
        "avg": 8.845250028285916,
        "min": 7.561289,
        "med": 8.307763,
        "max": 65.514674,
        "p(95)": 11.69161625,
        "p(99)": 19.115903949999993
      }
    },
    "http_req_duration": {
      "values": {
        "count": 16510,
        "avg": 44.9799197625076,
        "min": 24.640801,
        "med": 39.877318,
        "max": 1347.61271,
        "p(95)": 63.726093199999994,
        "p(99)": 143.15519861999957,
        "p(99.99)": 1261.191049104467
      },
      "thresholds": {
        "avg<150": {
          "ok": true
        },
        "p(95)<500": {
          "ok": true
        }
      },
      "type": "trend",
      "contains": "time"
    },
    "http_req_duration{expected_response:true}": {
      "values": {
        "p(99.99)": 1261.191049104467,
        "count": 16510,
        "avg": 44.9799197625076,
        "min": 24.640801,
        "med": 39.877318,
        "max": 1347.61271,
        "p(95)": 63.726093199999994,
        "p(99)": 143.15519861999957
      },
      "type": "trend",
      "contains": "time"
    },
    "http_req_connecting": {
      "type": "trend",
      "contains": "time",
      "values": {
        "min": 0,
        "med": 0,
        "max": 7.982053,
        "p(95)": 0,
        "p(99)": 0,
        "p(99.99)": 7.965347443099998,
        "count": 16510,
        "avg": 0.023538600847970922
      }
    },
    "http_req_sending": {
      "values": {
        "min": 0.016031,
        "med": 0.026752,
        "max": 9.180571,
        "p(95)": 0.03207839999999999,
        "p(99)": 0.04113023999999999,
        "p(99.99)": 2.363560251196925,
        "count": 16510,
        "avg": 0.028126012295578446
      },
      "type": "trend",
      "contains": "time"
    },
    "vus_max": {
      "type": "gauge",
      "contains": "default",
      "values": {
        "value": 50,
        "min": 50,
        "max": 50
      }
    }
  }
}
```

Filter for `http_req_duration` and status = `200`

```
pzcat -f summary-raw.gz | jq '. | select(.type=="Point" and .metric == "http_req_duration" and .data.tags.status >= "200")'
```

Average for `http_req_duration` and status = `200`

```
pzcat -f summary-raw.gz | jq '. | select(.type=="Point" and .metric == "http_req_duration" and .data.tags.status >= "200") | .data.value' | jq -s 'add/length'
```

Min for `http_req_duration` and status = `200`

```
pzcat -f summary-raw.gz | jq '. | select(.type=="Point" and .metric == "http_req_duration" and .data.tags.status >= "200") | .data.value' | jq -s min
```

Max for `http_req_duration` and status = `200`

```
pzcat -f summary-raw.gz | jq '. | select(.type=="Point" and .metric == "http_req_duration" and .data.tags.status >= "200") | .data.value' | jq -s max
```

`http_reqs`

Total requests

```
pzcat -f summary-raw.gz | jq '. | select(.type=="Point" and .metric == "http_reqs" and .data.tags.status >= "200") | .data.value' | jq -s 'add'
16510
```

```
pzcat -f summary-raw.gz | jq '. | select(.type=="Point" and .metric == "http_reqs" and .data.tags.status >= "200")' | jq -c | tail -2 | jq
{
  "type": "Point",
  "data": {
    "time": "2022-07-11T00:18:34.249760961Z",
    "value": 1,
    "tags": {
      "expected_response": "true",
      "group": "",
      "url": "https://domain.com/",
      "proto": "HTTP/2.0",
      "tls_version": "tls1.3",
      "status": "200",
      "scenario": "default",
      "stage": "2",
      "name": "https://domain.com/",
      "method": "GET"
    }
  },
  "metric": "http_reqs"
}
{
  "type": "Point",
  "data": {
    "time": "2022-07-11T00:18:34.29347122Z",
    "value": 1,
    "tags": {
      "group": "",
      "stage": "2",
      "method": "GET",
      "status": "200",
      "tls_version": "tls1.3",
      "scenario": "default",
      "url": "https://domain.com/",
      "name": "https://domain.com/",
      "proto": "HTTP/2.0",
      "expected_response": "true"
    }
  },
  "metric": "http_reqs"
}
```