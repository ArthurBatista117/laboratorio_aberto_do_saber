'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Usuario extends Model {
    static associate(models) {
      //TODO
    }
  }

  Usuario.init({
    nome: {
      type: DataTypes.STRING,
      allowNull: false
    },
    email: { type: DataTypes.STRING, unique: true },
    senha: DataTypes.STRING,
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
    },
  }, {
    sequelize,
    modelName: 'Usuario',
    tableName: 'Usuarios', 
    timestamps: true,     
  });

  return Usuario;
};

