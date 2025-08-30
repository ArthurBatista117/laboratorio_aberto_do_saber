const bcrypt = require('bcrypt');

const hashUser = {
    encripitar: async (senha) => {
        const salt = 10;
        const hash = await bcrypt.hash(senha, salt);
        return hash;
    },

    descripitar: async (senha, hash) => {
        const promise = await bcrypt.compare(senha, hash);
        return promise;
    }

}

module.exports = hashUser;