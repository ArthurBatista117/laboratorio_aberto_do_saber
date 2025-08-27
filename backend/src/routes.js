const express = require('express');
const Router = express.Router();
const usuarioController = require('./app/controllers/usuarioController');
const autenticar = require('./middlewares/autentication/auth');
const whatsappController = require('./app/controllers/whatsappController');

Router.get('/usuarios', autenticar, usuarioController.index);
Router.get('/usuarios/${id}', usuarioController.show);
Router.post('/cadastro', usuarioController.cadastro);
Router.post('/login', usuarioController.login);
Router.put('/alterarusuario', usuarioController.update);
Router.delete('/delete', usuarioController.destroy)
Router.post('/whatsapp/send', whatsappController.sendMessage);
Router.get('/ping', (req, res) => res.send('pong'));


module.exports = Router;