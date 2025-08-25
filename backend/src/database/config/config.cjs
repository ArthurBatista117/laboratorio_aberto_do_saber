const { Sequelize } = require("sequelize");

const sequelize = new Sequelize(process.env.DATABASE_URL, {
  dialect: "postgres",
  protocol: "postgres",
  logging: false, // deixa true se quiser ver os SQLs no log
  dialectOptions: {
    ssl: process.env.NODE_ENV === "production"
      ? { require: true, rejectUnauthorized: false }
      : false
  },
  retry: {
    max: 5,          // tenta até 5 vezes
    match: [
      /ECONNREFUSED/,
      /ETIMEDOUT/,
      /EHOSTUNREACH/,
      /EPIPE/,
      /SequelizeConnectionError/,
      /SequelizeConnectionRefusedError/,
      /SequelizeHostNotFoundError/,
      /SequelizeHostNotReachableError/,
      /SequelizeInvalidConnectionError/,
      /SequelizeConnectionTimedOutError/
    ]
  }
});

module.exports = sequelize;
