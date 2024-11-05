-- Active: 1724757618200@@127.0.0.1@5432@20242_fatec_ipi_pbdi_rodrigo@public
--cursor que faz update e delete e é capaz de subir
DO $$
DECLARE
  --1. Declaração do cursor
  cur_delete REFCURSOR;
  v_tupla RECORD;
BEGIN
  --2. Abertura do cursor
  OPEN cur_delete SCROLL FOR
    SELECT * FROM tb_top_youtubers;
  LOOP
    --3. Recuperação de dados
    FETCH cur_delete INTO v_tupla;
    EXIT WHEN NOT FOUND;
    IF v_tupla.video_count IS NULL THEN
      DELETE FROM tb_top_youtubers WHERE CURRENT OF cur_delete;
    END IF;
  END LOOP;

  LOOP
    FETCH BACKWARD FROM cur_delete INTO v_tupla;
    EXIT WHEN NOT FOUND;
    RAISE NOTICE '%', v_tupla;
  END LOOP;
  --4. Fechamento do cursor
END;
$$

--cursor que usa parâmetros nomeados e pela ordem
--nomes dos youtubers que começaram a partir de 2010 e que têm, pelo menos, 60M de subscribers
-- DO $$
-- DECLARE
--   v_ano INT := 2010;
--   v_inscritos INT := 60000000; --60M
--   v_youtuber VARCHAR(200);
--   --1. Declaração do cursor
--   cur_ano_inscritos CURSOR(ano INT, inscritos INT)
--     FOR SELECT youtuber FROM tb_top_youtubers 
--       WHERE started >= ano AND subscribers >= inscritos;
-- BEGIN
--   --2. Abertura do cursor
--   --há duas possibidades
--   --argumentos pela ordem
--   -- OPEN cur_ano_inscritos(v_ano, v_inscritos);
--   OPEN cur_ano_inscritos(inscritos := v_inscritos, ano := v_ano);
--   LOOP
--     --3. Recuperação de dados
--     FETCH cur_ano_inscritos INTO v_youtuber;
--     EXIT WHEN NOT FOUND;
--     RAISE NOTICE '%', v_youtuber;
--   END LOOP;
--   --4. Fechamento do cursor
--   CLOSE cur_ano_inscritos;
-- END;
-- $$


--cursor vinculado (bound)
--concatenar nome e número de inscritos
-- DO $$
-- DECLARE
--   --1. Declaração do cursor
--   cur_nomes_e_inscritos CURSOR FOR
--     SELECT youtuber, subscribers FROM tb_top_youtubers;
--     v_tupla RECORD;
--     v_resultado TEXT DEFAULT '';
-- BEGIN
--   --2. Abertura do cursor
--   OPEN cur_nomes_e_inscritos;
--   --3. Recuperação de dados
--   FETCH cur_nomes_e_inscritos INTO v_tupla;
--   WHILE FOUND LOOP
--     --nome:1000
--     v_resultado := v_resultado || v_tupla.youtuber || ':' || v_tupla.subscribers || ',';
--     --3. Recuperação de dados
--     FETCH cur_nomes_e_inscritos INTO v_tupla;
--   END LOOP;
--     --4. Fechamento do cursor
--     CLOSE cur_nomes_e_inscritos;
--     RAISE NOTICE '%', v_resultado;
-- END;
-- $$


-- cursor não vinculado com query dinâmica
-- exibe os nomes dos youtubers que começaram a partir de um ano específico
-- DO $$
-- DECLARE
--   --1. Declaração do cursor
--   cur_nomes_a_partir_de REFCURSOR;
--   v_youtuber VARCHAR(200);
--   v_ano INT := 2020;
--   v_nome_tabela VARCHAR(200) := 'tb_top_youtubers';
-- BEGIN
--   --2. Abertura do cursor
--   OPEN cur_nomes_a_partir_de FOR EXECUTE
--     format(
--       'SELECT youtuber FROM %s WHERE started >= $1',
--       v_nome_tabela
--     )USING v_ano;
--   --3. Recuperação de dados
--   LOOP
--     FETCH cur_nomes_a_partir_de INTO v_youtuber;
--     EXIT WHEN NOT FOUND;
--     RAISE NOTICE '%', v_youtuber;
--   END LOOP;
--   --4. Fechamento do cursor
--   CLOSE cur_nomes_a_partir_de;
-- END;
-- $$


-- DO $$
-- DECLARE
--   -- 1. Declaração do cursor
--   --não vinculado (unbound)
--   --esse cursor exibe os nomes dos Youtubers, 1 a 1
--   cur_nomes_youtubers REFCURSOR;
--   v_youtuber VARCHAR(200);
-- BEGIN
--   --2. Abertura do cursor
--   OPEN cur_nomes_youtubers FOR SELECT youtuber FROM tb_top_youtubers;
--   LOOP
--     --3. Recuperação dos dados de interesse
--     FETCH cur_nomes_youtubers INTO v_youtuber;
--     EXIT WHEN NOT FOUND;
--     RAISE NOTICE '%', v_youtuber;
--   END LOOP;
--   --4. Fechamento do cursor
--   CLOSE cur_nomes_youtubers;

-- END;
-- $$



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