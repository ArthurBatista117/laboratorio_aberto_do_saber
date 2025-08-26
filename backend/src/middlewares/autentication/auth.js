const tokens = require('./util');

const autenticar = async (req, res, next) => {
    const authHeader = req.headers['authorization'];
    if (!authHeader) return res.status(401).json({ error: 'Token não fornecido' });

    const token = authHeader.split(' ')[1];
    if (!token) return res.status(401).json({ error: 'Token inválido' });

    const decoded = await tokens.verificar_access_token(token);
    if (!decoded) return res.status(403).json({ error: 'Token expirado ou inválido' });

    req.user = decoded; 
    next();
};

module.exports = autenticar;
