

const mysql = require('mysql2');

const pool = mysql.createPool({
  host: 'localhost',        // ou ton IP locale
  user: 'root',             // utilisateur MySQL
  password: '@Seynaboudione03',// mot de passe MySQL
  database: 'adminXpress',      // nom de ta base
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

const promisePool = pool.promise();
module.exports = promisePool;
