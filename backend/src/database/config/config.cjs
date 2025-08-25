require('dotenv').config();

module.exports = {
  "development": {
    "username": process.env.DB_USER,
    "password": process.env.DB_PASSWORD,
    "database": process.env.DATABASE_URL,
    "host": process.env.DB_HOST,
    "dialect": process.env.DB_DIALECT,
    dialectOptions: {}
  },
  "test": {
    "username": process.env.DB_USER,
    "password": process.env.DB_PASSWORD,
    "database": process.env.DATABASE_URL,
    "host": process.env.DB_HOST,
    "dialect": process.env.DB_DIALECT,
    dialectOptions: {}
  },
  "production": {
    "username": process.env.DB_USER,
    "password": process.env.DB_PASSWORD,
    "database": process.env.DATABASE_URL,
    "host": process.env.DB_HOST,
    "dialect": process.env.DB_DIALECT,
    dialectOptions: {}
  }
}
