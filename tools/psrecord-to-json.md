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
```

These files will be inserted into InfluxDB database `psrecord` via:

```
curl -i -XPOST http://localhost:8186/query --data-urlencode "q=CREATE DATABASE psrecord"
curl -i -XPOST 'http://localhost:8186/write?db=psrecord' --data-binary @cpuload.txt
curl -i -XPOST 'http://localhost:8186/write?db=psrecord' --data-binary @realmem.txt
curl -i -XPOST 'http://localhost:8186/write?db=psrecord' --data-binary @virtualmem.txt
```

Sample contents from InfluxDB formatted data files

```
head -n10 cpuload.txt 
cpuload,domain=domain1.com value=0.000 1665231502000000000
cpuload,domain=domain1.com value=0.000 1665231502000011300
cpuload,domain=domain1.com value=0.000 1665231502000022300
cpuload,domain=domain1.com value=0.000 1665231502000033500
cpuload,domain=domain1.com value=0.000 1665231502000044800
cpuload,domain=domain1.com value=0.000 1665231502000056000
cpuload,domain=domain1.com value=0.000 1665231502000067800
cpuload,domain=domain1.com value=0.000 1665231502000079000
cpuload,domain=domain1.com value=0.000 1665231502000090000
cpuload,domain=domain1.com value=0.000 1665231502000101000
```
```
head -n10 realmem.txt 
realmem,domain=domain1.com value=2426.141 1665231502000000000
realmem,domain=domain1.com value=2426.141 1665231502000011300
realmem,domain=domain1.com value=2426.141 1665231502000022300
realmem,domain=domain1.com value=2426.141 1665231502000033500
realmem,domain=domain1.com value=2426.141 1665231502000044800
realmem,domain=domain1.com value=2426.141 1665231502000056000
realmem,domain=domain1.com value=2426.141 1665231502000067800
realmem,domain=domain1.com value=2426.141 1665231502000079000
realmem,domain=domain1.com value=2426.141 1665231502000090000
realmem,domain=domain1.com value=2426.141 1665231502000101000
```
```
head -n10 virtualmem.txt 
cpuload,domain=domain1.com value=5810.457 1665231502000000000
cpuload,domain=domain1.com value=5810.457 1665231502000011300
cpuload,domain=domain1.com value=5810.457 1665231502000022300
cpuload,domain=domain1.com value=5810.457 1665231502000033500
cpuload,domain=domain1.com value=5810.457 1665231502000044800
cpuload,domain=domain1.com value=5810.457 1665231502000056000
cpuload,domain=domain1.com value=5810.457 1665231502000067800
cpuload,domain=domain1.com value=5810.457 1665231502000079000
cpuload,domain=domain1.com value=5810.457 1665231502000090000
cpuload,domain=domain1.com value=5810.457 1665231502000101000
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