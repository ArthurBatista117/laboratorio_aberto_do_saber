const { Usuario } = require('../../database/models');
const tokens = require('../../middlewares/autentication/util');
const hashUser = require('../../middlewares/hash/hashUser');

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
    async cadastro(req, res) {
        console.log('Chegou no endpoint /cadastro');
        console.log('Body recebido:', req.body);
        try {
            const { nome, email, senha, cpf, telefone } = req.body;
            if (!nome || !email || !senha || !cpf || !telefone) {
                return res.status(400).json({ error: 'Campos obrigatórios faltando' });
            }
            const hash_senha = await hashUser.encripitar(senha);
            console.log("Senha hasheada:", hash_senha);
            const newUsuario = await Usuario.create({
                nome: nome,
                email: email,
                senha: hash_senha,
                cpf: cpf,
                telefone: telefone
            });

            console.log("Usuario criado:", newUsuario.toJSON());

            return res.status(201).json({
                "message": "Usuário criado",
                "Usuario": newUsuario.toJSON()
            });
        }
        catch (error) {
            console.error("Erro no cadastro:", error);
            if (error.name === 'SequelizeUniqueConstraintError') {
                return res.status(400).json({ error: "CPF, email ou telefone já cadastrado" });
            }
            return res.status(500).json({ error: "Erro interno do servidor" });
        }
    }

    async login(req, res) {
        try {
            const { email, senha } = req.body;
            if (!email || !senha) {
                return res.status(400).json({ error: 'Os campos são requeridos' });
            }

            const usuario = await Usuario.findOne({ where: { email } });
            if (!usuario) {
                return res.status(400).json({ error: 'Usuário não encontrado' });
            }

            // Aqui você deveria verificar a senha
            const senhaValida = await tokens.descripitar(senha, usuario.senha);
            if (!senhaValida) {
                return res.status(401).json({ error: 'Senha incorreta' });
            }

            // Gerar access token
            const access_token = await tokens.gerar_access({ id: usuario.id, email: usuario.email });
            const refresh_token = await tokens.gerar_refresh_token();

            const hash_token = hashUser.encripitar(refresh_token);

            usuario.refresh_token = hash_token;
            await usuario.save();

            // Retornar token para o frontend
            return res.status(201).json({
                message: 'Login realizado com sucesso',
                access_token,
                refresh_token: refresh_token
            });

        } catch (error) {
            console.error(error);
            return res.status(500).json({ error: 'Erro no servidor' });
        }
    }

    async update(req, res) {
        //console.log('Body recebido:', req.body);
        try {
            const usuario = await Usuario.findByPk(req.params.id);

            if (!usuario) {
                return res.status(404).json({ error: 'Usuário não encontrado' });
            }

            Object.assign(usuario, req.body);

            await usuario.save();

            res.json(usuario);
        } catch (err) {
            res.status(500).json({ error: 'Erro ao atualizar usuário' });
        }
    }
    async destroy(req, res) {
        try {
            const id = req.body.id;
            const usuario = await Usuario.findByPk(id);
            if (!usuario) {
                console.log('Usuário não encontrado');
                return res.json({ 'message': 'Usuário não encontrado' })
            }
            await usuario.destroy();

            return res.json('Usuário apagado');
        } catch (error) {
            console.error(error);
            return res.status(500).json({ error: "Erro interno do servidor" });
        }
    }
}

module.exports = new UsuarioController();