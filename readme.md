[k6 benchmarking](https://k6.io/docs/)

```
TIME=10
DOMAIN=https://domain.com/
taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report benchmark.js
```

```
TIME=10
DOMAIN=https://domain.com/

taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report benchmark.js

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
cat summary.json | jq -r
{
  "root_group": {
    "name": "",
    "path": "",
    "id": "d41d8cd98f00b204e9800998ecf8427e",
    "groups": [],
    "checks": [
      {
        "name": "is status 200",
        "path": "::is status 200",
        "id": "548d37ca5f33793206f7832e7cea54fb",
        "passes": 17044,
        "fails": 0
      }
    ]
  },
  "options": {
    "summaryTimeUnit": "",
    "noColor": false,
    "summaryTrendStats": [
      "avg",
      "min",
      "med",
      "max",
      "p(95)",
      "p(99)",
      "p(99.99)",
      "count"
    ]
  },
  "state": {
    "isStdOutTTY": true,
    "isStdErrTTY": true,
    "testRunDurationMs": 30009.057334
  },
  "metrics": {
    "http_req_duration": {
      "type": "trend",
      "contains": "time",
      "values": {
        "avg": 43.53751052880767,
        "min": 23.303409,
        "med": 39.683377500000006,
        "max": 1269.039757,
        "p(95)": 59.66280284999999,
        "p(99)": 109.76981728999989,
        "p(99.99)": 1087.9781424287728,
        "count": 17044
      },
      "thresholds": {
        "avg<150": {
          "ok": true
        },
        "p(95)<500": {
          "ok": true
        }
      }
    },
    "iterations": {
      "values": {
        "count": 17044,
        "rate": 567.9618593246945
      },
      "type": "counter",
      "contains": "default"
    },
    "http_reqs": {
      "contains": "default",
      "values": {
        "count": 17044,
        "rate": 567.9618593246945
      },
      "type": "counter"
    },
    "http_req_duration{expected_response:true}": {
      "type": "trend",
      "contains": "time",
      "values": {
        "min": 23.303409,
        "med": 39.683377500000006,
        "max": 1269.039757,
        "p(95)": 59.66280284999999,
        "p(99)": 109.76981728999989,
        "p(99.99)": 1087.9781424287728,
        "count": 17044,
        "avg": 43.53751052880767
      }
    },
    "vus": {
      "type": "gauge",
      "contains": "default",
      "values": {
        "max": 49,
        "value": 1,
        "min": 1
      }
    },
    "checks": {
      "type": "rate",
      "contains": "default",
      "values": {
        "rate": 1,
        "passes": 17044,
        "fails": 0
      }
    },
    "http_req_blocked": {
      "type": "trend",
      "contains": "time",
      "values": {
        "p(99.99)": 22.271700314298094,
        "count": 17044,
        "avg": 0.056543071755464754,
        "min": 0.000158,
        "med": 0.00022,
        "max": 34.51998,
        "p(95)": 0.000265,
        "p(99)": 0.000381
      }
    },
    "http_req_tls_handshaking": {
      "contains": "time",
      "values": {
        "p(95)": 0,
        "p(99)": 0,
        "p(99.99)": 12.831846485799886,
        "count": 17044,
        "avg": 0.032124895623093175,
        "min": 0,
        "med": 0,
        "max": 13.873662
      },
      "type": "trend"
    },
    "data_sent": {
      "type": "counter",
      "contains": "data",
      "values": {
        "count": 2445408,
        "rate": 81488.99756439113
      }
    },
    "http_req_receiving": {
      "values": {
        "med": 31.105896,
        "max": 1260.178657,
        "p(95)": 50.37604709999997,
        "p(99)": 100.51995551999998,
        "p(99.99)": 1079.4701255620719,
        "count": 17044,
        "avg": 34.81435699237258,
        "min": 0.058608
      },
      "type": "trend",
      "contains": "time"
    },
    "http_req_connecting": {
      "type": "trend",
      "contains": "time",
      "values": {
        "max": 10.370439,
        "p(95)": 0,
        "p(99)": 0,
        "p(99.99)": 8.042377501699923,
        "count": 17044,
        "avg": 0.023015993898145973,
        "min": 0,
        "med": 0
      }
    },
    "http_req_sending": {
      "values": {
        "p(99)": 0.04073246999999998,
        "p(99.99)": 0.20581394849997878,
        "count": 17044,
        "avg": 0.02695457175545655,
        "min": 0.016452,
        "med": 0.026554,
        "max": 0.651375,
        "p(95)": 0.032206849999999995
      },
      "type": "trend",
      "contains": "time"
    },
    "http_req_failed": {
      "type": "rate",
      "contains": "default",
      "values": {
        "rate": 0,
        "passes": 0,
        "fails": 17044
      }
    },
    "iteration_duration": {
      "type": "trend",
      "contains": "time",
      "values": {
        "avg": 44.155391581084295,
        "min": 23.806466,
        "med": 40.262916000000004,
        "max": 1269.603512,
        "p(95)": 60.53278899999998,
        "p(99)": 110.30636189999989,
        "p(99.99)": 1088.5021553088727,
        "count": 17044
      }
    },
    "vus_max": {
      "type": "gauge",
      "contains": "default",
      "values": {
        "value": 50,
        "min": 50,
        "max": 50
      }
    },
    "data_received": {
      "type": "counter",
      "contains": "data",
      "values": {
        "count": 384030011,
        "rate": 12797136.768601436
      }
    },
    "http_req_waiting": {
      "type": "trend",
      "contains": "time",
      "values": {
        "max": 63.823354,
        "p(95)": 11.425890299999994,
        "p(99)": 17.43425693,
        "p(99.99)": 47.18762434898802,
        "count": 17044,
        "avg": 8.696198964679633,
        "min": 7.291188,
        "med": 8.2386005
      }
    }
  }
}
```