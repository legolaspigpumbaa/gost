const express = require('express');
const http = require('http');

const app = express();

// تنظیم پورت و آدرس آی‌پی مقصد
const destinationIP = '64.227.32.106';
const destinationPort = 80;

app.use(express.json());

app.all('*', (req, res) => {
  const options = {
    hostname: destinationIP,
    port: destinationPort,
    path: req.path,
    method: req.method,
    headers: req.headers,
  };

  const proxyReq = http.request(options, (proxyRes) => {
    res.writeHead(proxyRes.statusCode, proxyRes.headers);
    proxyRes.pipe(res, {
      end: true
    });
  });

  req.pipe(proxyReq, {
    end: true
  });

  proxyReq.on('error', (err) => {
    console.error('Proxy request failed:', err);
    res.status(500).send('Proxy request failed');
  });
});

const server = http.createServer(app);

const PORT = process.env.PORT || 3000;

server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
