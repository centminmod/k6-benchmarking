[k6 benchmarking](https://k6.io/docs/)

```
TIME=2
DOMAIN=https://domain.com/
taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report benchmark.js
```