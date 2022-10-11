# Log Parsing Tools

* [json2jqpath](https://github.com/TomConlin/json_to_paths)
* https://jsoncrack.com/

```
wget -O /usr/local/bin/json2jqpath https://github.com/TomConlin/json_to_paths/raw/master/json2jqpath.jq
chmod +x /usr/local/bin/json2jqpath
```

From k6 run with `--out json=summary-raw-scenarios-multi.gz`

```
json2jqpath sample-output-http-duration-log.log
.
.data
.data|.tags
.data|.tags|.expected_response
.data|.tags|.name
.data|.tags|.scenario
.data|.tags|.stage
.data|.tags|.status
.data|.tags|.testname
.data|.time
.data|.value
.metric
.type
```

# Parsing Info InfluxDB InfluxQL Batch Write Format

The [InfluxDB batch write fromatted](https://docs.influxdata.com/influxdb/v1.8/guides/write_data/#writing-points-from-a-file) files will be inserted into `k6` named InfluxDB database running on port 8186.

```
curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @metric_name.txt
```

For the following metrics https://k6.io/docs/using-k6/metrics/:

* [vus](#vus)
* [http_reqs](#http_reqs)
* [http_req_duration](#http_req_duration)
* [http_req_sending](#http_req_sending)
* [http_req_tls_handshaking](#http_req_tls_handshaking)
* [http_req_connecting](#http_req_connecting)
* [http_req_waiting](#http_req_waiting)
* [http_req_receiving](#http_req_receiving)
* [http_req_failed](#http_req_failed)
* [All Metrics](#all-metrics)

# VUs

`vus`

```
pzcat summary-raw-scenarios-multi.gz | jq -c '. | select(.type=="Point" and .metric == "vus")' | tail -3 | tee sample-output-vus-log.log

cat sample-output-vus-log.log | jq -r
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:01.872348667Z",
    "value": 7,
    "tags": {
      "testname": "rampingvus"
    }
  },
  "metric": "vus"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:02.871247902Z",
    "value": 4,
    "tags": {
      "testname": "rampingvus"
    }
  },
  "metric": "vus"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.871448124Z",
    "value": 1,
    "tags": {
      "testname": "rampingvus"
    }
  },
  "metric": "vus"
}    
```
```
cat sample-output-vus-log.log | jq -r '"\(.metric),testname=\(.data.tags.testname) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

vus,testname=rampingvus value=7 1665467664486
vus,testname=rampingvus value=4 1665467654479
vus,testname=rampingvus value=1 1665467657481
```

or

```
cat sample-output-vus-log.log | jq -r '"\(.metric),\(.data.tags|to_entries|map("\(.key)=\(.value|tostring)")|.[]) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

vus,testname=rampingvus value=7 1665467664486
vus,testname=rampingvus value=4 1665467654479
vus,testname=rampingvus value=1 1665467657481
```

or ideally

```
cat sample-output-vus-log.log | jq -r '"\(.metric),\(.data.tags|to_entries|map("\(.key)=\(.value|tostring)")|[.[]]|sort|join(",")) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

vus,testname=rampingvus value=7 1665467664486
vus,testname=rampingvus value=4 1665467654479
vus,testname=rampingvus value=1 1665467657481
```

# http_reqs

`http_reqs`

```
pzcat summary-raw-scenarios-multi.gz | jq -c '. | select(.type=="Point" and .data.tags.expected_response == "true" and .metric == "http_reqs" and .data.tags.status >= "200")' | tail -3 | tee sample-output-http-reqs-log.log

cat sample-output-http-reqs-log.log | jq -r                                                                                     {
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.910394455Z",
    "value": 1,
    "tags": {
      "stage": "3",
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_reqs"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.91100717Z",
    "value": 1,
    "tags": {
      "expected_response": "true",
      "scenario": "ramping_vus",
      "stage": "3",
      "testname": "rampingvus",
      "name": "https://domain1.com",
      "status": "200"
    }
  },
  "metric": "http_reqs"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.911611709Z",
    "value": 1,
    "tags": {
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "stage": "3",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_reqs"
}
```
```
cat sample-output-http-reqs-log.log | jq -r '"\(.metric),testname=\(.data.tags.testname),expected_response=\(.data.tags.expected_response),name=\(.data.tags.name),stage=\(.data.tags.stage),scenario=\(.data.tags.scenario),status=\(.data.tags.status) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

http_reqs,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=1 1665468046944
http_reqs,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=1 1665468053071
http_reqs,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=1 1665468059117
```

or

```
cat sample-output-http-reqs-log.log | jq -r '"\(.metric),\(.data.tags|to_entries|map("\(.key)=\(.value|tostring)")|[.[]]|sort|join(",")) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

http_reqs,stage=3,testname=rampingvus,scenario=ramping_vus,name=https://domain1.com,status=200,expected_response=true value=1 1665468046944
http_reqs,expected_response=true,scenario=ramping_vus,stage=3,testname=rampingvus,name=https://domain1.com,status=200 value=1 1665468053071
http_reqs,testname=rampingvus,scenario=ramping_vus,stage=3,name=https://domain1.com,status=200,expected_response=true value=1 1665468059117
```

# `http_req_duration`

```
pzcat summary-raw-scenarios-multi.gz | jq -c '. | select(.type=="Point" and .data.tags.expected_response == "true" and .metric == "http_req_duration" and .data.tags.status >= "200")' | tail -3 | tee sample-output-http-duration-log.log

cat sample-output-http-duration-log.log | jq -r
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.910394455Z",
    "value": 0.19456,
    "tags": {
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true",
      "stage": "3"
    }
  },
  "metric": "http_req_duration"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.91100717Z",
    "value": 0.19281,
    "tags": {
      "stage": "3",
      "testname": "rampingvus",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true",
      "scenario": "ramping_vus"
    }
  },
  "metric": "http_req_duration"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.911611709Z",
    "value": 0.184015,
    "tags": {
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "stage": "3",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_req_duration"
}
```

```
cat sample-output-http-duration-log.log | jq -r '"\(.metric),testname=\(.data.tags.testname),expected_response=\(.data.tags.expected_response),name=\(.data.tags.name),stage=\(.data.tags.stage),scenario=\(.data.tags.scenario),status=\(.data.tags.status) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

http_req_duration,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0.19456 1665468046944
http_req_duration,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0.19281 1665468053071
http_req_duration,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0.184015 16654680591171665412286959
```

or ideally

```
cat sample-output-http-duration-log.log | jq -r '"\(.metric),\(.data.tags|to_entries|map("\(.key)=\(.value|tostring)")|[.[]]|sort|join(",")) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

http_req_duration,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.19456 1665468046944
http_req_duration,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.19281 1665468053071
http_req_duration,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.184015 1665468059117
```

# `http_req_sending`

```
pzcat summary-raw-scenarios-multi.gz | jq -c '. | select(.type=="Point" and .data.tags.expected_response == "true" and .metric == "http_req_sending" and .data.tags.status >= "200")' | tail -3 | tee sample-output-http-req-sending-log.log

cat sample-output-http-req-sending-log.log | jq -r
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.910394455Z",
    "value": 0.029499,
    "tags": {
      "scenario": "ramping_vus",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true",
      "stage": "3",
      "testname": "rampingvus"
    }
  },
  "metric": "http_req_sending"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.91100717Z",
    "value": 0.029202,
    "tags": {
      "testname": "rampingvus",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true",
      "scenario": "ramping_vus",
      "stage": "3"
    }
  },
  "metric": "http_req_sending"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.911611709Z",
    "value": 0.029498,
    "tags": {
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true",
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "stage": "3"
    }
  },
  "metric": "http_req_sending"
}
```

```
cat sample-output-http-req-sending-log.log | jq -r '"\(.metric),testname=\(.data.tags.testname),expected_response=\(.data.tags.expected_response),name=\(.data.tags.name),stage=\(.data.tags.stage),scenario=\(.data.tags.scenario),status=\(.data.tags.status) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

http_req_sending,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0.029499 1665468046944
http_req_sending,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0.029202 1665468053071
http_req_sending,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0.029498 1665468059117
```
or ideally

```
cat sample-output-http-req-sending-log.log | jq -r '"\(.metric),\(.data.tags|to_entries|map("\(.key)=\(.value|tostring)")|[.[]]|sort|join(",")) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

http_req_sending,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.029499 1665468046944
http_req_sending,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.029202 1665468053071
http_req_sending,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.029498 1665468059117
```

# `http_req_tls_handshaking`

```
pzcat summary-raw-scenarios-multi.gz | jq -c '. | select(.type=="Point" and .data.tags.expected_response == "true" and .metric == "http_req_tls_handshaking" and .data.tags.status >= "200")' | tail -3 | tee sample-output-http-req-tls-log.log

cat sample-output-http-req-tls-log.log | jq -r
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.910394455Z",
    "value": 0,
    "tags": {
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true",
      "stage": "3",
      "testname": "rampingvus",
      "scenario": "ramping_vus"
    }
  },
  "metric": "http_req_tls_handshaking"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.91100717Z",
    "value": 0,
    "tags": {
      "scenario": "ramping_vus",
      "stage": "3",
      "testname": "rampingvus",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_req_tls_handshaking"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.911611709Z",
    "value": 0,
    "tags": {
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "stage": "3",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_req_tls_handshaking"
}
```

```
cat sample-output-http-req-tls-log.log | jq -r '"\(.metric),testname=\(.data.tags.testname),expected_response=\(.data.tags.expected_response),name=\(.data.tags.name),stage=\(.data.tags.stage),scenario=\(.data.tags.scenario),status=\(.data.tags.status) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

http_req_tls_handshaking,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0 1665468046944
http_req_tls_handshaking,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0 1665468053071
http_req_tls_handshaking,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0 1665468059117
```
or ideally

```
cat sample-output-http-req-tls-log.log | jq -r '"\(.metric),\(.data.tags|to_entries|map("\(.key)=\(.value|tostring)")|[.[]]|sort|join(",")) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

http_req_tls_handshaking,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0 1665468046944
http_req_tls_handshaking,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0 1665468053071
http_req_tls_handshaking,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0 1665468059117
```

# `http_req_connecting`

```
pzcat summary-raw-scenarios-multi.gz | jq -c '. | select(.type=="Point" and .data.tags.expected_response == "true" and .metric == "http_req_connecting" and .data.tags.status >= "200")' | tail -3 | tee sample-output-http-req-connecting-log.log

cat sample-output-http-req-connecting-log.log | jq -r
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.910394455Z",
    "value": 0,
    "tags": {
      "stage": "3",
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_req_connecting"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.91100717Z",
    "value": 0,
    "tags": {
      "stage": "3",
      "testname": "rampingvus",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true",
      "scenario": "ramping_vus"
    }
  },
  "metric": "http_req_connecting"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.911611709Z",
    "value": 0,
    "tags": {
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "stage": "3",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_req_connecting"
}
```

```
cat sample-output-http-req-connecting-log.log | jq -r '"\(.metric),testname=\(.data.tags.testname),expected_response=\(.data.tags.expected_response),name=\(.data.tags.name),stage=\(.data.tags.stage),scenario=\(.data.tags.scenario),status=\(.data.tags.status) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

http_req_connecting,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0 1665468046944
http_req_connecting,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0 1665468053071
http_req_connecting,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0 1665468059117
```
or ideally

```
cat sample-output-http-req-connecting-log.log | jq -r '"\(.metric),\(.data.tags|to_entries|map("\(.key)=\(.value|tostring)")|[.[]]|sort|join(",")) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

http_req_connecting,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0 1665468046944
http_req_connecting,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0 1665468053071
http_req_connecting,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0 1665468059117
```

# `http_req_waiting`

```
pzcat summary-raw-scenarios-multi.gz | jq -c '. | select(.type=="Point" and .data.tags.expected_response == "true" and .metric == "http_req_waiting" and .data.tags.status >= "200")' | tail -3 | tee sample-output-http-req-waiting-log.log

cat sample-output-http-req-waiting-log.log | jq -r
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.910394455Z",
    "value": 0.146218,
    "tags": {
      "stage": "3",
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_req_waiting"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.91100717Z",
    "value": 0.145535,
    "tags": {
      "scenario": "ramping_vus",
      "stage": "3",
      "testname": "rampingvus",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_req_waiting"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.911611709Z",
    "value": 0.139135,
    "tags": {
      "scenario": "ramping_vus",
      "stage": "3",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true",
      "testname": "rampingvus"
    }
  },
  "metric": "http_req_waiting"
}
```


```
cat sample-output-http-req-waiting-log.log | jq -r '"\(.metric),testname=\(.data.tags.testname),expected_response=\(.data.tags.expected_response),name=\(.data.tags.name),stage=\(.data.tags.stage),scenario=\(.data.tags.scenario),status=\(.data.tags.status) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

http_req_waiting,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0.146218 1665468046944
http_req_waiting,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0.145535 1665468053071
http_req_waiting,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0.139135 1665468059117
```
or ideally

```
cat sample-output-http-req-waiting-log.log | jq -r '"\(.metric),\(.data.tags|to_entries|map("\(.key)=\(.value|tostring)")|[.[]]|sort|join(",")) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

http_req_waiting,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.146218 1665468046944
http_req_waiting,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.145535 1665468053071
http_req_waiting,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.139135 1665468059117
```

# `http_req_receiving`

```
pzcat summary-raw-scenarios-multi.gz | jq -c '. | select(.type=="Point" and .data.tags.expected_response == "true" and .metric == "http_req_receiving" and .data.tags.status >= "200")' | tail -3 | tee sample-output-http-req-receiving-log.log

cat sample-output-http-req-receiving-log.log | jq -r
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.910394455Z",
    "value": 0.018843,
    "tags": {
      "status": "200",
      "expected_response": "true",
      "stage": "3",
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "name": "https://domain1.com"
    }
  },
  "metric": "http_req_receiving"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.91100717Z",
    "value": 0.018073,
    "tags": {
      "scenario": "ramping_vus",
      "stage": "3",
      "testname": "rampingvus",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_req_receiving"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.911611709Z",
    "value": 0.015382,
    "tags": {
      "expected_response": "true",
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "stage": "3",
      "name": "https://domain1.com",
      "status": "200"
    }
  },
  "metric": "http_req_receiving"
}
```

```
cat sample-output-http-req-receiving-log.log | jq -r '"\(.metric),testname=\(.data.tags.testname),expected_response=\(.data.tags.expected_response),name=\(.data.tags.name),stage=\(.data.tags.stage),scenario=\(.data.tags.scenario),status=\(.data.tags.status) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

http_req_receiving,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0.018843 1665468046944
http_req_receiving,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0.018073 1665468053071
http_req_receiving,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0.015382 1665468059117
```
or ideally

```
cat sample-output-http-req-receiving-log.log | jq -r '"\(.metric),\(.data.tags|to_entries|map("\(.key)=\(.value|tostring)")|[.[]]|sort|join(",")) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

http_req_receiving,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.018843 1665468046944
http_req_receiving,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.018073 1665468053071
http_req_receiving,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.015382 1665468059117
```

# `http_req_failed`

```
pzcat summary-raw-scenarios-multi.gz | jq -c '. | select(.type=="Point" and .data.tags.expected_response == "true" and .metric == "http_req_failed" and .data.tags.status >= "200")' | tail -3 | tee sample-output-http-req-failed-log.log

cat sample-output-http-req-failed-log.log | jq -r
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.910394455Z",
    "value": 0,
    "tags": {
      "expected_response": "true",
      "stage": "3",
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "name": "https://domain1.com",
      "status": "200"
    }
  },
  "metric": "http_req_failed"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.91100717Z",
    "value": 0,
    "tags": {
      "testname": "rampingvus",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true",
      "scenario": "ramping_vus",
      "stage": "3"
    }
  },
  "metric": "http_req_failed"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.911611709Z",
    "value": 0,
    "tags": {
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "stage": "3",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_req_failed"
}
```

```
cat sample-output-http-req-failed-log.log | jq -r '"\(.metric),testname=\(.data.tags.testname),expected_response=\(.data.tags.expected_response),name=\(.data.tags.name),stage=\(.data.tags.stage),scenario=\(.data.tags.scenario),status=\(.data.tags.status) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

http_req_failed,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0 1665468046944
http_req_failed,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0 1665468053071
http_req_failed,testname=rampingvus,expected_response=true,name=https://domain1.com,stage=3,scenario=ramping_vus,status=200 value=0 1665468059117
```
or ideally

```
cat sample-output-http-req-failed-log.log | jq -r '"\(.metric),\(.data.tags|to_entries|map("\(.key)=\(.value|tostring)")|[.[]]|sort|join(",")) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'

http_req_failed,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0 1665468046944
http_req_failed,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0 1665468053071
http_req_failed,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0 1665468059117
```

# All Metrics

For all relevant metrics

* http_reqs
* http_req_duration
* http_req_sending
* http_req_tls_handshaking
* http_req_connecting
* http_req_waiting
* http_req_receiving
* http_req_failed

```
pzcat summary-raw-scenarios-multi.gz | jq -c '. | select(.type=="Point" and .data.tags.expected_response == "true" and .data.tags.status >= "200")' | tail -12 | tee all-metrics-log.log

{"type":"Point","data":{"time":"2022-10-11T03:29:03.91100717Z","value":0.145535,"tags":{"scenario":"ramping_vus","stage":"3","testname":"rampingvus","name":"https://domain1.com","status":"200","expected_response":"true"}},"metric":"http_req_waiting"}
{"type":"Point","data":{"time":"2022-10-11T03:29:03.91100717Z","value":0.018073,"tags":{"scenario":"ramping_vus","stage":"3","testname":"rampingvus","name":"https://domain1.com","status":"200","expected_response":"true"}},"metric":"http_req_receiving"}
{"type":"Point","data":{"time":"2022-10-11T03:29:03.91100717Z","value":0,"tags":{"testname":"rampingvus","name":"https://domain1.com","status":"200","expected_response":"true","scenario":"ramping_vus","stage":"3"}},"metric":"http_req_failed"}
{"type":"Point","data":{"time":"2022-10-11T03:29:03.911611709Z","value":1,"tags":{"testname":"rampingvus","scenario":"ramping_vus","stage":"3","name":"https://domain1.com","status":"200","expected_response":"true"}},"metric":"http_reqs"}
{"type":"Point","data":{"time":"2022-10-11T03:29:03.911611709Z","value":0.184015,"tags":{"testname":"rampingvus","scenario":"ramping_vus","stage":"3","name":"https://domain1.com","status":"200","expected_response":"true"}},"metric":"http_req_duration"}
{"type":"Point","data":{"time":"2022-10-11T03:29:03.911611709Z","value":0.000222,"tags":{"testname":"rampingvus","scenario":"ramping_vus","stage":"3","name":"https://domain1.com","status":"200","expected_response":"true"}},"metric":"http_req_blocked"}
{"type":"Point","data":{"time":"2022-10-11T03:29:03.911611709Z","value":0,"tags":{"testname":"rampingvus","scenario":"ramping_vus","stage":"3","name":"https://domain1.com","status":"200","expected_response":"true"}},"metric":"http_req_connecting"}
{"type":"Point","data":{"time":"2022-10-11T03:29:03.911611709Z","value":0,"tags":{"testname":"rampingvus","scenario":"ramping_vus","stage":"3","name":"https://domain1.com","status":"200","expected_response":"true"}},"metric":"http_req_tls_handshaking"}
{"type":"Point","data":{"time":"2022-10-11T03:29:03.911611709Z","value":0.029498,"tags":{"name":"https://domain1.com","status":"200","expected_response":"true","testname":"rampingvus","scenario":"ramping_vus","stage":"3"}},"metric":"http_req_sending"}
{"type":"Point","data":{"time":"2022-10-11T03:29:03.911611709Z","value":0.139135,"tags":{"scenario":"ramping_vus","stage":"3","name":"https://domain1.com","status":"200","expected_response":"true","testname":"rampingvus"}},"metric":"http_req_waiting"}
{"type":"Point","data":{"time":"2022-10-11T03:29:03.911611709Z","value":0.015382,"tags":{"expected_response":"true","testname":"rampingvus","scenario":"ramping_vus","stage":"3","name":"https://domain1.com","status":"200"}},"metric":"http_req_receiving"}
{"type":"Point","data":{"time":"2022-10-11T03:29:03.911611709Z","value":0,"tags":{"testname":"rampingvus","scenario":"ramping_vus","stage":"3","name":"https://domain1.com","status":"200","expected_response":"true"}},"metric":"http_req_failed"}

cat all-metrics-log.log | jq -r
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.91100717Z",
    "value": 0.145535,
    "tags": {
      "scenario": "ramping_vus",
      "stage": "3",
      "testname": "rampingvus",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_req_waiting"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.91100717Z",
    "value": 0.018073,
    "tags": {
      "scenario": "ramping_vus",
      "stage": "3",
      "testname": "rampingvus",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_req_receiving"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.91100717Z",
    "value": 0,
    "tags": {
      "testname": "rampingvus",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true",
      "scenario": "ramping_vus",
      "stage": "3"
    }
  },
  "metric": "http_req_failed"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.911611709Z",
    "value": 1,
    "tags": {
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "stage": "3",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_reqs"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.911611709Z",
    "value": 0.184015,
    "tags": {
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "stage": "3",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_req_duration"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.911611709Z",
    "value": 0.000222,
    "tags": {
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "stage": "3",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_req_blocked"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.911611709Z",
    "value": 0,
    "tags": {
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "stage": "3",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_req_connecting"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.911611709Z",
    "value": 0,
    "tags": {
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "stage": "3",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_req_tls_handshaking"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.911611709Z",
    "value": 0.029498,
    "tags": {
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true",
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "stage": "3"
    }
  },
  "metric": "http_req_sending"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.911611709Z",
    "value": 0.139135,
    "tags": {
      "scenario": "ramping_vus",
      "stage": "3",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true",
      "testname": "rampingvus"
    }
  },
  "metric": "http_req_waiting"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.911611709Z",
    "value": 0.015382,
    "tags": {
      "expected_response": "true",
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "stage": "3",
      "name": "https://domain1.com",
      "status": "200"
    }
  },
  "metric": "http_req_receiving"
}
{
  "type": "Point",
  "data": {
    "time": "2022-10-11T03:29:03.911611709Z",
    "value": 0,
    "tags": {
      "testname": "rampingvus",
      "scenario": "ramping_vus",
      "stage": "3",
      "name": "https://domain1.com",
      "status": "200",
      "expected_response": "true"
    }
  },
  "metric": "http_req_failed"
}
```

```
cat all-metrics-log.log | jq -r '"\(.metric),\(.data.tags|to_entries|map("\(.key)=\(.value|tostring)")|[.[]]|sort|join(",")) value=\(.data.value) \((.data.time[0:19] + "Z"|fromdateiso8601)*1000 + (.data.time[20:27]|tonumber))"'


http_req_waiting,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.145535 1665468053071
http_req_receiving,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.018073 1665468053071
http_req_failed,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0 1665468053071
http_reqs,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=1 1665468059117
http_req_duration,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.184015 1665468059117
http_req_blocked,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.000222 1665468059117
http_req_connecting,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0 1665468059117
http_req_tls_handshaking,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0 1665468059117
http_req_sending,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.029498 1665468059117
http_req_waiting,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.139135 1665468059117
http_req_receiving,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0.015382 1665468059117
http_req_failed,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=3,status=200,testname=rampingvus value=0 1665468059117
```

