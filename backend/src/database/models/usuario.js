'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Usuario extends Model {
    static associate(models) {
      // define association here
    }
  }
  Usuario.init({
    nome: DataTypes.STRING,
    email: {
      type: DataTypes.STRING,
      unique: true
    },
    senha: DataTypes.STRING,
    cpf: {
      type: DataTypes.STRING,
      unique: true
    },
    telefone: {
      type: DataTypes.STRING,
      unique: true
    },
    tipo: {
      type: DataTypes.ENUM('admin', 'normal'),
      defaultValue: 'normal',
      allowNull: false
    }
  }, {
    sequelize, // << obrigatório, vem do parâmetro da função
    modelName: 'Usuario'
  });
  return Usuario;
};
