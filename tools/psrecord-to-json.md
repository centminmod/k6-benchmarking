Original psrecord `psrecord-ramping-100vus-nginx.log` saved cpu and memory usage data

```
# Elapsed time   CPU (%)     Real (MB)   Virtual (MB)
       0.000        0.000     2426.141     5810.457
       0.112        0.000     2426.141     5810.457
       0.223        0.000     2426.141     5810.457
       0.335        0.000     2426.141     5810.457
       0.448        0.000     2426.141     5810.457
       0.560        0.000     2426.141     5810.457
       0.678        0.000     2426.141     5810.457
       0.790        0.000     2426.141     5810.457
       0.901        0.000     2426.141     5810.457
```

# Usage

```
./psrecord-to-json.sh 

Usage:

./psrecord-to-json.sh json psrecord_file.log
./psrecord-to-json.sh influx psrecord_file.log
```

Influx converted data files as per https://docs.influxdata.com/influxdb/v1.8/guides/write_data/#writing-points-from-a-file

Reports the number of data entry lines as well.

```
./psrecord-to-json.sh influx psrecord-ramping-100vus-nginx.log

Saved InfluxDB formatted data files at:
cpuload: cpuload.txt (1543)
realmem: realmem.txt (1543)
virtualmem: virtualmem.txt (1543)

InfluxDB import queries

curl -i -sX POST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE psrecord"
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @cpuload.txt
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @realmem.txt
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @virtualmem.txt
```

These files will be inserted into InfluxDB database `psrecord` via:

```
curl -i -sX POST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE psrecord"
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @cpuload.txt
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @realmem.txt
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @virtualmem.txt
```

InfluxDB optimal batch size for insertion is 5000 entries. So script will auto split files at 5000 lines

```
./psrecord-to-json.sh influx psrecord-ramping-100vus-nginx.log

Saved InfluxDB formatted data files at:
cpuload: cpuload-split-ab (5000)
cpuload: cpuload-split-aa (5000)
cpuload: cpuload-split-ac (5000)
cpuload: cpuload-split-ad (430)
realmem: realmem-split-aa (5000)
realmem: realmem-split-ab (430)
realmem: realmem-split-ac (5000)
realmem: realmem-split-ad (5000)
virtualmem: virtualmem-split-aa (5000)
virtualmem: virtualmem-split-ab (5000)
virtualmem: virtualmem-split-ac (430)
virtualmem: virtualmem-split-ad (5000)

InfluxDB import queries

curl -i -sX POST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE psrecord"
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @cpuload-split-aa
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @cpuload-split-ab
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @cpuload-split-ac
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @cpuload-split-ad
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @realmem-split-aa
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @realmem-split-ab
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @realmem-split-ac
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @realmem-split-ad
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @virtualmem-split-aa
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @virtualmem-split-ab
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @virtualmem-split-ac
curl -i -sX POST 'http://localhost:8186/write?db=psrecord' --data-binary @virtualmem-split-ad
```

Sample contents from InfluxDB formatted data files

```
head -n10 cpuload.txt 
cpuload,app=nginx value=0.000 1665231502000000000
cpuload,app=nginx value=0.000 1665231502000011300
cpuload,app=nginx value=0.000 1665231502000022300
cpuload,app=nginx value=0.000 1665231502000033500
cpuload,app=nginx value=0.000 1665231502000044800
cpuload,app=nginx value=0.000 1665231502000056000
cpuload,app=nginx value=0.000 1665231502000067800
cpuload,app=nginx value=0.000 1665231502000079000
cpuload,app=nginx value=0.000 1665231502000090000
cpuload,app=nginx value=0.000 1665231502000101000
```
```
head -n10 realmem.txt 
realmem,app=nginx value=2426.141 1665231502000000000
realmem,app=nginx value=2426.141 1665231502000011300
realmem,app=nginx value=2426.141 1665231502000022300
realmem,app=nginx value=2426.141 1665231502000033500
realmem,app=nginx value=2426.141 1665231502000044800
realmem,app=nginx value=2426.141 1665231502000056000
realmem,app=nginx value=2426.141 1665231502000067800
realmem,app=nginx value=2426.141 1665231502000079000
realmem,app=nginx value=2426.141 1665231502000090000
realmem,app=nginx value=2426.141 1665231502000101000
```
```
head -n10 virtualmem.txt 
virtualmem,app=nginx value=5810.457 1665231502000000000
virtualmem,app=nginx value=5810.457 1665231502000011300
virtualmem,app=nginx value=5810.457 1665231502000022300
virtualmem,app=nginx value=5810.457 1665231502000033500
virtualmem,app=nginx value=5810.457 1665231502000044800
virtualmem,app=nginx value=5810.457 1665231502000056000
virtualmem,app=nginx value=5810.457 1665231502000067800
virtualmem,app=nginx value=5810.457 1665231502000079000
virtualmem,app=nginx value=5810.457 1665231502000090000
virtualmem,app=nginx value=5810.457 1665231502000101000
```

JSON converted data

```
./psrecord-to-json.sh json psrecord-ramping-100vus-nginx.log
[
  {
    "time": "0.000",
    "cpuload": "0.000",
    "realmem": "2426.141",
    "virtualmem": "5810.457"
  },
  {
    "time": "0.112",
    "cpuload": "0.000",
    "realmem": "2426.141",
    "virtualmem": "5810.457"
  },
  {
    "time": "0.223",
    "cpuload": "0.000",
    "realmem": "2426.141",
    "virtualmem": "5810.457"
  }
]
```

# psrecord InfluxDB / Grafana

For Nginx web server tested CPU and Memory usage

![psrecord nginx](/screenshots/psrecord/psrecord-influxdb-grafana-nginx-01.png)

![psrecord nginx](/screenshots/psrecord/psrecord-influxdb-grafana-nginx-02.png)

