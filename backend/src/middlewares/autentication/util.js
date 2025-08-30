const jwt = require('jsonwebtoken');
const crypto = require('crypto');
require('dotenv').config();

const tokens = {
    gerar_access: async (payload) => {
        const access_token = jwt.sign(payload, process.env.SECRET, { expiresIn: '10m' });
        return access_token;
    },
    verificar_access_token: async (token) => {
        try {
            const decoded = jwt.verify(token, process.env.SECRET);
            console.log(decoded); 
            return decoded;
        } catch (err) {
            console.error('Token inválido');
            return false;
        }
    },
    gerar_refresh_token: () =>{
        const refresh_token = crypto.randomBytes(32).toString('hex');
        return refresh_token;
    },
    verificar_refresh_token: (token, token_bd) =>{
        return token === token_bd;
    }
}

module.exports = tokens;