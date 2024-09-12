// Express framework 
const express = require('express');
const os = require('os');

// instance of express
const app = express();

// Function to get the host IP address
function getHostIP() {
    const interfaces = os.networkInterfaces();
    for (const name in interfaces) {
        for (const iface of interfaces[name]) {
            if (iface.family === 'IPv4' && !iface.internal) {
                return iface.address;
            }
        }
    }
    return 'No IP address found';
}

// Define a route for the root URL
app.get('/', (req, res) => {
    const ip = getHostIP();
    res.status(200).send(`Hello world from ${ip}`);
});

const PORT = process.env.PORT || 3000;

// Start the server
app.listen(PORT, '0.0.0.0', () => {
    console.log(`The server is running on port: ${PORT}`);
});
