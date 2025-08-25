'use strict';

const { Model, DataTypes } = require('sequelize');
const sequelize = require('../database'); // caminho do index.js da conexão

class Usuario extends Model {}

Usuario.init(
  {
    nome: {
      type: DataTypes.STRING,
      allowNull: false
    },
    email: {
      type: DataTypes.STRING,
      unique: true,
      allowNull: false
    },
    senha: {
      type: DataTypes.STRING,
      allowNull: false
    },
    cpf: {
      type: DataTypes.STRING,
      unique: true,
      allowNull: false
    },
    telefone: {
      type: DataTypes.STRING,
      unique: true,
      allowNull: false
    },
    tipo: {
      type: DataTypes.ENUM('admin', 'normal'),
      defaultValue: 'normal',
      allowNull: false
    }
  },
  {
    sequelize,
    modelName: 'Usuario',
    tableName: 'Usuarios',
    timestamps: true // createdAt e updatedAt
  }
);

module.exports = Usuario;
