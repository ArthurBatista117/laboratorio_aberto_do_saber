const { Usuario } = require('../../database/models');

class UsuarioController{
    async index(req, res){
        const usuarios = await Usuario.findAll();
        return res.status(200).json(usuarios);
    }
    async show(req, res){
        const id = req.params.id;
        const usuario = await Usuario.findById(id);
        return res.status(200).json(usuario);
    }
    async create(req, res){
        //console.log('Body recebido:', req.body);
        const { nome, email, senha, cpf, telefone } = req.body;
        const newUsuario = await Usuario.create({ nome, email, senha, cpf, telefone });
        return res.status(201).json({
            "message": "Usuário criado",
            "Usuario": newUsuario
        })
    }
}

module.exports = new UsuarioController();