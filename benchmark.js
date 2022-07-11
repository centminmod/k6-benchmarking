import { check } from "k6";
import { sleep } from "k6";
import http from "k6/http";
import exec from "k6/execution";
import { tagWithCurrentStageIndex } from "https://jslib.k6.io/k6-utils/1.3.0/index.js";
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
    { duration: `${__ENV.STAGETIME}`, target: 100 },
    { duration: `${__ENV.STAGETIME}`, target: 100 },
    { duration: `${__ENV.STAGETIME}`, target: 0 },
  ],
  thresholds: {
    http_req_duration: ["avg<150", "p(95)<500"],
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
  tagWithCurrentStageIndex();
  // console.log(exec.test.options.scenarios.default.stages[0].target)
  // console.log(exec.instance.vusActive);
  let params = {
    headers: {
      "Accept-Encoding": "gzip, deflate",
    },
    // cookies: { my_cookie: 'value' },
    // redirects: 5,
    // tags: { multistage_gzip: 'yes' }
  };
  let res = http.get(`${__ENV.URL}`, params);
  // console.log('Response time was ' + String(res.timings.duration) + ' ms');
  check(res, {
    "is status 200": (r) => r.status === 200,
  });
}