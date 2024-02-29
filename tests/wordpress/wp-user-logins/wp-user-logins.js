import http from 'k6/http';
import { check, sleep } from 'k6';

export let options = {
    stages: [
        { duration: '1m', target: 10 }, // Ramp up to 10 users over 1 minute
        { duration: '2m', target: 10 }, // Stay at 10 users for 2 minutes
        { duration: '1m', target: 0 },  // Ramp down to 0 users over 1 minute
    ],
};

const BASE_URL = __ENV.SITE_URL || 'http://localhost'; // Default to localhost if not provided

export default function () {
    // Dynamically construct the username based on the iteration (VU number)
    const username = `test${__VU}`;
    const password = '3405691582'; // Assuming all users have the same password

    var payload = {
        log: username,
        pwd: password,
        wp_submit: 'Log In',
        redirect_to: `${BASE_URL}/wp-admin`,
        testcookie: '1',
    };

    var params = {
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
    };

    let response = http.post(`${BASE_URL}/wp-login.php`, payload, params);

    check(response, {
        'is status 200': (r) => r.status === 200,
        'is redirected to wp-admin': (r) => r.url.includes('/wp-admin'),
    });

    // Optionally, add sleep to simulate think time
    sleep(1);
}
