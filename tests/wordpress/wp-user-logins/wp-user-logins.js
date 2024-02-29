import http from 'k6/http';
import { check, sleep } from 'k6';
import { htmlReport } from "https://raw.githubusercontent.com/centminmod/k6-reporter/cmm/dist/bundle.js";
import {
  jUnit,
  textSummary,
} from "https://jslib.k6.io/k6-summary/0.0.1/index.js";

export let options = {
    stages: [
        { duration: '45s', target: 100 }, // Ramp up to 10 users
        { duration: '60', target: 100 }, // Stay at 10 users
        { duration: '15s', target: 0 },  // Ramp down to 0 users
    ],
    discardResponseBodies: true,
    noConnectionReuse: false,
    userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.66 Safari/537.36 OPR/89.0.4447.38",
    summaryTrendStats: ["avg", "min", "med", "max", "p(95)", "p(99)", "p(99.99)", "count"],
    tlsVersion: { min: "tls1.2", max: "tls1.3" },
    // thresholds: {
    //     'http_req_duration{gzip:yes}': ["avg<150", "p(95)<500"],
    // },
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
            connection: "keep-alive",
        },
    };

    let response = http.post(`${BASE_URL}/wp-login.php`, payload, params);
    // let response = http.post(`${BASE_URL}/wp-login.php`, payload, params, {insecureSkipTLSVerify: true});

    check(response, {
        'is status 200': (r) => r.status === 200,
        // 'is redirected to wp-admin': (r) => r.url.includes('/wp-admin'),
    });

    // Optionally, add sleep to simulate think time
    sleep(1);
}
