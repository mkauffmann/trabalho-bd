const produtos = require('./produtos.json');
//console.log(produtos)

function gerarInsertProdutos(){
    
    produtos.forEach((produto) => {
        let {codigo, descricao, categoria, marca, composicao} = produto;
        console.log(`insert into tb_produtos (codigo_produto, descricao_produto, codigo_categoria_marca_composicao) values (${codigo}, '${descricao}', ${categoria}, ${marca != null ? "'" + marca + "'" : null}, ${composicao != null ? "'" + composicao + "'" : null })`)
    })
}

gerarInsertProdutos();