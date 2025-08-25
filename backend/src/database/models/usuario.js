const { Model, DataTypes } = require('sequelize');
const sequelize = require('../database');

class Usuario extends Model {}

Usuario.init({
  nome: { type: DataTypes.STRING, allowNull: false },
  email: { type: DataTypes.STRING, unique: true, allowNull: false },
  senha: { type: DataTypes.STRING, allowNull: false },
  cpf: { type: DataTypes.STRING, unique: true, allowNull: false },
  telefone: { type: DataTypes.STRING, unique: true, allowNull: false },
  tipo: { type: DataTypes.ENUM('admin','normal'), defaultValue: 'normal', allowNull: false }
}, {
  sequelize,
  modelName: 'Usuario',
  tableName: 'Usuarios',
  timestamps: true
});

module.exports = Usuario;
