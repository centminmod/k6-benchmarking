// VU=50; REQRATE=100; TIME=60; STAGEVU1=25; STAGEVU2=75; STAGEVU3=150; STAGEVU4=0; DOMAIN=https://wpel9.domain.com/
// K6_WEB_DASHBOARD=true K6_WEB_DASHBOARD_EXPORT=html-report.html taskset -c 0-3 k6 run -e RPS=${REQRATE} -e USERS=${VU} -e REQRATE_USERS=${VU} -e RPS=$REQRATE -e STAGETIME=${TIME}s -e STAGE_VU1=${STAGEVU1} -e STAGE_VU2=${STAGEVU2} -e STAGE_VU3=${STAGEVU3} -e STAGE_VU4=${STAGEVU4} -e SITE_URL=$DOMAIN wp-user-login-multi.js
// https://jslib.k6.io/

import http from 'k6/http';
import exec from "k6/execution";
import { check, sleep } from 'k6';
import { Trend } from "k6/metrics";
import { tagWithCurrentStageIndex } from "https://jslib.k6.io/k6-utils/1.4.0/index.js";
import { randomIntBetween } from "https://jslib.k6.io/k6-utils/1.4.0/index.js";
import { htmlReport } from "https://raw.githubusercontent.com/centminmod/k6-reporter/cmm/dist/bundle.js";
import {
  jUnit,
  textSummary,
} from "https://jslib.k6.io/k6-summary/0.1.0/index.js";

export let options = {
    scenarios: {
        // // scenario 1
        // https://k6.io/docs/using-k6/scenarios/executors/constant-arrival-rate
        ramping_vus: {
        executor: 'ramping-vus',
        exec:     'default',
        startTime: `${__ENV.STAGETIME + 20}s`,
        // startTime: '0s',
        startVUs: `${__ENV.USERS}` || 0,
        stages: [
            { duration: `${__ENV.STAGETIME}`, target: `${__ENV.STAGE_VU1}` },
            { duration: `${__ENV.STAGETIME}`, target: `${__ENV.STAGE_VU2}` },
            { duration: `${__ENV.STAGETIME}`, target: `${__ENV.STAGE_VU3}` },
            { duration: `${__ENV.STAGETIME}`, target: `${__ENV.STAGE_VU4}` },
        ],
        gracefulRampDown: '5s',
        gracefulStop:     '5s',
        tags: { executor: 'ramping-vus' },
        },
        constant_arrival_rate: {
        executor: 'constant-arrival-rate',
        exec:     'constantarrival',
        startTime: '0s',
        rate: `${__ENV.RPS}`,
        timeUnit: '1s',
        duration: `${__ENV.STAGETIME}`,
        preAllocatedVUs: `${__ENV.REQRATE_USERS}`,
        maxVUs: 1000,
        gracefulStop:     '5s',
        tags: { executor: 'constant-arrival-rate' },
        },
    },
    // httpDebug: 'full',
    insecureSkipTLSVerify: true,
    discardResponseBodies: true,
    noConnectionReuse: false,
    userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.66 Safari/537.36 OPR/89.0.4447.38",
    summaryTrendStats: ["avg", "min", "med", "max", "p(95)", "p(99)", "p(99.99)", "count"],
    tlsVersion: { min: "tls1.2", max: "tls1.3" },
    // thresholds: {
    //     'http_req_duration{gzip:yes}': ["avg<150", "p(95)<500"],
    // },
    systemTags: [ 'status', 'name', 'check', 'error', 'error_code', 'scenario', 'expected_response'],
};

const BASE_URL = __ENV.SITE_URL || 'http://localhost'; // Default to localhost if not provided

export function handleSummary(data) {
  return {
    "result-scenarios.html": htmlReport(data),
    stdout: textSummary(data, { indent: " ", enableColors: true }),
    "summary-scenarios-htmlreport.json": JSON.stringify(data),
  };
}

export default function () {
    tagWithCurrentStageIndex();
    // Dynamically construct the username based on the iteration (VU number)
    const username = `test${__VU}`;
    const password = '3405691999'; // Assuming all users have the same password

    var payload = {
        log: username,
        pwd: password,
        wp_submit: 'Log In',
        redirect_to: `${BASE_URL}/wp-admin`,
        testcookie: '1',
    };

    var params = {
        headers: {
            "Content-Type": 'application/x-www-form-urlencoded',
            "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
            "accept-encoding": "gzip, deflate",
            "accept-language": "en-US,en;q=0.9",
            "connection": "keep-alive",
            "x-bench": "rampingvus",
        },
        tags: {scenario: "ramping_vus"},
    };

    let response = http.post(`${BASE_URL}/wp-login.php`, payload, params);
    // let response = http.post(`${BASE_URL}/wp-login.php`, payload, params, {insecureSkipTLSVerify: true});

    check(response, {
        'ramping: is status 200': (r) => r.status === 200,
        // 'is redirected to wp-admin': (r) => r.url.includes('/wp-admin'),
    });

    sleep(1);
}

export function constantarrival() {
    // Dynamically construct the username based on the iteration (VU number)
    const username = `test${__VU}`;
    const password = '3405691999'; // Assuming all users have the same password

    var payload = {
        log: username,
        pwd: password,
        wp_submit: 'Log In',
        redirect_to: `${BASE_URL}/wp-admin`,
        testcookie: '1',
    };

    var params = {
        headers: {
            "Content-Type": 'application/x-www-form-urlencoded',
            "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
            "accept-encoding": "gzip, deflate",
            "accept-language": "en-US,en;q=0.9",
            "connection": "keep-alive",
            "x-bench": "constantarrival",
        },
        tags: {scenario: "constant_arrival_rate"}
    };

    let response = http.post(`${BASE_URL}/wp-login.php`, payload, params);
    // let response = http.post(`${BASE_URL}/wp-login.php`, payload, params, {insecureSkipTLSVerify: true});

    check(response, {
        'constant: is status 200': (r) => r.status === 200,
        // 'is redirected to wp-admin': (r) => r.url.includes('/wp-admin'),
    });

    sleep(1);
}