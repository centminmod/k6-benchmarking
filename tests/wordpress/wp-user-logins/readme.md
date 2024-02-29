```
k6 version
k6 v0.49.0 (commit/b5328aa782, go1.21.6, linux/amd64)
```
```
k6 run -e SITE_URL=https://wpel9.domain.com wp-user-login.js --insecure-skip-tls-verify

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

     execution: local
        script: wp-user-login.js
        output: -

     scenarios: (100.00%) 1 scenario, 100 max VUs, 1m30.1s max duration (incl. graceful stop):
              * default: Up to 100 looping VUs for 1m0.06s over 3 stages (gracefulRampDown: 30s, gracefulStop: 30s)

INFO[0061] [k6-reporter v2.3.0] Generating HTML summary report  source=console
     ✓ is status 200

     checks.........................: 100.00% ✓ 3013      ✗ 0    
     data_received..................: 8.5 MB  140 kB/s
     data_sent......................: 654 kB  11 kB/s
     http_req_blocked...............: avg=35.48µs min=185ns   med=411ns   max=1.33ms   p(95)=814ns   p(99)=1.06ms   p(99.99)=1.33ms   count=3013
     http_req_connecting............: avg=3.34µs  min=0s      med=0s      max=171.33µs p(95)=0s      p(99)=108.26µs p(99.99)=159.64µs count=3013
     http_req_duration..............: avg=16.26ms min=11.64ms med=15.88ms max=31.28ms  p(95)=21.89ms p(99)=23.12ms  p(99.99)=30.72ms  count=3013
       { expected_response:true }...: avg=16.26ms min=11.64ms med=15.88ms max=31.28ms  p(95)=21.89ms p(99)=23.12ms  p(99.99)=30.72ms  count=3013
     http_req_failed................: 0.00%   ✓ 0         ✗ 3013 
     http_req_receiving.............: avg=52.06µs min=18.19µs med=49.16µs max=359.02µs p(95)=82.83µs p(99)=96.39µs  p(99.99)=289.05µs count=3013
     http_req_sending...............: avg=66.81µs min=30.29µs med=64.34µs max=194.76µs p(95)=95.19µs p(99)=125.5µs  p(99.99)=192.68µs count=3013
     http_req_tls_handshaking.......: avg=28.2µs  min=0s      med=0s      max=1.17ms   p(95)=0s      p(99)=858.96µs p(99.99)=1.15ms   count=3013
     http_req_waiting...............: avg=16.14ms min=11.53ms med=15.76ms max=31.16ms  p(95)=21.78ms p(99)=23ms     p(99.99)=30.6ms   count=3013
     http_reqs......................: 3013    49.484134/s
     iteration_duration.............: avg=1.01s   min=1.01s   med=1.01s   max=1.03s    p(95)=1.02s   p(99)=1.02s    p(99.99)=1.03s    count=3013
     iterations.....................: 3013    49.484134/s
     vus............................: 5       min=3       max=99 

running (1m00.9s), 000/100 VUs, 3013 complete and 0 interrupted iterations
default ✓ [=====================================] 000/100 VUs  1m0.06s
```
```
cat summary-scenarios-htmlreport.json | jq -r
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
        "passes": 3013,
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
    "testRunDurationMs": 60888.202753,
    "isStdOutTTY": true,
    "isStdErrTTY": true
  },
  "metrics": {
    "checks": {
      "values": {
        "passes": 3013,
        "fails": 0,
        "rate": 1
      },
      "type": "rate",
      "contains": "default"
    },
    "http_req_blocked": {
      "type": "trend",
      "contains": "time",
      "values": {
        "max": 1.338879,
        "p(95)": 0.0008146000000000004,
        "p(99)": 1.06960188,
        "p(99.99)": 1.330923103199991,
        "count": 3013,
        "avg": 0.03548147328244279,
        "min": 0.000185,
        "med": 0.000411
      }
    },
    "http_req_tls_handshaking": {
      "values": {
        "min": 0,
        "med": 0,
        "max": 1.174043,
        "p(95)": 0,
        "p(99)": 0.8589604800000004,
        "p(99.99)": 1.1541571735999778,
        "count": 3013,
        "avg": 0.028206038499834055
      },
      "type": "trend",
      "contains": "time"
    },
    "http_req_duration": {
      "type": "trend",
      "contains": "time",
      "values": {
        "count": 3013,
        "avg": 16.266865124460647,
        "min": 11.642257,
        "med": 15.881484,
        "max": 31.284497,
        "p(95)": 21.891573,
        "p(99)": 23.12722264,
        "p(99.99)": 30.721107520399375
      }
    },
    "vus_max": {
      "type": "gauge",
      "contains": "default",
      "values": {
        "value": 100,
        "min": 100,
        "max": 100
      }
    },
    "iterations": {
      "type": "counter",
      "contains": "default",
      "values": {
        "count": 3013,
        "rate": 49.484134261978156
      }
    },
    "data_received": {
      "values": {
        "count": 8530810,
        "rate": 140106.1226031948
      },
      "type": "counter",
      "contains": "data"
    },
    "http_req_connecting": {
      "type": "trend",
      "contains": "time",
      "values": {
        "p(99)": 0.10826392000000006,
        "p(99.99)": 0.15964601839998696,
        "count": 3013,
        "avg": 0.003346085628941254,
        "min": 0,
        "med": 0,
        "max": 0.171338,
        "p(95)": 0
      }
    },
    "http_req_failed": {
      "type": "rate",
      "contains": "default",
      "values": {
        "rate": 0,
        "passes": 0,
        "fails": 3013
      }
    },
    "http_req_sending": {
      "type": "trend",
      "contains": "time",
      "values": {
        "p(99)": 0.1255086,
        "p(99.99)": 0.19268499719999768,
        "count": 3013,
        "avg": 0.0668148971125123,
        "min": 0.030291,
        "med": 0.064347,
        "max": 0.194769,
        "p(95)": 0.095199
      }
    },
    "http_reqs": {
      "type": "counter",
      "contains": "default",
      "values": {
        "rate": 49.484134261978156,
        "count": 3013
      }
    },
    "vus": {
      "values": {
        "value": 5,
        "min": 3,
        "max": 99
      },
      "type": "gauge",
      "contains": "default"
    },
    "data_sent": {
      "contains": "data",
      "values": {
        "count": 653888,
        "rate": 10739.157512212536
      },
      "type": "counter"
    },
    "http_req_duration{expected_response:true}": {
      "type": "trend",
      "contains": "time",
      "values": {
        "p(99.99)": 30.721107520399375,
        "count": 3013,
        "avg": 16.266865124460647,
        "min": 11.642257,
        "med": 15.881484,
        "max": 31.284497,
        "p(95)": 21.891573,
        "p(99)": 23.12722264
      }
    },
    "iteration_duration": {
      "type": "trend",
      "contains": "time",
      "values": {
        "med": 1016.668394,
        "max": 1032.518271,
        "p(95)": 1022.6124764,
        "p(99)": 1023.97833668,
        "p(99.99)": 1031.8575526559991,
        "count": 3013,
        "avg": 1017.0256878898114,
        "min": 1011.946516
      }
    },
    "http_req_waiting": {
      "type": "trend",
      "contains": "time",
      "values": {
        "med": 15.761279,
        "max": 31.168283,
        "p(95)": 21.781256799999998,
        "p(99)": 23.002959439999998,
        "p(99.99)": 30.60238874119937,
        "count": 3013,
        "avg": 16.147982767673405,
        "min": 11.532726
      }
    },
    "http_req_receiving": {
      "contains": "time",
      "values": {
        "p(99)": 0.09639928000000009,
        "p(99.99)": 0.28905331239992205,
        "count": 3013,
        "avg": 0.052067459674742855,
        "min": 0.018192,
        "med": 0.049163,
        "max": 0.359029,
        "p(95)": 0.08283360000000001
      },
      "type": "trend"
    }
  }
}
```

k6 HTML report

![k6 HTML report](/screenshots/htmlreports/k6-htmlreport-feb-29-2024-01.png)

![k6 HTML report](/screenshots/htmlreports/k6-htmlreport-feb-29-2024-02.png)
