'use strict';

const tokens = require('../../middlewares/autentication/util');

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('Usuarios', [
      {
        nome: 'Arthur Batista',
        email: 'arthur.batistadev@gmail.com',
        senha: '123456',
        cpf: '00000000000',
        telefone: '00000000000',
        refresh_token: tokens.gerar_refresh_token(),
        createdAt: new Date(),
        updatedAt: new Date()
      }
    ]);
  },

  async down (queryInterface, Sequelize) {
    
    await queryInterface.bulkDelete('Usuarios', {email: 'arthur.batistadev@gmail.com'});
     
  }
};
