const { Usuario } = require('../../database/models');

class UsuarioController {
    async index(req, res) {
        try {
            const usuarios = await Usuario.findAll();
            return res.status(200).json(usuarios);
        }
        catch (error) {
            console.error(error);
            return res.status(500).json({ error: "Erro interno do servidor" });
        }
    }
    async show(req, res) {
        try {
            //console.log('paramêtros recebidos: ', req.params);
            const id = req.params.id;
            const usuario = await Usuario.findByPk(id);
            return res.status(200).json(usuario);
        }
        catch (error) {
            console.error(error);
            return res.status(500).json({ error: "Erro interno do servidor" });
        }
    }
    async create(req, res) {
        try {
            //console.log('Body recebido:', req.body);
            const { nome, email, senha, cpf, telefone } = req.body;
            const newUsuario = await Usuario.create({ nome, email, senha, cpf, telefone });
            return res.status(201).json({
                "message": "Usuário criado",
                "Usuario": newUsuario
            });
        }
        catch (error) {
            console.error(error);
            return res.status(500).json({ error: "Erro interno do servidor" });
        }
    }
    async update(req, res) {
        //console.log('Body recebido:', req.body);
        try {
            const usuario = await Usuario.findByPk(req.params.id);

            if (!usuario) {
                return res.status(404).json({ error: 'Usuário não encontrado' });
            }

            // Atualiza apenas os campos enviados no body
            Object.assign(usuario, req.body);

            await usuario.save();

            res.json(usuario);
        } catch (err) {
            res.status(500).json({ error: 'Erro ao atualizar usuário' });
        }
    }
    async destroy(req, res){
        try{
            const id = req.body.id;
            const usuario = await Usuario.findByPk(id);
            if(!usuario){
                console.log('Usuário não encontrado');
                return res.json({'message': 'Usuário não encontrado'})
            }
            await usuario.destroy();

            return res.json('Usuário apagado');
        }catch(error){
            console.error(error);
            return res.status(500).json({ error: "Erro interno do servidor" });
        }
    }
}

module.exports = new UsuarioController();