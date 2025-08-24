const express = require('express');
const Router = express.Router();
const usuarioController = require('./app/controllers/usuarioController');
const whatsappController = require('./app/controllers/whatsappController');

Router.get('/hello', usuarioController.index);
Router.post('/usu', usuarioController.create);

app.post('/whatsapp/send', whatsappController.sendMessage);

module.exports = Router;