require('dotenv').config();
const { Client } = require('pg');
const { createClient } = require('@supabase/supabase-js');

// Supabase configuration
const supabaseUrl = 'https://nvxuqdswkjjdkkumwfxv.supabase.co';
const supabaseKey = process.env.SUPABASE_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

// PostgreSQL configuration
const client = new Client({
  host: process.env.PGHOST,
  port: process.env.PGPORT,
  user: process.env.PGUSER,
  password: process.env.PGPASSWORD,
  database: process.env.PGDATABASE
});

// Connect to PostgreSQL
client.connect()
  .then(() => console.log('Connected to Supabase database'))
  .catch(err => console.error('Connection error', err.stack));


module.exports = { client, supabase };
