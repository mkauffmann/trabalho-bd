
/* Tabela Temporada */
create table TB_TEMPORADA
(
    id_temporada INT NOT NULL PRIMARY KEY,
    ds_temporada VARCHAR(50) NOT NULL,
    sg_temporada VARCHAR(10) NOT NULL
);


/* Tabela Time */
create table TB_TIME
(
    id_time INT NOT NULL PRIMARY KEY,
    nm_time VARCHAR(100) NOT NULL,
    sg_time CHAR(3) NOT NULL
);


/* Tabela Posição do Jogador*/
create table TB_POSICAO
(
    id_posicao INT NOT NULL PRIMARY KEY,
    ds_posicao VARCHAR(50) NOT NULL,
    sg_posicao VARCHAR(5) NOT NULL
);


/* Tabela Jogador */
create table TB_JOGADOR
(
    id_jogador INT NOT NULL,
    nm_jogador VARCHAR(100) NOT NULL,
    sg_jogador VARCHAR(9) NOT NULL,
    id_posicao INT NOT NULL,
    nr_idade INT NULL,
    PRIMARY KEY (id_jogador),
    FOREIGN KEY (id_posicao) REFERENCES TB_POSICAO (id_posicao)
);


/* Relacionamento Jogador-Time-Temporada*/
create table TB_JOGADOR_TIME_TEMPORADA
(
    id_jogador INT NOT NULL,
    id_time INT NOT NULL,
    id_temporada INT NOT NULL,
    PRIMARY KEY (id_jogador, id_time, id_temporada),
    FOREIGN KEY (id_jogador) REFERENCES TB_JOGADOR (id_jogador),
    FOREIGN KEY (id_time) REFERENCES TB_TIME (id_time),
    FOREIGN KEY (id_temporada) REFERENCES TB_TEMPORADA (id_temporada)
);



/* Tabela Partida */
create table TB_PARTIDA
(
    id_partida INT NOT NULL,
    dt_partida DATE NOT NULL,
    hr_inicio_partida TIME NOT NULL,
    id_time_visitante INT NOT NULL,
    nr_pontos_visitante INT NOT NULL,
    id_time_local INT NOT NULL,
    nr_pontos_local INT NOT NULL,
    nr_prorrogacoes INT NULL,
    nr_publico INT NULL,
    PRIMARY KEY (id_partida),
    FOREIGN KEY (id_time_visitante) REFERENCES TB_TIME (id_time),
    FOREIGN KEY (id_time_local) REFERENCES TB_TIME (id_time)
);



/* Tabela Estatísticas dos Times */

create table TB_ESTATISTICA_TIME
(
    id_time INT NOT NULL,
    id_temporada INT NOT NULL,
    nr_jogos INT NULL,
    nr_minutos_jogados_tot INT NULL,
    nr_lances_convertidos_tot INT NULL,
    nr_lances_tentados_tot INT NULL,
    pc_lances_convertidos_tot DECIMAL(4,3) NULL,
    nr_3pts_convertidos_tot INT NULL,
    nr_3pts_tentados_tot INT NULL,
    pc_3pts_convertidos_tot DECIMAL(4,3) NULL,
    nr_2pts_convertidos_tot INT NULL,
    nr_2pts_tentados_tot INT NULL,
    pc_2pts_convertidos_tot DECIMAL(4,3) NULL,
    nr_lances_livres_convertidos_tot INT NULL,
    nr_lances_livres_tentatos_tot INT NULL,
    pc_lances_livres_convertidos_tot DECIMAL(4,3) NULL,
    nr_rebotes_ofensivos_tot INT NULL,
    nr_rebotes_defensivos_tot INT NULL,
    nr_rebotes_total_tot INT NULL,
    nr_assistencias_tot INT NULL,
    nr_roubadas_bola_tot INT NULL,
    nr_bloqueios_tot INT NULL,
    nr_bolas_perdidas_tot INT NULL,
    nr_faltas_pessoais_tot INT NULL,
    nr_pontos_tot INT NULL,
    nr_minutos_jogados_pj DECIMAL(12,3) NULL,
    nr_lances_convertidos_pj DECIMAL(12,3) NULL,
    nr_lances_tentados_pj DECIMAL(12,3) NULL,
    pc_lances_convertidos_pj DECIMAL(4,3) NULL,
    nr_3pts_convertidos_pj DECIMAL(12,3) NULL,
    nr_3pts_tentados_pj DECIMAL(12,3) NULL,
    pc_3pts_convertidos_pj DECIMAL(4,3) NULL,
    nr_2pts_convertidos_pj DECIMAL(12,3) NULL,
    nr_2pts_tentados_pj DECIMAL(12,3) NULL,
    pc_2pts_convertidos_pj DECIMAL(4,3) NULL,
    nr_lances_livres_convertidos_pj DECIMAL(12,3) NULL,
    nr_lances_livres_tentatos_pj DECIMAL(12,3) NULL,
    pc_lances_livres_convertidos_pj DECIMAL(4,3) NULL,
    nr_rebotes_ofensivos_pj DECIMAL(12,3) NULL,
    nr_rebotes_defensivos_pj DECIMAL(12,3) NULL,
    nr_rebotes_total_pj DECIMAL(12,3) NULL,
    nr_assistencias_pj DECIMAL(12,3) NULL,
    nr_roubadas_bola_pj DECIMAL(12,3) NULL,
    nr_bloqueios_pj DECIMAL(12,3) NULL,
    nr_bolas_perdidas_pj DECIMAL(12,3) NULL,
    nr_faltas_pessoais_pj DECIMAL(12,3) NULL,
    nr_pontos_pj DECIMAL(12,3) NULL,
    PRIMARY KEY (id_time, id_temporada),
    FOREIGN KEY (id_time) REFERENCES TB_TIME (id_time),
    FOREIGN KEY (id_temporada) REFERENCES TB_TEMPORADA (id_temporada)
);


/* Tabela Estatísticas dos Jogadores */
create table TB_ESTATISTICA_JOGADOR
(
    id_jogador INT NOT NULL,
    id_temporada INT NOT NULL,
    nr_jogos INT NULL,
    nr_jogos_titular INT NULL,
    nr_minutos_jogados INT NULL,
    nr_lances_convertidos INT NULL,
    nr_lances_tentados INT NULL,
    pc_lances_convertidos DECIMAL(4,3) NULL,
    nr_3pts_convertidos INT NULL,
    nr_3pts_tentados INT NULL,
    pc_3pts_convertidos DECIMAL(4,3) NULL,
    nr_2pts_convertidos INT NULL,
    nr_2pts_tentados INT NULL,
    pc_2pts_convertidos DECIMAL(4,3) NULL,
    pc_lances_convertidos_efetivos DECIMAL(4,3) NULL,
    nr_lances_livres_convertidos INT NULL,
    nr_lances_livres_tentados INT NULL,
    pc_lances_livres_convertidos DECIMAL(4,3) NULL,
    nr_rebotes_ofensivos INT NULL,
    nr_rebotes_defensivos INT NULL,
    nr_rebotes_total INT NULL,
    nr_assistencias INT NULL,
    nr_roubadas_bola INT NULL,
    nr_bloqueios INT NULL,
    nr_bolas_perdidas INT NULL,
    nr_faltas_pessoais INT NULL,
    nr_pontos INT NULL,
    PRIMARY KEY (id_jogador, id_temporada),
    FOREIGN KEY (id_jogador) REFERENCES TB_JOGADOR (id_jogador),
    FOREIGN KEY (id_temporada) REFERENCES TB_TEMPORADA (id_temporada)
);


show tables ;
