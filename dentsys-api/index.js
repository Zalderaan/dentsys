// index.js
const express = require('express');
const routes = require('./src/routes/routes.js');

const app = express();
const PORT = process.env.PORT || 3000;

// middleware
app.use(express.json()); // Built-in middleware for parsing JSON
app.use(express.urlencoded({ extended: true }));

// Routing
app.use('/dentsys-api', routes);

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});

module.exports = app;
