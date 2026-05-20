#!/usr/bin/env node
'use strict';

const path = require('path');
const Database = require('../backend/node_modules/better-sqlite3');

const DB_PATH = path.join(__dirname, '../backend/todos.db');

const shorthands = {
  tables: "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name",
  todos: 'SELECT * FROM todos',
  pending: 'SELECT * FROM todos WHERE completed = 0',
  done: 'SELECT * FROM todos WHERE completed = 1',
};

const arg = process.argv[2];
if (!arg) {
  console.error('Usage: node scripts/db-inspect.js <query|shorthand>');
  console.error('       bun scripts/db-inspect.js <query|shorthand>');
  console.error('Shorthands:', Object.keys(shorthands).join(', '));
  process.exit(1);
}

const sql = shorthands[arg] ?? arg;

const db = new Database(DB_PATH, { readonly: true });

try {
  const rows = db.prepare(sql).all();
  console.table(rows);
  console.log(`\n${rows.length} row(s)`);
} catch (err) {
  console.error('Query error:', err.message);
  process.exit(1);
}
