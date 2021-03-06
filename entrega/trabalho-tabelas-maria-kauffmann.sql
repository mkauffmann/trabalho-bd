CREATE DATABASE BD_TRABALHO;
USE BD_TRABALHO;

/*
 * 01 - TABELA UF 
 */

CREATE TABLE TB_UF
(
CODIGO_UF TINYINT NOT NULL,
SIGLA_UF VARCHAR(2) NOT NULL,
PRIMARY KEY (CODIGO_UF),
UNIQUE KEY (SIGLA_UF)
);



/*
 * 02 - TABELA CIDADE
 */

CREATE TABLE TB_CIDADE 
(
CODIGO_CIDADE INT NOT NULL,
NOME_CIDADE VARCHAR(60) NOT NULL,
PRIMARY KEY (CODIGO_CIDADE),
UNIQUE KEY (NOME_CIDADE)
);


/* 03 - TABELA ENDERECO */

CREATE TABLE TB_ENDERECO
(
CODIGO_ENDERECO INT NOT NULL,
LOGRADOURO VARCHAR(150) NOT NULL,
NUMERO SMALLINT NOT NULL,
COMPLEMENTO VARCHAR(50) NULL,
CEP VARCHAR(9) NOT NULL,
CODIGO_CIDADE INT NOT NULL,
CODIGO_UF TINYINT NOT NULL,
PRIMARY KEY (CODIGO_ENDERECO),
FOREIGN KEY (CODIGO_CIDADE) REFERENCES TB_CIDADE (CODIGO_CIDADE),
FOREIGN KEY (CODIGO_UF) REFERENCES TB_UF (CODIGO_UF)
);


/* 04 - TABELA DDD */

CREATE TABLE TB_DDD
(
CODIGO_DDD SMALLINT NOT NULL,
DDD VARCHAR(3) NOT NULL,
PRIMARY KEY (CODIGO_DDD),
UNIQUE KEY (DDD)
);


/*05 - TABELA DDI */

CREATE TABLE TB_DDI
(
CODIGO_DDI SMALLINT NOT NULL,
DDI VARCHAR(4) NOT NULL,
PRIMARY KEY (CODIGO_DDI),
UNIQUE KEY (DDI)
);

/* 06 - TABELA TELEFONE */

CREATE TABLE TB_TELEFONE
(
CODIGO_TELEFONE INT NOT NULL,
CODIGO_DDI SMALLINT NOT NULL,
CODIGO_DDD SMALLINT NOT NULL,
TELEFONE VARCHAR(9) NOT NULL,
FLAG_WHATSAPP BIT NOT NULL,
PRIMARY KEY (CODIGO_TELEFONE),
FOREIGN KEY (CODIGO_DDI) REFERENCES TB_DDI (CODIGO_DDI),
FOREIGN KEY (CODIGO_DDD) REFERENCES TB_DDD (CODIGO_DDD)
);

/* 07 - TABELA CLIENTE */

CREATE TABLE TB_CLIENTE
(
CODIGO_CLIENTE INT NOT NULL,
NOME_CLIENTE VARCHAR(120) NOT NULL,
EMAIL VARCHAR(100) NOT NULL,
PRIMARY KEY (CODIGO_CLIENTE),
UNIQUE KEY (EMAIL)
);


/* 08 - TABELA CLIENTE_TELEFONE */

CREATE TABLE TB_CLIENTE_TELEFONE
(
CODIGO_CLIENTE INT NOT NULL,
CODIGO_TELEFONE INT NOT NULL,
DESCRICAO_TELEFONE VARCHAR(20) NULL,
PRIMARY KEY (CODIGO_CLIENTE, CODIGO_TELEFONE),
FOREIGN KEY (CODIGO_CLIENTE) REFERENCES TB_CLIENTE (CODIGO_CLIENTE),
FOREIGN KEY (CODIGO_TELEFONE) REFERENCES TB_TELEFONE (CODIGO_TELEFONE)
);

/* 09 - TABELA CLIENTE_ENDERECO */

CREATE TABLE TB_CLIENTE_ENDERECO
(
CODIGO_CLIENTE INT NOT NULL,
CODIGO_ENDERECO INT NOT NULL,
DESCRICAO_ENDERECO VARCHAR(20) NULL,
PRIMARY KEY (CODIGO_CLIENTE, CODIGO_ENDERECO),
FOREIGN KEY (CODIGO_CLIENTE) REFERENCES TB_CLIENTE (CODIGO_CLIENTE),
FOREIGN KEY (CODIGO_ENDERECO) REFERENCES TB_ENDERECO (CODIGO_ENDERECO)
);

/* 10 - TABELA GENERO */

CREATE TABLE TB_GENERO
(
CODIGO_GENERO TINYINT NOT NULL,
DESCRICAO_GENERO VARCHAR(20) NOT NULL,
PRIMARY KEY (CODIGO_GENERO),
UNIQUE KEY (DESCRICAO_GENERO)
);

/* 11 - TABELA PAIS */

CREATE TABLE TB_PAIS
(
CODIGO_PAIS SMALLINT NOT NULL,
NOME_PAIS VARCHAR(50) NOT NULL,
PRIMARY KEY (CODIGO_PAIS),
UNIQUE KEY (NOME_PAIS)
);

/* 12 - TABELA TIPO_DOCUMENTO */

CREATE TABLE TB_TIPO_DOCUMENTO
(
CODIGO_TIPO_DOCUMENTO SMALLINT NOT NULL,
DESCRICAO_TIPO_DOCUMENTO VARCHAR(50) NOT NULL,
PRIMARY KEY (CODIGO_TIPO_DOCUMENTO)
);

/* 13 - TABELA CLIENTE_PESSOA_FISICA */

CREATE TABLE TB_CLIENTE_PESSOA_FISICA
(
CODIGO_CLIENTE INT NOT NULL,
DATA_NASCIMENTO DATE NOT NULL,
CODIGO_GENERO TINYINT NULL,
PRIMARY KEY (CODIGO_CLIENTE),
FOREIGN KEY (CODIGO_CLIENTE) REFERENCES TB_CLIENTE (CODIGO_CLIENTE),
FOREIGN KEY (CODIGO_GENERO) REFERENCES TB_GENERO (CODIGO_GENERO)
);

/* 14 - TABELA DOCUMENTO_PESSOA_FISICA_BRASILEIRA	*/

CREATE TABLE TB_DOCUMENTO_PESSOA_FISICA_BRASILEIRA
(
CODIGO_CLIENTE INT NOT NULL,
CPF VARCHAR(15) NOT NULL,
PRIMARY KEY (CODIGO_CLIENTE),
UNIQUE KEY (CPF),
FOREIGN KEY (CODIGO_CLIENTE) REFERENCES TB_CLIENTE (CODIGO_CLIENTE)
);


/* 15 - TABELA DOCUMENTO_PESSOA_FISICA_ESTRANGEIRA */

CREATE TABLE TB_DOCUMENTO_PESSOA_FISICA_ESTRANGEIRA
(
CODIGO_CLIENTE INT NOT NULL,
CODIGO_TIPO_DOCUMENTO SMALLINT NOT NULL,
NUMERO_DOCUMENTO VARCHAR(30) NOT NULL,
CODIGO_PAIS_EMISSOR SMALLINT NOT NULL,
PRIMARY KEY (CODIGO_CLIENTE),
FOREIGN KEY (CODIGO_CLIENTE) REFERENCES TB_CLIENTE (CODIGO_CLIENTE),
FOREIGN KEY (CODIGO_TIPO_DOCUMENTO) REFERENCES TB_TIPO_DOCUMENTO (CODIGO_TIPO_DOCUMENTO),
FOREIGN KEY (CODIGO_PAIS_EMISSOR) REFERENCES TB_PAIS (CODIGO_PAIS)
);

/* 16 - TABELA CLIENTE_PESSOA_JURIDICA */

CREATE TABLE TB_CLIENTE_PESSOA_JURIDICA
(
CODIGO_CLIENTE INT NOT NULL,
CNPJ VARCHAR(20) NOT NULL,
INSCRICAO_ESTADUAL VARCHAR(15) NOT NULL,
PRIMARY KEY (CODIGO_CLIENTE),
FOREIGN KEY (CODIGO_CLIENTE) REFERENCES TB_CLIENTE (CODIGO_CLIENTE),
UNIQUE KEY (CNPJ)
);

/* 17 - TABELA FILIAL */

CREATE TABLE TB_FILIAL
(
CODIGO_FILIAL INT NOT NULL,
CNPJ VARCHAR(20) NOT NULL,
NOME_FILIAL VARCHAR(50) NOT NULL,
CODIGO_ENDERECO INT NOT NULL,
FLAG_EH_24_HORAS BIT NOT NULL,
HORA_ABERTURA TIME NULL,
HORA_FECHAMENTO TIME NULL,
PRIMARY KEY (CODIGO_FILIAL),
FOREIGN KEY (CODIGO_ENDERECO) REFERENCES TB_ENDERECO (CODIGO_ENDERECO),
UNIQUE KEY (CNPJ)
);

/* 18 - TABELA TELEFONE_FILIAL */

CREATE TABLE TB_TELEFONE_FILIAL
(
CODIGO_FILIAL INT NOT NULL,
CODIGO_TELEFONE INT NOT NULL,
PRIMARY KEY (CODIGO_FILIAL, CODIGO_TELEFONE),
FOREIGN KEY (CODIGO_FILIAL) REFERENCES TB_FILIAL (CODIGO_FILIAL),
FOREIGN KEY (CODIGO_TELEFONE) REFERENCES TB_TELEFONE (CODIGO_TELEFONE)
);

/* 19 - TABELA CATEGORIA */

CREATE TABLE TB_CATEGORIA
(
CODIGO_CATEGORIA SMALLINT NOT NULL,
DESCRICAO_CATEGORIA VARCHAR(50) NOT NULL,
PRIMARY KEY (CODIGO_CATEGORIA),
UNIQUE KEY (DESCRICAO_CATEGORIA)
);

/* 20 - TABELA PRODUTO */

CREATE TABLE TB_PRODUTO 
(
CODIGO_PRODUTO INT NOT NULL,
DESCRICAO_PRODUTO VARCHAR(150) NOT NULL,
CODIGO_CATEGORIA SMALLINT NOT NULL,
MARCA VARCHAR(50) NULL,
COMPOSICAO VARCHAR(500) NULL,
PRIMARY KEY (CODIGO_PRODUTO),
FOREIGN KEY (CODIGO_CATEGORIA) REFERENCES TB_CATEGORIA (CODIGO_CATEGORIA),
UNIQUE KEY (DESCRICAO_PRODUTO)
);

/* 21 - TABELA PRECO_VENDA */

CREATE TABLE TB_PRECO_VENDA
(
CODIGO_PRODUTO INT NOT NULL,
CODIGO_FILIAL INT NOT NULL,
VALOR_PRECO DECIMAL(8,2) NOT NULL,
PRIMARY KEY (CODIGO_PRODUTO, CODIGO_FILIAL),
FOREIGN KEY (CODIGO_PRODUTO) REFERENCES TB_PRODUTO (CODIGO_PRODUTO),
FOREIGN KEY (CODIGO_FILIAL) REFERENCES TB_FILIAL (CODIGO_FILIAL)
);

/* 22 - TABELA ITEM */

CREATE TABLE TB_ITEM
(
CODIGO_ITEM INT NOT NULL,
CODIGO_PRODUTO INT NOT NULL,
QUANTIDADE_PRODUTO SMALLINT NOT NULL,
VALOR_UNITARIO DECIMAL(6,2) NOT NULL,
VALOR_DESCONTO DECIMAL(6,2) NOT NULL,
VALOR_TOTAL DECIMAL(6,2) NOT NULL,
PRIMARY KEY (CODIGO_ITEM),
FOREIGN KEY (CODIGO_PRODUTO) REFERENCES TB_PRODUTO (CODIGO_PRODUTO)
);

/* 23 - TABELA STATUS_DO_PEDIDO */

CREATE TABLE TB_STATUS_DO_PEDIDO
(
CODIGO_STATUS_DO_PEDIDO TINYINT NOT NULL,
DESCRICAO_STATUS VARCHAR(50) NOT NULL,
PRIMARY KEY (CODIGO_STATUS_DO_PEDIDO),
UNIQUE KEY (DESCRICAO_STATUS)
);

/* 24 - TABELA PEDIDO */

CREATE TABLE TB_PEDIDO
(
CODIGO_PEDIDO INT NOT NULL,
CODIGO_STATUS_DO_PEDIDO TINYINT NULL,
DATA_COMPRA DATE NOT NULL,
DATA_ENTREGA DATE NULL,
VALOR_TOTAL DECIMAL(6,2) NOT NULL,
PRIMARY KEY (CODIGO_PEDIDO),
FOREIGN KEY (CODIGO_STATUS_DO_PEDIDO) REFERENCES TB_STATUS_DO_PEDIDO (CODIGO_STATUS_DO_PEDIDO)
);

/* 25 - TABELA CLIENTE_PEDIDO */

CREATE TABLE TB_CLIENTE_PEDIDO
(
CODIGO_CLIENTE INT NOT NULL,
CODIGO_PEDIDO INT NOT NULL,
PRIMARY KEY (CODIGO_CLIENTE, CODIGO_PEDIDO),
FOREIGN KEY (CODIGO_CLIENTE) REFERENCES TB_CLIENTE (CODIGO_CLIENTE),
FOREIGN KEY (CODIGO_PEDIDO) REFERENCES TB_PEDIDO (CODIGO_PEDIDO)
);

/* 26 - TABELA PEDIDO_ITENS */

CREATE TABLE TB_PEDIDO_ITENS
(
CODIGO_PEDIDO INT NOT NULL,
CODIGO_ITEM INT NOT NULL,
PRIMARY KEY (CODIGO_PEDIDO, CODIGO_ITEM),
FOREIGN KEY (CODIGO_PEDIDO) REFERENCES TB_PEDIDO (CODIGO_PEDIDO),
FOREIGN KEY (CODIGO_ITEM) REFERENCES TB_ITEM (CODIGO_ITEM)
);

/* 27 - TABELA NOTA_FISCAL */

CREATE TABLE TB_NOTA_FISCAL
(
NF INT NOT NULL,
CODIGO_PEDIDO INT NULL,
CHAVE_DE_ACESSO VARCHAR(60) NOT NULL,
SERIE INT NOT NULL,
DATA_EMISSAO DATE NOT NULL,
CODIGO_FILIAL_EMISSORA INT NULL,
VALOR_TOTAL DECIMAL(6,2) NOT NULL,
PRIMARY KEY (NF),
FOREIGN KEY (CODIGO_PEDIDO) REFERENCES TB_PEDIDO (CODIGO_PEDIDO),
FOREIGN KEY (CODIGO_FILIAL_EMISSORA) REFERENCES TB_FILIAL (CODIGO_FILIAL)
);

/* 28 - TABELA NOTA_FISCAL_ITENS */

CREATE TABLE TB_NOTA_FISCAL_ITENS
(
NF INT NOT NULL,
CODIGO_ITEM INT NOT NULL,
PERCENTUAL_ICMS DECIMAL(8,4) NOT NULL,
VALOR_ICMS DECIMAL(8,4) NOT NULL,
PRIMARY KEY (NF, CODIGO_ITEM),
FOREIGN KEY (NF) REFERENCES TB_NOTA_FISCAL (NF),
FOREIGN KEY (CODIGO_ITEM) REFERENCES TB_ITEM (CODIGO_ITEM)
);

