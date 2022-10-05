//
// TIME=30; DOMAIN=https://yourdomain.com/
// taskset -c 0-3 k6 run -e STAGETIME=${TIME}s -e URL=$DOMAIN --no-usage-report --out json=summary-raw.gz benchmark.js
//
import { check } from "k6";
import { group } from 'k6';
import { sleep } from "k6";
import http from "k6/http";
import exec from "k6/execution";
import { tagWithCurrentStageIndex } from "https://jslib.k6.io/k6-utils/1.3.0/index.js";
import { randomIntBetween } from "https://jslib.k6.io/k6-utils/1.1.0/index.js";
// https://k6.io/docs/javascript-api/jslib/utils/randomstring/
//import { randomString } from 'https://jslib.k6.io/k6-utils/1.2.0/index.js';
import {
  jUnit,
  textSummary,
} from "https://jslib.k6.io/k6-summary/0.0.1/index.js";

export let options = {
  // httpDebug: 'full',
  // insecureSkipTLSVerify: true,
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
  stages: [
    { duration: `${__ENV.STAGETIME}`, target: 25 },
    { duration: `${__ENV.STAGETIME}`, target: 50 },
    { duration: `${__ENV.STAGETIME}`, target: 100 },
    { duration: `${__ENV.STAGETIME}`, target: 0 },
  ],
  thresholds: {
    'http_req_duration{gzip:yes}': ["avg<150", "p(95)<500"],
    // http_req_duration: ["avg<150", "p(95)<500"],
    // http_req_duration: ['p(90) < 200', 'p(95) < 300', 'p(99.9) < 2000'],
  },
};

export function handleSummary(data) {
  return {
    stdout: textSummary(data, { indent: " ", enableColors: true }),
    "summary.json": JSON.stringify(data),
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