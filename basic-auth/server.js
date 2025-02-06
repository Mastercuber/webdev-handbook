const express = require('express');
const app = express();

app.get('/', (req, res) => {
    if (!req.headers.authorization) {
        res.setHeader('WWW-Authenticate', 'Basic realm="test"')
        res.status(401).send('Authentifizierung nötig')
    } else {
        console.debug(req.headers.authorization)
        res.send('Erfolgreich authentifiziert');
    }
});

app.listen(3000, () => console.log('Server läuft auf Port 3000'));
