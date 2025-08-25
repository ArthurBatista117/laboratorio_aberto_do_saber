'use strict';
const { Model, DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  class Usuario extends Model {
    static associate(models) {
      // aqui você define associações, se houver
      // ex: Usuario.hasMany(models.Post);
    }
  }

  Usuario.init({
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
  }, {
    sequelize,
    modelName: 'Usuario',
    tableName: 'Usuarios',   // força o nome exato da tabela
    freezeTableName: true,   // evita pluralização automática
    timestamps: true         // createdAt e updatedAt
  });

  return Usuario;
};
