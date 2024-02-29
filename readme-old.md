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

![benchmark-rps.js](/screenshots/rps/plot.png)

## User Concurrency Benchmarks

User concurrency 4 stage benchmarks with [`psrecord`](https://github.com/astrofrog/psrecord/)

```
TIME=30
DOMAIN=https://yourdomain.com/
psrecord "taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw2.gz benchmark2.js" --include-children --interval 0.1 --duration 30 --log psrecord-user.log --plot plot-user.png
```

```
TIME=30
DOMAIN=https://yourdomain.com/
psrecord "taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw2.gz benchmark2.js" --include-children --interval 0.1 --duration 30 --log psrecord-user.log --plot plot-user.png


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