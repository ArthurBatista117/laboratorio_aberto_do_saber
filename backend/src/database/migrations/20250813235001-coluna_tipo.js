'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    queryInterface.addColumn('Usuarios', 'tipo', {
      type: Sequelize.ENUM('admin', 'normal'),
      defaultValue: 'normal',
      allowNull: false
    })
  },

  async down (queryInterface, Sequelize) {
    queryInterface.removeColumn('Usuarios', 'tipo');
  }
};
