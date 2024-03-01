```
k6 version
k6 v0.49.0 (commit/b5328aa782, go1.21.6, linux/amd64)
```

# Multi Scenario - Ramping VUs + Constant Request Rate

```
VU=75; REQRATE=50; TIME=60; STAGEVU1=25; STAGEVU2=75; STAGEVU3=150; STAGEVU4=0; DOMAIN=https://wpel9.domain.com/

K6_WEB_DASHBOARD=true K6_WEB_DASHBOARD_EXPORT=html-report.html taskset -c 0-3 k6 run -e RPS=${REQRATE} -e USERS=${VU} -e REQRATE_USERS=${VU} -e RPS=$REQRATE -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e SITE_URL=$DOMAIN wp-user-login-multi.js

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

     execution: local
        script: wp-user-login-multi.js
 web dashboard: http://127.0.0.1:5665
        output: -

     scenarios: (100.00%) 2 scenarios, 1000 max VUs, 5m25s max duration (incl. graceful stop):
              * constant_arrival_rate: 50.00 iterations/s for 1m0s (maxVUs: 75-1000, exec: constantarrival, gracefulStop: 5s)
              * ramping_vus: Up to 150 looping VUs for 4m0s over 4 stages (gracefulRampDown: 5s, exec: default, startTime: 1m20s, gracefulStop: 5s)

INFO[0321] [k6-reporter v2.3.0] Generating HTML summary report  source=console
     ✓ constant: is status 200
     ✓ ramping: is status 200

     checks.........................: 100.00% ✓ 14966     ✗ 0    
     data_received..................: 44 MB   136 kB/s
     data_sent......................: 3.2 MB  9.9 kB/s
     http_req_blocked...............: avg=94.1µs   min=149ns   med=545ns    max=48.45ms p(95)=974ns    p(99)=1.44ms   p(99.99)=36.61ms count=14966
     http_req_connecting............: avg=29.99µs  min=0s      med=0s       max=28.4ms  p(95)=0s       p(99)=124.29µs p(99.99)=24.51ms count=14966
     http_req_duration..............: avg=373.07ms min=47.5ms  med=164.47ms max=1.98s   p(95)=1.19s    p(99)=1.45s    p(99.99)=1.87s   count=14966
       { expected_response:true }...: avg=373.07ms min=47.5ms  med=164.47ms max=1.98s   p(95)=1.19s    p(99)=1.45s    p(99.99)=1.87s   count=14966
     http_req_failed................: 0.00%   ✓ 0         ✗ 14966
     http_req_receiving.............: avg=66.14µs  min=15.08µs med=56.07µs  max=26.79ms p(95)=94.61µs  p(99)=154.76µs p(99.99)=11.01ms count=14966
     http_req_sending...............: avg=141.38µs min=32.99µs med=79.87µs  max=32.78ms p(95)=147.58µs p(99)=1.27ms   p(99.99)=31.37ms count=14966
     http_req_tls_handshaking.......: avg=58.59µs  min=0s      med=0s       max=37.33ms p(95)=0s       p(99)=1.2ms    p(99.99)=29.33ms count=14966
     http_req_waiting...............: avg=372.86ms min=47.38ms med=164.26ms max=1.98s   p(95)=1.19s    p(99)=1.45s    p(99.99)=1.87s   count=14966
     http_reqs......................: 14966   46.742544/s
     iteration_duration.............: avg=1.37s    min=1.04s   med=1.16s    max=2.98s   p(95)=2.19s    p(99)=2.46s    p(99.99)=2.87s   count=14966
     iterations.....................: 14966   46.742544/s
     vus............................: 3       min=0       max=150

running (5m20.2s), 0000/0150 VUs, 14966 complete and 0 interrupted iterations
constant_arrival_rate ✓ [=========] 0000/0075 VUs  1m0s  50.00 iters/s
ramping_vus           ✓ [=========] 000/150 VUs    4m0s 
```

k6 HTML report

![k6 HTML report](/screenshots/htmlreports/k6-web-dashboard-mar1-multi-2024-01.png)

![k6 HTML report](/screenshots/htmlreports/k6-web-dashboard-mar1-multi-2024-02.png)

![k6 HTML report](/screenshots/htmlreports/k6-web-dashboard-mar1-multi-2024-03.png)

![k6 HTML report](/screenshots/htmlreports/k6-web-dashboard-mar1-multi-2024-04.png)

![k6 HTML report](/screenshots/htmlreports/k6-web-dashboard-mar1-multi-2024-05.png)

# Single Ramping Scenario

```
K6_WEB_DASHBOARD=true K6_WEB_DASHBOARD_EXPORT=html-report.html taskset -c 0-3 k6 run -e SITE_URL=https://wpel9.domain.com wp-user-login.js --insecure-skip-tls-verify

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

     execution: local
        script: wp-user-login.js
 web dashboard: http://127.0.0.1:5665
        output: -

     scenarios: (100.00%) 1 scenario, 100 max VUs, 1m30.1s max duration (incl. graceful stop):
              * default: Up to 100 looping VUs for 1m0.06s over 3 stages (gracefulRampDown: 30s, gracefulStop: 30s)

INFO[0437] [k6-reporter v2.3.0] Generating HTML summary report  source=console
     ✓ is status 200

     checks.........................: 100.00% ✓ 3000      ✗ 0    
     data_received..................: 8.5 MB  140 kB/s
     data_sent......................: 651 kB  11 kB/s
     http_req_blocked...............: avg=37.97µs min=194ns   med=438ns   max=8ms      p(95)=803ns   p(99)=1.07ms   p(99.99)=5.97ms   count=3000
     http_req_connecting............: avg=3.48µs  min=0s      med=0s      max=160.49µs p(95)=0s      p(99)=114.28µs p(99.99)=159.77µs count=3000
     http_req_duration..............: avg=20.89ms min=15.9ms  med=18.66ms max=61.06ms  p(95)=30.14ms p(99)=38.49ms  p(99.99)=56.22ms  count=3000
       { expected_response:true }...: avg=20.89ms min=15.9ms  med=18.66ms max=61.06ms  p(95)=30.14ms p(99)=38.49ms  p(99.99)=56.22ms  count=3000
     http_req_failed................: 0.00%   ✓ 0         ✗ 3000 
     http_req_receiving.............: avg=52.79µs min=19.04µs med=50.48µs max=141.75µs p(95)=83.21µs p(99)=95.74µs  p(99.99)=138.21µs count=3000
     http_req_sending...............: avg=68µs    min=31.31µs med=65.83µs max=179.24µs p(95)=96.59µs p(99)=121.43µs p(99.99)=175.67µs count=3000
     http_req_tls_handshaking.......: avg=30.52µs min=0s      med=0s      max=7.75ms   p(95)=0s      p(99)=864.34µs p(99.99)=5.74ms   count=3000
     http_req_waiting...............: avg=20.77ms min=15.82ms med=18.54ms max=60.89ms  p(95)=30.04ms p(99)=38.38ms  p(99.99)=56.08ms  count=3000
     http_reqs......................: 3000    49.367474/s
     iteration_duration.............: avg=1.02s   min=1.01s   med=1.01s   max=1.06s    p(95)=1.03s   p(99)=1.03s    p(99.99)=1.05s    count=3000
     iterations.....................: 3000    49.367474/s
     vus............................: 5       min=3       max=99 

running (1m00.8s), 000/100 VUs, 3000 complete and 0 interrupted iterations
default ✓ [=====================================] 000/100 VUs  1m0.06s
```
```
cat summary-scenarios-htmlreport.json | jq -r
{
  "metrics": {
    "http_req_sending": {
      "type": "trend",
      "contains": "time",
      "values": {
        "p(99.99)": 0.17567738959999482,
        "count": 3000,
        "avg": 0.06800620933333348,
        "min": 0.031314,
        "med": 0.06583349999999999,
        "max": 0.179245,
        "p(95)": 0.09659935,
        "p(99)": 0.12143145999999988
      }
    },
    "iterations": {
      "values": {
        "count": 3000,
        "rate": 49.36747411032646
      },
      "type": "counter",
      "contains": "default"
    },
    "http_req_receiving": {
      "type": "trend",
      "contains": "time",
      "values": {
        "max": 0.141756,
        "p(95)": 0.08321964999999999,
        "p(99)": 0.09574656999999978,
        "p(99.99)": 0.13821088209999485,
        "count": 3000,
        "avg": 0.052796091999999996,
        "min": 0.019042,
        "med": 0.050486500000000004
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
    "http_req_tls_handshaking": {
      "type": "trend",
      "contains": "time",
      "values": {
        "max": 7.75205,
        "p(95)": 0,
        "p(99)": 0.864344889999999,
        "p(99.99)": 5.747000472697096,
        "count": 3000,
        "avg": 0.030525937333333322,
        "min": 0,
        "med": 0
      }
    },
    "iteration_duration": {
      "type": "trend",
      "contains": "time",
      "values": {
        "p(95)": 1030.79170165,
        "p(99)": 1038.9926613799998,
        "p(99.99)": 1057.8932737798923,
        "count": 3000,
        "avg": 1021.6636857873327,
        "min": 1016.416214,
        "med": 1019.461149,
        "max": 1063.142963
      }
    },
    "http_req_duration": {
      "type": "trend",
      "contains": "time",
      "values": {
        "p(99.99)": 56.229921524893,
        "count": 3000,
        "avg": 20.89359797733332,
        "min": 15.909193,
        "med": 18.6694155,
        "max": 61.064984,
        "p(95)": 30.144509299999964,
        "p(99)": 38.498657349999995
      }
    },
    "http_req_connecting": {
      "type": "trend",
      "contains": "time",
      "values": {
        "max": 0.160496,
        "p(95)": 0,
        "p(99)": 0.11428035999999997,
        "p(99.99)": 0.15977923899999896,
        "count": 3000,
        "avg": 0.003485906333333333,
        "min": 0,
        "med": 0
      }
    },
    "data_sent": {
      "values": {
        "count": 651438,
        "rate": 10719.94953316095
      },
      "type": "counter",
      "contains": "data"
    },
    "http_req_duration{expected_response:true}": {
      "type": "trend",
      "contains": "time",
      "values": {
        "max": 61.064984,
        "p(95)": 30.144509299999964,
        "p(99)": 38.498657349999995,
        "p(99.99)": 56.229921524893,
        "count": 3000,
        "avg": 20.89359797733332,
        "min": 15.909193,
        "med": 18.6694155
      }
    },
    "vus": {
      "type": "gauge",
      "contains": "default",
      "values": {
        "value": 5,
        "min": 3,
        "max": 99
      }
    },
    "http_reqs": {
      "type": "counter",
      "contains": "default",
      "values": {
        "count": 3000,
        "rate": 49.36747411032646
      }
    },
    "http_req_waiting": {
      "type": "trend",
      "contains": "time",
      "values": {
        "p(99.99)": 56.08523808839303,
        "count": 3000,
        "avg": 20.772795675999973,
        "min": 15.823064,
        "med": 18.545895,
        "max": 60.899498,
        "p(95)": 30.04530134999996,
        "p(99)": 38.383452649999995
      }
    },
    "http_req_failed": {
      "values": {
        "fails": 3000,
        "rate": 0,
        "passes": 0
      },
      "type": "rate",
      "contains": "default"
    },
    "http_req_blocked": {
      "contains": "time",
      "values": {
        "min": 0.000194,
        "med": 0.000438,
        "max": 8.001924,
        "p(95)": 0.000803,
        "p(99)": 1.0740874099999993,
        "p(99.99)": 5.977869209897069,
        "count": 3000,
        "avg": 0.03797133366666658
      },
      "type": "trend"
    },
    "checks": {
      "type": "rate",
      "contains": "default",
      "values": {
        "rate": 1,
        "passes": 3000,
        "fails": 0
      }
    },
    "data_received": {
      "type": "counter",
      "contains": "data",
      "values": {
        "count": 8494998,
        "rate": 139792.1979440917
      }
    }
  },
  "root_group": {
    "groups": [],
    "checks": [
      {
        "name": "is status 200",
        "path": "::is status 200",
        "id": "548d37ca5f33793206f7832e7cea54fb",
        "passes": 3000,
        "fails": 0
      }
    ],
    "name": "",
    "path": "",
    "id": "d41d8cd98f00b204e9800998ecf8427e"
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
    "testRunDurationMs": 60768.756232
  }
}
```

k6 HTML report

![k6 HTML report](/screenshots/htmlreports/k6-web-dashboard-mar1-2024-01.png)

![k6 HTML report](/screenshots/htmlreports/k6-web-dashboard-mar1-2024-02.png)

![k6 HTML report](/screenshots/htmlreports/k6-web-dashboard-mar1-2024-03.png)

![k6 HTML report](/screenshots/htmlreports/k6-web-dashboard-mar1-2024-04.png)

![k6 HTML report](/screenshots/htmlreports/k6-web-dashboard-mar1-2024-05.png)

![k6 HTML report](/screenshots/htmlreports/k6-web-dashboard-mar1-2024-06.png)

![k6 HTML report](/screenshots/htmlreports/k6-web-dashboard-mar1-2024-07.png)

![k6 HTML report](/screenshots/htmlreports/k6-web-dashboard-mar1-2024-08.png)
