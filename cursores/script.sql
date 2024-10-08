-- Active: 1724757618200@@127.0.0.1@5432@20242_fatec_ipi_pbdi_rodrigo@public
CREATE TABLE tb_top_youtubers(
  cod_top_youtubers SERIAL PRIMARY KEY,
  rank INT,
  youtuber VARCHAR(200),
  subscribers INT,
  video_views INT,
  video_count INT,
  category VARCHAR(200),
  started INT
);

-- em 10 minutos, resolva
-- encontre um campo apropriado para inteiros grandes
-- escreva um alter table trocando os inteiros para o tipo encontrado