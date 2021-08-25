
/*
* Exercicio de SQL
*/

-- perguntas dos alunos

-- qual jogador com maior media de pontos por partida?
-- qual time tem o recorde de pontos em uma partida de uma temporada?
-- lista dos jogadores com idade par?
-- qual jogador com mais faltas na temporada?
-- qual jogo com mais público na temporada?
-- qual time venceu mais partidas como visitante na temporada?
-- qual time fez mais faltas na temporada e qual o jogador mais faltoso desse time?
-- lista dos jogadores mais idosos (os 10 mais)
-- qual jogador com maior média de 3 pts por partida
-- qual o time com mais derrotas na temporada?
-- qual jogador com mais rebotes ofensivos, rebotes defensivos, rebotes total?
-- qual jogador com mais tem lances tentados?
-- dentre os jogadores da posicao Shooting Guard, qual é o que mais lança?


-- perguntas do instrutor

-- quais os times que tem "Angeles" no nome?
-- um exemplo do comando LIKE
SELECT t.id_time, t.nm_time, t.sg_time 
FROM TB_TIME t
WHERE t.nm_time LIKE '%Angeles%'
;


-- quais os jogadores do Los Angeles Lakers na temporada 2020-2021?
-- exemplo de INNER JOIN com mais de 2 tabelas
select j.nm_jogador 
from TB_TIME t 
inner join TB_JOGADOR_TIME_TEMPORADA jtt on (jtt.id_time = t.id_time)
inner join TB_TEMPORADA tt on (tt.id_temporada = jtt.id_temporada)
inner join TB_JOGADOR j on (j.id_jogador = jtt.id_jogador)
where t.id_time = 14
  and tt.id_temporada = 1
;


-- quais os jogadores do Los Angeles Lakers e posições na temporada 2020-2021?
-- mais um exemplo de INNER JOIN entre mais de 2 tabelas
select j.nm_jogador, p.ds_posicao 
from TB_TIME t 
inner join TB_JOGADOR_TIME_TEMPORADA jtt on (jtt.id_time = t.id_time)
inner join TB_TEMPORADA tt on (tt.id_temporada = jtt.id_temporada)
inner join TB_JOGADOR j on (j.id_jogador = jtt.id_jogador)
inner join TB_POSICAO p on (p.id_posicao = j.id_posicao)
where t.id_time = 14
  and tt.id_temporada = 1
;


-- qual a quantidade de jogadores por posição, na temporada 2020-2021?
-- exemplo de GROUP BY 
select p.ds_posicao, count(j.id_jogador) 
from TB_TEMPORADA t
inner join TB_JOGADOR_TIME_TEMPORADA jtt on (jtt.id_temporada = t.id_temporada)
inner join TB_JOGADOR j on (j.id_jogador = jtt.id_jogador)
inner join TB_POSICAO p on (p.id_posicao = j.id_posicao)
where t.id_temporada = 1
group by p.ds_posicao
;


select str_to_date('25/8/2021', '%d/%m/%Y') ;


-- quais os jogos dentro de um período com maior pontuação combinada (jogos sem prorrogação)?
-- exemplo de ORDER BY e BETWEEN
select p.id_partida, 
       p.dt_partida, 
       p.hr_inicio_partida, 
       tl.nm_time, 
       p.nr_pontos_local, 
       tv.nm_time, 
       p.nr_pontos_visitante, 
       (p.nr_pontos_local + p.nr_pontos_visitante) as nr_pontos_combinados, 
       p.nr_prorrogacoes 
from TB_PARTIDA p 
inner join TB_TIME tl on (tl.id_time = p.id_time_local)
inner join TB_TIME tv on (tv.id_time = p.id_time_visitante)
where p.dt_partida between str_to_date('01/06/2020', '%d/%m/%Y') and str_to_date('31/07/2021', '%d/%m/%Y')
  and p.nr_prorrogacoes = 0
order by nr_pontos_combinados desc 
;

-- quais os jogos dentro de um período com menor pontuação combinada (jogos sem prorrogação)?
select p.id_partida, 
       p.dt_partida, 
       p.hr_inicio_partida, 
       tl.nm_time, 
       p.nr_pontos_local, 
       tv.nm_time, 
       p.nr_pontos_visitante, 
       (p.nr_pontos_local + p.nr_pontos_visitante) as nr_pontos_combinados, 
       p.nr_prorrogacoes 
from TB_PARTIDA p 
inner join TB_TIME tl on (tl.id_time = p.id_time_local)
inner join TB_TIME tv on (tv.id_time = p.id_time_visitante)
where p.dt_partida between str_to_date('01/06/2020', '%d/%m/%Y') and str_to_date('31/07/2021', '%d/%m/%Y')
  and p.nr_prorrogacoes = 0
order by nr_pontos_combinados, nr_pontos_local asc   
;


-- quais os jogadores acima da média nos seguintes quesitos: 
-- jogos, jogos como titular, % pts total, % 3 pts, % 2 pts, % lances livres, rebotes, assistencias, pts?
-- exemplo de SUB-SELECT
select j.id_jogador,
       j.nm_jogador,
       ej.nr_jogos,
       ej.nr_jogos_titular,
       ej.pc_lances_convertidos,
       ej.pc_3pts_convertidos,
       ej.pc_2pts_convertidos,
       ej.pc_lances_livres_convertidos,
       ej.nr_rebotes_total,
       ej.nr_assistencias,
       ej.nr_pontos 
from TB_JOGADOR j
inner join TB_ESTATISTICA_JOGADOR ej on (ej.id_jogador = j.id_jogador) 
inner join TB_TEMPORADA t on (t.id_temporada = ej.id_temporada)
inner join 
(
select t.id_temporada,
	   avg(ej.nr_jogos) as nr_jogos,
       avg(ej.nr_jogos_titular) as nr_jogos_titular,
       avg(ej.pc_lances_convertidos) as pc_lances_convertidos,
       avg(ej.pc_3pts_convertidos) as pc_3pts_convertidos,
       avg(ej.pc_2pts_convertidos) as pc_2pts_convertidos,
       avg(ej.pc_lances_livres_convertidos) as pc_lances_livres_convertidos,
       avg(ej.nr_rebotes_total) as nr_rebotes_total,
       avg(ej.nr_assistencias) as nr_assistencias,
       avg(ej.nr_pontos) as nr_pontos
from TB_JOGADOR j
inner join TB_ESTATISTICA_JOGADOR ej on (ej.id_jogador = j.id_jogador) 
inner join TB_TEMPORADA t on (t.id_temporada = ej.id_temporada)
group by t.id_temporada
) medias on (medias.id_temporada = t.id_temporada)
where t.id_temporada = 1
  and ej.nr_jogos >= medias.nr_jogos
  and ej.nr_jogos_titular >= medias.nr_jogos_titular
  and ej.pc_lances_convertidos >= medias.pc_lances_convertidos
  and ej.pc_3pts_convertidos >= medias.pc_3pts_convertidos
  and ej.pc_2pts_convertidos >= medias.pc_2pts_convertidos
  and ej.pc_lances_livres_convertidos >= medias.pc_lances_livres_convertidos
  and ej.nr_rebotes_total >= medias.nr_rebotes_total
  and ej.nr_assistencias >= medias.nr_assistencias
  and ej.nr_pontos >= medias.nr_pontos
;


-- quais os jogadores top 10 (em uma temporada) nos quesitos: total de pontos, pontos de 3, assistencias e total de rebotes ?
-- exemplo de UNION (e do LIMIT) e mais um exemplo de SUB-SELECT
select 'pontos' as quesito, 
       nm_jogador as jogador, 
       nr_pontos as valor
from 
(
select j.nm_jogador as nm_jogador, 
       ej.nr_pontos as nr_pontos 
from TB_ESTATISTICA_JOGADOR ej
inner join TB_TEMPORADA t on (t.id_temporada = ej.id_temporada)
inner join TB_JOGADOR j on (j.id_jogador = ej.id_jogador)
where t.id_temporada = 1
order by ej.nr_pontos desc
limit 10
) pontos
union
select 'pontos_3', nm_jogador, nr_3pts_convertidos
from 
(
select j.nm_jogador as nm_jogador, 
       ej.nr_3pts_convertidos as nr_3pts_convertidos
from TB_ESTATISTICA_JOGADOR ej
inner join TB_TEMPORADA t on (t.id_temporada = ej.id_temporada)
inner join TB_JOGADOR j on (j.id_jogador = ej.id_jogador)
where t.id_temporada = 1
order by ej.nr_3pts_convertidos desc
limit 10
) pontos_de_3
union
select 'assistencias', nm_jogador, nr_assistencias
from 
(
select j.nm_jogador as nm_jogador, 
       ej.nr_assistencias as nr_assistencias
from TB_ESTATISTICA_JOGADOR ej
inner join TB_TEMPORADA t on (t.id_temporada = ej.id_temporada)
inner join TB_JOGADOR j on (j.id_jogador = ej.id_jogador)
where t.id_temporada = 1
order by ej.nr_assistencias desc
limit 10
) assistencias
union
select 'rebotes', nm_jogador, nr_rebotes_total
from
(
select j.nm_jogador as nm_jogador, 
       ej.nr_rebotes_total as nr_rebotes_total
from TB_ESTATISTICA_JOGADOR ej
inner join TB_TEMPORADA t on (t.id_temporada = ej.id_temporada)
inner join TB_JOGADOR j on (j.id_jogador = ej.id_jogador)
where t.id_temporada = 1
order by ej.nr_rebotes_total desc
limit 10
) rebotes
;


