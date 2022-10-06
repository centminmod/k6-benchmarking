// https://github.com/centminmod/k6-reporter
// https://k6.io/docs/using-k6/scenarios/
// https://k6.io/docs/using-k6/scenarios/#executors
// scenario 1
// VU=50; REQRATE=10; TIME=30; DOMAIN=https://yourdomain.com/
// taskset -c 0-3 k6 run -e RPS=${REQRATE} -e DURATION=${TIME}s -e USERS=${VU} -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw-scenarios-htmlreport.gz benchmark-scenarios-htmlreport.js
//
// scenario 2
// VU=50; TIME=30; REQUESTS=100; DOMAIN=https://yourdomain.com/
// taskset -c 0-3 k6 run -e REQUESTS=${REQUESTS} -e DURATION=${TIME}s -e USERS=${VU} -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw-scenarios-htmlreport.gz benchmark-scenarios-htmlreport.js
//
// scenario 3
// VU=50; TIME=30; DOMAIN=https://yourdomain.com/
// taskset -c 0-3 k6 run -e DURATION=${TIME}s -e USERS=${VU} -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw-scenarios-htmlreport.gz benchmark-scenarios-htmlreport.js
//
// scenario 4
// TIME=30; STAGEVU1=25; STAGEVU2=50; STAGEVU3=100; STAGEVU4=0; DOMAIN=https://yourdomain.com/
// taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e URL=$DOMAIN --no-usage-report --out json=summary-raw-scenarios-htmlreport.gz benchmark-scenarios-htmlreport.js
//
// scenario 4 with influxdb + grafana
// export K6_INFLUXDB_USERNAME=
// export K6_INFLUXDB_PASSWORD=
// TIME=30; STAGEVU1=25; STAGEVU2=50; STAGEVU3=100; STAGEVU4=0; DOMAIN=https://yourdomain.com/
// taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e URL=$DOMAIN --no-usage-report --out influxdb=http://localhost:8186/k6 benchmark-scenarios-htmlreport.js
//
// with psrecord
// spid=$(cminfo service-info nginx | jq -r '.MainPID')
// psrecord $spid --include-children --interval 0.1 --duration $((TIME*5+30)) --log psrecord-ramping-vus-nginx.log --plot plot-ramping-vus-nginx.png &
// psrecord "taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e URL=$DOMAIN --no-usage-report --out influxdb=http://localhost:8186/k6 benchmark-scenarios-htmlreport.js" --include-children --interval 0.1 --duration $((TIME*5+30)) --log psrecord-ramping-vus.log --plot plot-ramping-vus.png
//
//
import { check } from "k6";
import { group } from 'k6';
import { sleep } from "k6";
import http from "k6/http";
import exec from "k6/execution";
import { tagWithCurrentStageIndex } from "https://jslib.k6.io/k6-utils/1.4.0/index.js";
import { randomIntBetween } from "https://jslib.k6.io/k6-utils/1.4.0/index.js";
import { htmlReport } from "https://raw.githubusercontent.com/centminmod/k6-reporter/cmm/dist/bundle.js";
// https://k6.io/docs/javascript-api/jslib/utils/randomstring/
//import { randomString } from 'https://jslib.k6.io/k6-utils/1.4.0/index.js';
import {
  jUnit,
  textSummary,
} from "https://jslib.k6.io/k6-summary/0.0.1/index.js";

export const options = {
  // // scenario 1
  // https://k6.io/docs/using-k6/scenarios/executors/constant-arrival-rate
  // scenarios: {
  //   constant_arrival_rate: {
  //     executor: 'constant-arrival-rate',
  //     startTime: '0s',
  //     rate: `${__ENV.RPS}`,
  //     timeUnit: '1s',
  //     duration: `${__ENV.DURATION}`,
  //     preAllocatedVUs: `${__ENV.USERS}`,
  //     maxVUs: 1000,
  //     tags: { executor: 'constant-arrival-rate' },
  //     stages: [
  //       { duration: `${__ENV.STAGETIME}`, target: 25 },
  //       { duration: `${__ENV.STAGETIME}`, target: 50 },
  //       { duration: `${__ENV.STAGETIME}`, target: 100 },
  //       { duration: `${__ENV.STAGETIME}`, target: 0 },
  //     ],
  //   },
  // },
  // // scenario 2
  // https://k6.io/docs/using-k6/scenarios/executors/per-vu-iterations
  // scenarios: {
  //   per_vu_iterations: {
  //     executor: 'per-vu-iterations',
  //     startTime: '0s',
  //     vus: `${__ENV.USERS}`,
  //     iterations: `${__ENV.REQUESTS}`,
  //     maxDuration: `${__ENV.DURATION}`,
  //     tags: { executor: 'per-vu-iterations' },
  //   },
  // },
  // // scenario 3
  // https://k6.io/docs/using-k6/scenarios/executors/constant-vus/
  // scenarios: {
  //   constant_vus: {
  //     executor: 'constant-vus',
  //     startTime: '0s',
  //     vus: `${__ENV.USERS}`,
  //     duration: `${__ENV.DURATION}`,
  //     tags: { executor: 'constant-vus' },
  //   },
  // },
  // // scenario 4
  // https://k6.io/docs/using-k6/scenarios/executors/ramping-vus
  scenarios: {
    ramping_vus: {
      executor: 'ramping-vus',
      startTime: '0s',
      startVUs: 0,
      stages: [
        { duration: `${__ENV.STAGETIME}`, target: `${__ENV.STAGE_VU1}` },
        { duration: `${__ENV.STAGETIME}`, target: `${__ENV.STAGE_VU2}` },
        { duration: `${__ENV.STAGETIME}`, target: `${__ENV.STAGE_VU3}` },
        { duration: `${__ENV.STAGETIME}`, target: `${__ENV.STAGE_VU4}` },
      ],
      gracefulRampDown: '0s',
      tags: { executor: 'ramping-vus' },
    },
  },
  // httpDebug: 'full',
  insecureSkipTLSVerify: true,
  discardResponseBodies: true,
  noConnectionReuse: false,
  userAgent:
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.66 Safari/537.36 OPR/89.0.4447.38",
  summaryTrendStats: [
    "avg",
    "min",
    "med",
    "max",
    "p(95)",
    "p(99)",
    "p(99.99)",
    "count",
  ],
  tlsVersion: {
    min: "tls1.2",
    max: "tls1.3",
  },
  thresholds: {
    'http_req_duration{gzip:yes}': ["avg<150", "p(95)<500"],
    // http_req_duration: ["avg<150", "p(95)<500"],
    // http_req_duration: ['p(90) < 200', 'p(95) < 300', 'p(99.9) < 2000'],
  },
};

export function handleSummary(data) {
  return {
    "result-scenarios.html": htmlReport(data),
    stdout: textSummary(data, { indent: " ", enableColors: true }),
    "summary-scenarios-htmlreport.json": JSON.stringify(data),
  };
}

export default function () {
  const sleepMin = 1;
  const sleepMax = 5;
  tagWithCurrentStageIndex();
  // console.log(exec.test.options.scenarios.default.stages[0].target)
  // console.log(exec.instance.vusActive);
  const params = {
    headers: {
      accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
      "accept-encoding": "gzip, deflate",
      "accept-language": "en-US,en;q=0.9",
      connection: "keep-alive",
    },
    // cookies: { my_cookie: 'value' },
    // redirects: 5,
    tags: { 
      gzip: 'yes'
    }
  };
  group('main index page', function () {
    const res = http.get(`${__ENV.URL}`, params);
    // console.log('Response time was ' + String(res.timings.duration) + ' ms');
    check(res, {
      "is status 200": (r) => r.status === 200,
    });
    // sleep(1);
    // sleep(randomIntBetween(sleepMin, sleepMax));
   });
}