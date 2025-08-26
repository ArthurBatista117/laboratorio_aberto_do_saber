const bcrypt = require('bcrypt');

const hashUser = {
    encripitar: async (senha) => {
        const salt = 20;
        const hash = bcrypt.hash(senha, salt);
        return hash;
    },

    descripitar: async (senha, hash) => {
        const promise = bcrypt.compare(senha, hash);
        return promise;
    }

}

module.exports = hashUser;