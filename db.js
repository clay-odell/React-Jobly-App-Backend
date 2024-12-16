require('dotenv').config();
const { Client } = require('pg');

// PostgreSQL configuration
const client = new Client({
  host: process.env.PGHOST,
  port: process.env.PGPORT,
  user: process.env.PGUSER,
  password: process.env.PGPASSWORD,
  database: process.env.PGDATABASE,
});

// Connect to PostgreSQL
client.connect()
  .then(() => console.log('Connected to database'))
  .catch(err => console.error('Connection error', err.stack));

module.exports = client;
