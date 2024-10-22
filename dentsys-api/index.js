// index.js
import express from 'express';
import routes from './src/routes/routes.js';
// import bodyParser from 'body-parser';
import pool from './config/db.js';

const app = express();
const PORT = process.env.PORT || 3000;

// middleware
app.use(express.json()); // Built-in middleware for parsing JSON
app.use(express.urlencoded({ extended: true }));

// Routing
app.use('/api', routes);

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});

export default app; // Export the app for testing
