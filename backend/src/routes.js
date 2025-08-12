const express = require('express');
const Router = express.Router();
const usuarioController = require('./app/controllers/usuarioController');

Router.get('/hello', usuarioController.index);
Router.post('/usu', usuarioController.create);

module.exports = Router;