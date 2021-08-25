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
nome_cidade varchar(20) not null,
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


