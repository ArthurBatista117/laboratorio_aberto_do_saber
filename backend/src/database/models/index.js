const { Sequelize } = require("sequelize");
require("dotenv").config();

const sequelize = new Sequelize(process.env.DATABASE_URL, {
  dialect: "postgres",
  logging: false, // true para ver os SQLs no log
  dialectOptions: {
    ssl: process.env.NODE_ENV === "production"
      ? { require: true, rejectUnauthorized: false }
      : false
  },
  retry: {
    max: 5,
    match: [
      /ECONNREFUSED/,
      /ETIMEDOUT/,
      /EHOSTUNREACH/,
      /EPIPE/,
      /SequelizeConnectionError/,
      /SequelizeConnectionRefusedError/
    ]
  }
});

module.exports = sequelize;
