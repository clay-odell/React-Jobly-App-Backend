require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');
const { SECRET_KEY } = require('./config');

// Supabase configuration
const supabaseUrl = 'https://nvxuqdswkjjdkkumwfxv.supabase.co'; // Replace with your actual Project URL
const supabaseKey = SECRET_KEY; // Make sure this key is set in your .env file

const supabase = createClient(supabaseUrl, supabaseKey);

module.exports = supabase;
