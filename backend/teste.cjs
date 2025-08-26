const t = require('./src/middlewares/hash/hashUser');

async function name() {
    let senha = "1234";
    let r = await t.encripitar(senha);
    console.log(r);
    let j = await t.descripitar(senha, r);
    console.log(j);
}

name();