'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Usuario extends Model {
    static associate(models) {
      // define associações aqui
    }
  }

  Usuario.init({
    nome: DataTypes.STRING,
    email: { type: DataTypes.STRING, unique: true },
    senha: DataTypes.STRING,
    cpf: { type: DataTypes.STRING, unique: true },
    telefone: { type: DataTypes.STRING, unique: true },
    tipo: { type: DataTypes.ENUM('admin', 'normal'), defaultValue: 'normal', allowNull: false },
  }, {
    sequelize,
    modelName: 'Usuario',
    tableName: 'Usuarios', // <-- aqui você força o nome da tabela
    timestamps: true,      // createdAt e updatedAt
  });

  return Usuario;
};

