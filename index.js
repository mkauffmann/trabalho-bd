let listaUF = ['AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO'];


let municipios = ["São Paulo", "São Bernardo do Campo", "Santo André", "Guarulhos", "Diadema", "São Caetano do Sul", "Barueri", "Franco da Rocha", "Santos", "Peruíbe", "São Vicente", "Guarujá", "Bertioga", "Cubatão", "Belo Horizonte", "Rio de Janeiro", "Vitória", "Curitiba", "Porto Alegre", "Florianópolis", "Cuiabá", "Campo Grande", "Goiânia", "Brasília", "Palmas", "Salvador", "Aracaju", "Recife", "Teresina", "Maceió", "João Pessoa", "São Luís", "Natal", "Fortaleza", "Manaus", "Belém", "Rio Branco", "Macapá", "Porto Velho", "Boa Vista"]

let ddd = [11, 12, 13, 14, 15, 16, 17, 18, 19, 21, 22, 24, 27, 28, 31, 32, 33, 34, 35, 37, 38, 41, 42, 43, 44, 45, 46, 47, 48, 49, 51, 53, 54, 55, 61, 62, 63, 64, 65, 66, 67, 68, 69, 71, 73, 74, 75, 77, 79, 81, 82, 83, 84, 85, 86, 87, 88, 89, 91, 92, 93, 94, 95, 96, 97, 98, 99]

let ddi = ['+49', '+54', '+55', '+1', '+33', '+81', '+595', '+44', '+598', '+58', '+244', '+52', '+27', '+56', '+57'];
let pais = ['Alemanha', 'Argentina', 'Brasil', 'EUA', 'França', 'Japão', 'Paraguai', 'Reino Unido', 'Uruguai', 'Venezuela', 'Angola', 'México', 'África do Sul', 'Chile', 'Colômbia'];

let tipoLogradouro = ['Rua', 'Rua', 'Rua', 'Rua', 'Rua', 'Av.', 'Av.','Av.', 'Largo', 'Praça', 'Via'];
let logradouro = ['Anchieta', 'das Rosas', 'Jabaquara', 'Senador Raul Cardoso', 'Gandavo', 'Capitão Macedo', 'Getulio Vargas', 'do Estado', 'Tiradentes', 'Ipiranga', 'Domingos de Moraes', 'Pedro Lessa', 'do Machado', 'Anhanguera', 'das Ortências', 'Guaraú', 'Napoleão de Barros', '13 de Outubro', '25 de Setembro', '11 de Junho', 'Santos Dumont', 'Santa Rita', 'das Flores', 'Pitangueiras', 'Rogério Duprat', 'Afonso Celso', 'Machado de Assis', 'Luiza Erundina', 'Arnaldo Baptista', 'Antônio Carlos', 'Tabatinguera', 'dos Buritis', 'das Araras', 'dos Pássaros', 'Araçá Azul', 'Refazenda', 'dos Remédios', 'Vital Brazil', 'Rebouças', 'Peruíbe', 'Oswaldo Aranha', 'Eça de Queiroz', 'Rubem Berta', 'Piauí', 'Bahia', 'Wally Salomão', '4 de Janeiro', '25 de Abril', '3 de Março', 'Mercedes Sosa']

let complemento = ['Ap.', 'Apartamento', 'Apto.', 'Bloco', 'Casa', null, null, null, null, null];



function criarInsert(nomeTb, arrValores, coluna1, coluna2){
    for (let i = 0; i < arrValores.length; i++){
        console.log(`insert into ${nomeTb} (${coluna1}, ${coluna2}) values (${i + 1},'${arrValores[i]}');`)
    };
};

function criarCelular(){
    let tel = Math.floor(Math.random() * (99999999 - 10000000) + 10000000);
    return '9' + tel.toString();
}
function criarTelFixo(){
    let tel = Math.floor(Math.random() * (99999999 - 10000000) + 10000000);
    return tel.toString();
}

function criarInsertCelularGringo(valorInicial, valorFinal){
    for (let i = valorInicial; i <= valorFinal; i++){
        console.log(`insert into tb_telefone (codigo_telefone, codigo_ddi, codigo_ddd, telefone, flag_whatsapp) values (${i}, ${Math.floor(Math.random() * (ddi.length) + 1)},  ${Math.floor(Math.random() * 67) + 1}, ${criarCelular()}, ${Math.floor(Math.random() * 2)});` );
    }
}

function criarInsertCelularBrasil(valorInicial, valorFinal){
    for (let i = valorInicial; i <= valorFinal; i++){
        console.log(`insert into tb_telefone (codigo_telefone, codigo_ddi, codigo_ddd, telefone, flag_whatsapp) values (${i}, 3, ${Math.floor(Math.random() * 67) + 1}, ${criarCelular()}, ${Math.floor(Math.random() * 2)});` );
    }
}

function criarInsertCelularSp(valorInicial, valorFinal){
    for (let i = valorInicial; i <= valorFinal; i++){
        console.log(`insert into tb_telefone (codigo_telefone, codigo_ddi, codigo_ddd, telefone, flag_whatsapp) values (${i}, 3, 1, ${criarCelular()}, ${Math.floor(Math.random() * 2)});` );
    }
}

function criarInsertFixoSp(valorInicial, valorFinal){
    for (let i = valorInicial; i <= valorFinal; i++){
        console.log(`insert into tb_telefone (codigo_telefone, codigo_ddi, codigo_ddd, telefone, flag_whatsapp) values (${i}, 3, 1, ${criarTelFixo()}, 0);` );
    }
}

function criarInsertFixoBr(valorInicial, valorFinal){
    for (let i = valorInicial; i <= valorFinal; i++){
        console.log(`insert into tb_telefone (codigo_telefone, codigo_ddi, codigo_ddd, telefone, flag_whatsapp) values (${i}, 3, ${Math.floor(Math.random() * 67) + 1}, ${criarTelFixo()}, 0);` );
    }
}

function gerarLogradouro(){
    return (tipoLogradouro[Math.floor(Math.random() * tipoLogradouro.length)] + " " + logradouro[Math.floor(Math.random() * logradouro.length)]).toUpperCase();
}

function gerarComplemento(){
    let comp = complemento[Math.floor(Math.random() * complemento.length)];
    if(comp != null){
        let compConcat = comp + " " + Math.floor(Math.random() * 50) + 1;
        return compConcat.toUpperCase()
    } else {
        return null;
    }
    
}

function gerarCep(){
    let primeiraParte = Math.floor(Math.random() * (99999 - 10000) + 10000 );
    let segundaParte = Math.floor(Math.random() * 999);
    return primeiraParte + '-' + segundaParte;
}

function criarInsertEndereco(valorInicial, valorFinal){
    for(let i = valorInicial; i <= valorFinal; i++){
        let complemento = gerarComplemento();

        console.log(`insert into tb_endereco 
        (codigo_endereco, logradouro, numero, complemento, cep, codigo_cidade, codigo_uf) values
        (${i}, '${gerarLogradouro()}', ${Math.floor(Math.random() * 5000) + 1}, ${complemento != null ? "'" + complemento + "'" : null }, '${gerarCep()}', ${Math.floor(Math.random() * municipios.length) + 1}, ${Math.floor(Math.random() * listaUF.length) + 1});`)
    }
}

function criarInsertEnderecoSP(valorInicial, valorFinal){
    for(let i = valorInicial; i <= valorFinal; i++){
        let complemento = gerarComplemento();

        console.log(`insert into tb_endereco 
        (codigo_endereco, logradouro, numero, complemento, cep, codigo_cidade, codigo_uf) values
        (${i}, '${gerarLogradouro()}', ${Math.floor(Math.random() * 5000) + 1}, ${complemento != null ? "'" + complemento + "'" : null }, '${gerarCep()}', ${Math.floor(Math.random() * 13) + 1}, 25);`)
    }
}

function criarInsertEnderecoSPCidade(valorInicial, valorFinal){
    for(let i = valorInicial; i <= valorFinal; i++){
        let complemento = gerarComplemento();

        console.log(`insert into tb_endereco 
        (codigo_endereco, logradouro, numero, complemento, cep, codigo_cidade, codigo_uf) values
        (${i}, '${gerarLogradouro()}', ${Math.floor(Math.random() * 5000) + 1}, ${complemento != null ? "'" + complemento + "'" : null }, '${gerarCep()}', 1, 25);`)
    }
}

criarInsertEnderecoSPCidade(51, 80);

//criarInsertEnderecoSP(11, 50);

//criarInsertFixoBr(81, 100);
//criarInsertCelularGringo(71, 80);
//criarInsertFixoSp(51, 70);
//criarInsertCelularSp(21, 50);
//criarInsertCelularBrasil(5, 20);
//criarInsert('tb_uf', listaUF, 'codigo_uf', 'sigla_uf');
//criarInsert('tb_cidade', municipios, 'codigo_cidade', 'nome_cidade');
//criarInsert('tb_ddd', ddd, 'codigo_ddd', 'ddd');
//criarInsert('tb_ddi', ddi, 'codigo_ddi', 'ddi');
//criarInsert('tb_pais', pais, 'codigo_pais', 'nome_pais');
