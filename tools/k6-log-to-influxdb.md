Take k6 run with `--out json=summary-raw-scenarios-multi.gz` JSON logged output and [convert](#convert) or [convert + auto insert data](#convert-auto) into [InfluxDB 1.8 batch line write format](https://docs.influxdata.com/influxdb/v1.8/guides/write_data/#writing-points-from-a-file) for post-k6 run insertion into InfluxDB 1.8 database.

```
./k6-log-to-influxdb.sh 

Usage:

./k6-log-to-influxdb.sh convert /path/to/summary-raw-scenarios-multi.gz
./k6-log-to-influxdb.sh convert-auto /path/to/summary-raw-scenarios-multi.gz
```

Converted VUs log `/home/k6-workdir/influxdb-vus.log` sample:

```
tail -10 /home/k6-workdir/influxdb-vus.log
vus,testname=rampingvus value=31 1665458934009036300
vus,testname=rampingvus value=27 1665458935008730000
vus,testname=rampingvus value=24 1665458936008718000
vus,testname=rampingvus value=21 1665458937008712400
vus,testname=rampingvus value=17 1665458938000087300
vus,testname=rampingvus value=14 1665458939000871700
vus,testname=rampingvus value=11 1665458940008717600
vus,testname=rampingvus value=7 1665458941008723500
vus,testname=rampingvus value=4 1665458942008712400
vus,testname=rampingvus value=1 1665458943008714500
```

Split metrics converted log `/home/k6-workdir/influxdb-metrics.log-split-aa` sample:

```
tail -9 /home/k6-workdir/influxdb-metrics.log-split-aa
http_req_sending,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=0,status=200,testname=rampingvus value=0.029364 1665458825004866800
http_req_waiting,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=0,status=200,testname=rampingvus value=0.14466 1665458825004866800
http_req_receiving,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=0,status=200,testname=rampingvus value=0.018344 1665458825004866800
http_req_failed,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=0,status=200,testname=rampingvus value=0 1665458825004866800
http_reqs,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=0,status=200,testname=rampingvus value=1 1665458825004873000
http_req_duration,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=0,status=200,testname=rampingvus value=0.191381 1665458825004873000
http_req_blocked,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=0,status=200,testname=rampingvus value=0.000222 1665458825004873000
http_req_connecting,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=0,status=200,testname=rampingvus value=0 1665458825004873000
http_req_tls_handshaking,expected_response=true,name=https://domain1.com,scenario=ramping_vus,stage=0,status=200,testname=rampingvus value=0 1665458825004873000
```

Full conversion script output:

## convert

Using `convert` only convert but do not auto upload/insert data into InfluxDB database

```
./k6-log-to-influxdb.sh convert /home/k6-workdir/summary-raw-scenarios-multi.gz

     filter VUs metrics to /home/k6-workdir/filtered-vus.log
     filter all metrics to /home/k6-workdir/filtered-metrics.log
     convert VUs log to InfluxDB format at /home/k6-workdir/influxdb-vus.log
     convert all metrics logs to InfluxDB format at /home/k6-workdir/influxdb-metrics.log

     Saved InfluxDB formatted data files (34 lines) at:
     /home/k6-workdir/influxdb-vus.log (34)

     InfluxDB import queries

     curl -i -sX POST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE k6"
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-vus.log

     Saved InfluxDB formatted data files (3033 lines) at:
     /home/k6-workdir/influxdb-metrics.log (3033)

     InfluxDB import queries

     curl -i -sX POST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE k6"
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log
```

## convert-auto

Using `convert-auto` to convert and auto upload/insert data into InfluxDB database

```
./k6-log-to-influxdb.sh convert-auto /home/k6-workdir/summary-raw-scenarios-multi.gz

     filter VUs metrics to /home/k6-workdir/filtered-vus.log
     filter all metrics to /home/k6-workdir/filtered-metrics.log
     convert VUs log to InfluxDB format at /home/k6-workdir/influxdb-vus.log
     convert all metrics logs to InfluxDB format at /home/k6-workdir/influxdb-metrics.log

     Saved InfluxDB formatted data files (34 lines) at:
     /home/k6-workdir/influxdb-vus.log (34)

     InfluxDB import queries

     curl -i -sX POST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE k6"
     HTTP 1.1 200 d:33 u:20 97efdc4c-4baa-11ed-beea-0242ac120005 
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-vus.log
     HTTP 1.1 204 d:0 u:1776 97f08986-4baa-11ed-beeb-0242ac120005 

     Saved InfluxDB formatted data files (3033 lines) at:
     /home/k6-workdir/influxdb-metrics.log (3033)

     InfluxDB import queries

     curl -i -sX POST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE k6"
     HTTP 1.1 200 d:33 u:20 97f305c3-4baa-11ed-beec-0242ac120005 
     curl -i -sX POST 'http://localhost:8186/write?db=k6' --data-binary @/home/k6-workdir/influxdb-metrics.log
     HTTP 1.1 204 d:0 u:570869 97f3c5c6-4baa-11ed-beed-0242ac120005
```

Where the line after curl is the curl HTTP response

```
HTTP 1.1 204 d:0 u:570869 97f3c5c6-4baa-11ed-beed-0242ac120005
```

Referring to HTTP/1.1 protocol and version with HTTP 204 response code and download = 0 bytes, upload = 570,869 bytes and the string is the `x-influxdb-request-id`. If an error occurs, the error message would be listed after this `x-influxdb-request-id` output which refers to the `x-influxdb-error` response header.