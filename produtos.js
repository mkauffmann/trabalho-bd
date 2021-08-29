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

//gerarItem(61, 100)


function gerarDataMes(mes){
    let dia = Math.floor(Math.random() * 29) + 1;
    return `'2021-${mes}-${dia}'`
}

//console.log(gerarDataMes(08))

function gerarItensPedido(codigoInicial, codigoFinal, numeroItens){
    for (let i = codigoInicial; i <= codigoFinal; i++){
        let qtdItens = Math.floor(Math.random() * 3) + 1;
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
        console.log(`insert into tb_pedido (codigo_pedido, codigo_status_do_pedido, data_compra, data_entrega, valor_total) values (${i}, ${Math.floor(Math.random() * 4) + 1}, '2021-09-${diaCompra}', '2021-09-${diaEntrega}', 0);`);
        gerarItensPedido(i, i, 100);
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

//gerarPedido(36,50)



function gerarNf(codigoInicial, codigoFinal){
    for(let i = codigoInicial; i<= codigoFinal; i++){
        let nf = Math.floor(Math.random() * (999999999 - 100000000)) + 100000000 ;

        let chave = `${Math.floor(Math.random() * (9999 - 1000)) + 1000} ${Math.floor(Math.random() * (9999 - 1000)) + 1000} ${Math.floor(Math.random() * (9999 - 1000)) + 1000} ${Math.floor(Math.random() * (9999 - 1000)) + 1000} ${Math.floor(Math.random() * (9999 - 1000)) + 1000} ${Math.floor(Math.random() * (9999 - 1000)) + 1000} ${Math.floor(Math.random() * (9999 - 1000)) + 1000} ${Math.floor(Math.random() * (9999 - 1000)) + 1000} ${Math.floor(Math.random() * (9999 - 1000)) + 1000} ${Math.floor(Math.random() * (9999 - 1000)) + 1000} `;

        let serie = Math.floor(Math.random() * (999 - 100)) + 100;

        

        let filiais = [null, null, null];

        let filial = filiais[Math.floor(Math.random() * (filiais.length - 1) + 1)]

        //let pedidos = [ 3];

        //let pedido = Math.floor(Math.random() * (50 - 1) + 1);
        let pedido = 'X'

        console.log(`insert into tb_nota_fiscal (nf, codigo_pedido, chave_de_acesso, serie, data_emissao, codigo_filial_emissora, valor_total) values
         (${nf}, ${filial == null ? pedido : null}, '${chave}', ${serie}, ${gerarDataMes(09)}, ${filial}, 0);
insert into tb_nota_fiscal_itens (nf, codigo_item, percentual_icms, valor_icms) values (${nf}, X, 0, 0);
update tb_nota_fiscal nf
	    set valor_total = 151.17
	    where nf.nf = ${nf};
        -- SELECT APAGAR
        select *
      from tb_nota_fiscal tnf 
      INNER JOIN TB_PEDIDO TP ON (TP.CODIGO_PEDIDO = tnf.CODIGO_PEDIDO)
      INNER JOIN TB_PEDIDO_ITENS TPI ON (TPI.CODIGO_PEDIDO = TP.CODIGO_PEDIDO)
      INNER JOIN tb_item i ON (i.CODIGO_ITEM = TPI.CODIGO_ITEM)
      where tnf.nf = ${nf}; 
      -- FIM SELECT\n`);
    }
}

gerarNf(1, 5)