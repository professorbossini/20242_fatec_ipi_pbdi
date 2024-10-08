-- Active: 1724757618200@@127.0.0.1@5432@20242_fatec_ipi_pbdi_rodrigo@public
DO $$
DECLARE
  -- 1. Declaração do cursor
  --não vinculado (unbound)
  --esse cursor exibe os nomes dos Youtubers, 1 a 1
  cur_nomes_youtubers REFCURSOR;
  v_youtuber VARCHAR(200);
BEGIN
  --2. Abertura do cursor
  OPEN cur_nomes_youtubers FOR SELECT youtuber FROM tb_top_youtubers;
  LOOP
    --3. Recuperação dos dados de interesse
    FETCH cur_nomes_youtubers INTO v_youtuber;
    EXIT WHEN NOT FOUND;
    RAISE NOTICE '%', v_youtuber;
  END LOOP;
  --4. Fechamento do cursor
  CLOSE cur_nomes_youtubers;

END;
$$



-- CREATE TABLE tb_top_youtubers(
--   cod_top_youtubers SERIAL PRIMARY KEY,
--   rank INT,
--   youtuber VARCHAR(200),
--   subscribers INT,
--   video_views INT,
--   video_count INT,
--   category VARCHAR(200),
--   started INT
-- );

-- -- em 10 minutos, resolva
-- -- encontre um campo apropriado para inteiros grandes
-- -- escreva um alter table trocando os inteiros para o tipo encontrado
-- ALTER TABLE tb_top_youtubers ALTER COLUMN video_views TYPE BIGINT;

-- SELECT * FROM tb_top_youtubers;