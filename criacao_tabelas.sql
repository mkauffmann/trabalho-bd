create database bd_trabalho;
use bd_trabalho;

/*
 * 01 - TABELA UF 
 */

create table tb_uf
(
codigo_uf tinyint not null,
sigla_uf varchar(2) not null,
primary key (codigo_uf),
unique key (sigla_uf)
);



/*
 * 02 - TABELA CIDADE
 */

create table tb_cidade 
(
codigo_cidade int not null,
nome_cidade varchar(60) not null,
primary key (codigo_cidade),
unique key (nome_cidade)
);


/* 03 - TABELA ENDERECO */

create table tb_endereco
(
codigo_endereco int not null,
logradouro varchar(150) not null,
numero smallint not null,
complemento varchar(50) null,
cep varchar(9) not null,
codigo_cidade int not null,
codigo_uf tinyint not null,
primary key (codigo_endereco),
foreign key (codigo_cidade) references tb_cidade (codigo_cidade),
foreign key (codigo_uf) references tb_uf (codigo_uf)
);


/* 04 - TABELA DDD */

create table tb_ddd
(
codigo_ddd smallint not null,
ddd varchar(3) not null,
primary key (codigo_ddd),
unique key (ddd)
);


/*05 - TABELA DDI */

create table tb_ddi
(
codigo_ddi smallint not null,
ddi varchar(4) not null,
primary key (codigo_ddi),
unique key (ddi)
);

/* 06 - TABELA TELEFONE */

create table tb_telefone
(
codigo_telefone int not null,
codigo_ddi smallint not null,
codigo_ddd smallint not null,
telefone varchar(9) not null,
flag_whatsapp bit not null,
primary key (codigo_telefone),
foreign key (codigo_ddi) references tb_ddi (codigo_ddi),
foreign key (codigo_ddd) references tb_ddd (codigo_ddd)
);

/* 07 - TABELA CLIENTE */

create table tb_cliente
(
codigo_cliente int not null,
nome_cliente varchar(120) not null,
email varchar(100) not null,
primary key (codigo_cliente),
unique key (email)
);


/* 08 - TABELA CLIENTE_TELEFONE */

create table tb_cliente_telefone
(
codigo_cliente int not null,
codigo_telefone int not null,
descricao_telefone varchar(20) null,
primary key (codigo_cliente, codigo_telefone),
foreign key (codigo_cliente) references tb_cliente (codigo_cliente),
foreign key (codigo_telefone) references tb_telefone (codigo_telefone)
);

/* 09 - TABELA CLIENTE_ENDERECO */

create table tb_cliente_endereco
(
codigo_cliente int not null,
codigo_endereco int not null,
descricao_endereco varchar(20) null,
primary key (codigo_cliente, codigo_endereco),
foreign key (codigo_cliente) references tb_cliente (codigo_cliente),
foreign key (codigo_endereco) references tb_endereco (codigo_endereco)
);

/* 10 - TABELA GENERO */

create table tb_genero
(
codigo_genero tinyint not null,
descricao_genero varchar(20) not null,
primary key (codigo_genero),
unique key (descricao_genero)
);

/* 11 - TABELA PAIS */

create table tb_pais
(
codigo_pais smallint not null,
nome_pais varchar(50) not null,
primary key (codigo_pais),
unique key (nome_pais)
);

/* 12 - TABELA TIPO_DOCUMENTO */

create table tb_tipo_documento
(
codigo_tipo_documento smallint not null,
descricao_tipo_documento varchar(50) not null,
primary key (codigo_tipo_documento)
);

/* 13 - TABELA CLIENTE_PESSOA_FISICA */

create table tb_cliente_pessoa_fisica
(
codigo_cliente int not null,
data_nascimento date not null,
codigo_genero tinyint null,
primary key (codigo_cliente),
foreign key (codigo_cliente) references tb_cliente (codigo_cliente),
foreign key (codigo_genero) references tb_genero (codigo_genero)
);

/* 14 - TABELA DOCUMENTO_PESSOA_FISICA_BRASILEIRA	*/

create table tb_documento_pessoa_fisica_brasileira
(
codigo_cliente int not null,
cpf varchar(15) not null,
primary key (codigo_cliente),
unique key (cpf),
foreign key (codigo_cliente) references tb_cliente (codigo_cliente)
);


/* 15 - TABELA DOCUMENTO_PESSOA_FISICA_ESTRANGEIRA */

create table tb_documento_pessoa_fisica_estrangeira
(
codigo_cliente int not null,
codigo_tipo_documento smallint not null,
numero_documento varchar(30) not null,
codigo_pais_emissor smallint not null,
primary key (codigo_cliente),
foreign key (codigo_cliente) references tb_cliente (codigo_cliente),
foreign key (codigo_tipo_documento) references tb_tipo_documento (codigo_tipo_documento),
foreign key (codigo_pais_emissor) references tb_pais (codigo_pais)
);

/* 16 - TABELA CLIENTE_PESSOA_JURIDICA */

create table tb_cliente_pessoa_juridica
(
codigo_cliente int not null,
cnpj varchar(20) not null,
inscricao_estadual varchar(15) not null,
primary key (codigo_cliente),
foreign key (codigo_cliente) references tb_cliente (codigo_cliente),
unique key (cnpj)
);

/* 17 - TABELA FILIAL */

create table tb_filial
(
codigo_filial int not null,
cnpj varchar(20) not null,
nome_filial varchar(50) not null,
codigo_endereco int not null,
flag_eh_24_horas bit not null,
hora_abertura time null,
hora_fechamento time null,
primary key (codigo_filial),
foreign key (codigo_endereco) references tb_endereco (codigo_endereco),
unique key (cnpj)
);

/* 18 - TABELA TELEFONE_FILIAL */

create table tb_telefone_filial
(
codigo_filial int not null,
codigo_telefone int not null,
primary key (codigo_filial, codigo_telefone),
foreign key (codigo_filial) references tb_filial (codigo_filial),
foreign key (codigo_telefone) references tb_telefone (codigo_telefone)
);

/* 19 - TABELA CATEGORIA */

create table tb_categoria
(
codigo_categoria smallint not null,
descricao_categoria varchar(50) not null,
primary key (codigo_categoria),
unique key (descricao_categoria)
);

/* 20 - TABELA PRODUTO */

create table tb_produto 
(
codigo_produto int not null,
descricao_produto varchar(150) not null,
codigo_categoria smallint not null,
marca varchar(50) null,
composicao varchar(500) null,
primary key (codigo_produto),
foreign key (codigo_categoria) references tb_categoria (codigo_categoria),
unique key (descricao_produto)
);

/* 21 - TABELA PRECO_VENDA */

create table tb_preco_venda
(
codigo_produto int not null,
codigo_filial int not null,
valor_preco decimal(8,2) not null,
primary key (codigo_produto, codigo_filial),
foreign key (codigo_produto) references tb_produto (codigo_produto),
foreign key (codigo_filial) references tb_filial (codigo_filial)
);

/* 22 - TABELA ITEM */

create table tb_item
(
codigo_item int not null,
codigo_produto int not null,
quantidade_produto smallint not null,
valor_unitario decimal(6,2) not null,
valor_desconto decimal(6,2) not null,
valor_total decimal(6,2) not null,
primary key (codigo_item),
foreign key (codigo_produto) references tb_produto (codigo_produto)
);

/* 23 - TABELA STATUS_DO_PEDIDO */

create table tb_status_do_pedido
(
codigo_status_do_pedido tinyint not null,
descricao_status varchar(50) not null,
primary key (codigo_status_do_pedido),
unique key (descricao_status)
);

/* 24 - TABELA PEDIDO */

create table tb_pedido
(
codigo_pedido int not null,
codigo_status_do_pedido tinyint null,
data_compra date not null,
data_entrega date null,
valor_total decimal(6,2) not null,
primary key (codigo_pedido),
foreign key (codigo_status_do_pedido) references tb_status_do_pedido (codigo_status_do_pedido)
);

/* 25 - TABELA CLIENTE_PEDIDO */

create table tb_cliente_pedido
(
codigo_cliente int not null,
codigo_pedido int not null,
primary key (codigo_cliente, codigo_pedido),
foreign key (codigo_cliente) references tb_cliente (codigo_cliente),
foreign key (codigo_pedido) references tb_pedido (codigo_pedido)
);

/* 26 - TABELA PEDIDO_ITENS */

create table tb_pedido_itens
(
codigo_pedido int not null,
codigo_item int not null,
primary key (codigo_pedido, codigo_item),
foreign key (codigo_pedido) references tb_pedido (codigo_pedido),
foreign key (codigo_item) references tb_item (codigo_item)
);

/* 27 - TABELA NOTA_FISCAL */

create table tb_nota_fiscal
(
nf int not null,
codigo_pedido int null,
chave_de_acesso varchar(44) not null,
serie int not null,
data_emissao date not null,
codigo_filial_emissora int null,
valor_total decimal(6,2) not null,
primary key (nf),
foreign key (codigo_pedido) references tb_pedido (codigo_pedido),
foreign key (codigo_filial_emissora) references tb_filial (codigo_filial)
);

/* 28 - TABELA NOTA_FISCAL_ITENS */

create table tb_nota_fiscal_itens
(
nf int not null,
codigo_item int not null,
percentual_icms decimal(8,4) not null,
valor_icms decimal(8,4) not null,
primary key (nf, codigo_item),
foreign key (nf) references tb_nota_fiscal (nf),
foreign key (codigo_item) references tb_item (codigo_item)
);

