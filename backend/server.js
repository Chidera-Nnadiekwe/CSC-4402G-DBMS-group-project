const dotenv = require('dotenv');
const path   = require('path');
dotenv.config({ path: path.join(__dirname, '.env'), override: true });

const express = require('express');
const cors    = require('cors');

const app = express();

app.use(cors());
app.use(express.json());

// Routes
app.use('/api/countries', require('./routes/countries'));
app.use('/api/trade',     require('./routes/trade'));

// Health check
app.get('/api/health', (req, res) => {
    res.json({ status: 'ok', message: 'ITRD API is running' });
});

// Debug endpoint (remove after testing)
app.get('/api/debug', (req, res) => {
    const fs   = require('fs');
    const path = require('path');
    const envPath = path.join(__dirname, '.env');
    const exists  = fs.existsSync(envPath);
    const content = exists ? fs.readFileSync(envPath, 'utf8') : 'FILE NOT FOUND';
    res.json({
        envFileExists: exists,
        envFilePath: envPath,
        envFileContent: content.replace(/PASSWORD=.+/i, 'PASSWORD=***')
    });
});

const PORT = process.env.PORT || 3001;
const server = app.listen(PORT, () => {
    console.log(`ITRD Backend running on http://localhost:${PORT}`);
});

server.on('error', (err) => {
    console.error('Server error:', err.message);
});

process.on('uncaughtException', (err) => {
    console.error('Uncaught exception:', err.message);
});

process.on('exit', (code) => {
    console.log('Process exiting with code:', code);
});
