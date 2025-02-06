const express = require('express');
const helmet = require('helmet');
const app = express();

app.use(
  helmet.contentSecurityPolicy({
    directives: {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'", "https://trusted.cdn.com"],
      objectSrc: ["'none'"]
    },
  })
);

app.get('/', (req, res) => {
  res.send('CSP ist aktiv!' +
    '<script src="https://www.dev-journey.de/js/test.js"></script>');
});

app.listen(3000, () => console.log('Server läuft auf Port 3000'));
