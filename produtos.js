const produtos = require('./produtos.json');
const itens = require('./itens.json');
//console.log(produtos)

function gerarInsertProdutos(){
    
    produtos.forEach((produto) => {
        let {codigo, descricao, categoria, marca, composicao} = produto;
        console.log(`insert into tb_produto (codigo_produto, descricao_produto, codigo_categoria, marca, composicao) values (${codigo}, '${descricao.toUpperCase()}', ${categoria}, ${marca != null ? "'" + marca.toUpperCase() + "'" : null}, ${composicao != null ? "'" + composicao.toUpperCase() + "'" : null });`)
    })
}

//gerarInsertProdutos();

function gerarPrecoFilial(){
    produtos.forEach((produto) => {
        let {codigo, valor_base} = produto;
        for (let i = 1; i <= 5; i++){
            let variacao = Math.floor(Math.random() * 10) / 100;
            console.log(`insert into tb_preco_venda (codigo_produto, codigo_filial, valor_preco) values (${codigo}, ${i}, ${(valor_base - (valor_base * variacao)).toFixed(2)});`)
        }
    })

}

//gerarPrecoFilial()

function gerarItem(codigoInicial, codigoFinal){
    let itens = [];
    for (let i = codigoInicial; i <= codigoFinal; i++){
        let codigoProduto = Math.floor(Math.random() * 49) + 1;
        let qtd = Math.floor(Math.random() * 11) + 1;
        let produto = produtos.find((prod) => prod.codigo == codigoProduto);
        let itemGerado = {
            codigoItem: i,
            qtd: qtd,
            totalItem: ((produto.valor_base - produto.desconto) * qtd).toFixed(2),
            ...produto
        };
        itens.push(itemGerado);
        console.log(`insert into tb_item (codigo_item, codigo_produto, quantidade_produto, valor_unitario, valor_desconto, valor_total) values (${i}, ${codigoProduto}, ${qtd}, ${produto.valor_base}, ${produto.desconto}, ${((produto.valor_base - produto.desconto) * qtd).toFixed(2)});`)
    }
    //console.log(JSON.stringify(itens))
}

//gerarItem(11, 60)


function gerarDataMes(mes){
    let dia = Math.floor(Math.random() * 29) + 1;
    return `'2021-${mes}-${dia}'`
}

//console.log(gerarDataMes(08))

function gerarItensPedido(codigoInicial, codigoFinal, numeroItens){
    for (let i = codigoInicial; i <= codigoFinal; i++){
        let qtdItens = Math.floor(Math.random() * 5) + 1;
        for (let f = 0; f < qtdItens; f++){
            let codigoItem = Math.floor(Math.random() * numeroItens - 1) + 2;
            console.log(`insert into tb_pedido_itens (codigo_pedido, codigo_item) values (${i}, ${codigoItem});`)
        }
    }
}

//gerarItensPedido(1, 10, 10);

function gerarPedido(codigoInicial, codigoFinal){
    for(let i = codigoInicial; i <= codigoFinal; i++){
        let diaCompra = Math.floor(Math.random() * 28) + 1;
        let diaEntrega = diaCompra + 2;
        console.log(`insert into tb_pedido (codigo_pedido, codigo_status_do_pedido, data_compra, data_entrega, valor_total) values (${i}, ${Math.floor(Math.random() * 4) + 1}, '2021-08-${diaCompra}', '2021-08-${diaEntrega}', 0);`);
        gerarItensPedido(i, i, 60);
        console.log(`update tb_pedido p 
        set valor_total = 0
        where p.codigo_pedido  = ${i};`)
        console.log(`-- SELECT APAGAR 
        select *
from tb_pedido tp 
inner join tb_pedido_itens tpi on (tpi.codigo_pedido = tp.codigo_pedido)
inner join tb_item i on (i.codigo_item = tpi.codigo_item)
inner join tb_status_do_pedido tsdp on (tp.codigo_status_do_pedido = tsdp.codigo_status_do_pedido)
where tp.codigo_pedido = ${i};
-- FIM SELECT \n`)
    }
}

gerarPedido(10,10)