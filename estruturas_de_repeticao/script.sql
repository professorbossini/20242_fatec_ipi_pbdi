-- Active: 1724757618200@@127.0.0.1@5432@20242_fatec_ipi_pbdi_rodrigo@public
DO
$$
DECLARE
  a INT := valor_aleatorio_entre(0, 5);
BEGIN
  IF a = 0 THEN
    RAISE  EXCEPTION 'a não pode ser zero';
  ELSE
    RAISE NOTICE 'Valor de a: %', a;
  END IF;
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Exceção: % %', SQLSTATE, SQLERRM;
END;
$$


-- DO $$
-- BEGIN
--   RAISE NOTICE 'Começou....';
--   RAISE NOTICE '%', 1 / 0;
--   RAISE NOTICE 'Depois da tentativa de divisão';
-- EXCEPTION
--   WHEN division_by_zero THEN
--     RAISE NOTICE 'Não é possível fazer divisão por zero';
-- END;
-- $$


--FOREACH/SLICE(fatia)
-- DO $$
-- DECLARE
--   vetor INT[] := ARRAY[1, 2, 3];
--   matriz INT[] := ARRAY[
--     [1, 2, 3],
--     [4, 5, 6],
--     [7, 8, 9]
--   ];
--   var_aux INT;
--   vet_aux INT[];
-- BEGIN
--   RAISE NOTICE 'Sem slice, com vetor';
--   FOREACH var_aux IN ARRAY vetor 
--   LOOP
--     RAISE NOTICE '%', var_aux;
--   END LOOP;
--   RAISE NOTICE '================================';
--   RAISE NOTICE 'Slice = 1, com vetor';
--   FOREACH vet_aux SLICE 1 IN ARRAY vetor LOOP
--     RAISE NOTICE '%', vet_aux;
--   END LOOP;
--   -- RAISE NOTICE '================================';
--   -- RAISE NOTICE 'Slice = 2, com vetor';
--   -- FOREACH vet_aux SLICE 2 IN ARRAY vetor LOOP
--   --   RAISE NOTICE '%', vet_aux;
--   -- END LOOP;
--   RAISE NOTICE '================================';
--   RAISE NOTICE 'Slice = 0, com matriz';
--   FOREACH var_aux IN ARRAY matriz LOOP
--     RAISE NOTICE '%', var_aux;
--   END LOOP;
--   RAISE NOTICE '================================';
--   RAISE NOTICE 'Slice = 1, com matriz';
--   FOREACH vet_aux SLICE 1 IN ARRAY matriz LOOP
--     RAISE NOTICE '%', vet_aux;
--   END LOOP;
--   RAISE NOTICE '================================';
--   RAISE NOTICE 'Slice = 2, com matriz';
--   FOREACH vet_aux SLICE 2 IN ARRAY matriz LOOP
--     RAISE NOTICE '%', vet_aux;
--   END LOOP;
-- END;
-- $$


-- --FOREACH sobre valores de um array (vetor, matriz, cubo)
-- DO $$
-- DECLARE
--   valores INT[] :=ARRAY[
--     valor_aleatorio_entre(1, 10),
--     valor_aleatorio_entre (1, 10),
--     valor_aleatorio_entre (1, 10),
--     valor_aleatorio_entre (1, 10),
--     valor_aleatorio_entre (1, 10)
--   ];
--   valor INT;
-- BEGIN
--   FOREACH valor IN ARRAY valores LOOP
--     RAISE NOTICE 'Valor da vez: %', valor;
--   END LOOP;
-- END;
-- $$


--iterando sobre os resultados de um SELECT
-- DO $$
-- DECLARE
--   aluno RECORD;
--   media NUMERIC(10, 2) := 0;
--   total INT;
-- BEGIN
--   FOR aluno IN
--     SELECT * FROM tb_aluno 
--   LOOP
--     RAISE NOTICE 'Aluno %', aluno;
--     RAISE NOTICE 'Código %', aluno.cod_aluno;
--     RAISE NOTICE 'Nota: %', aluno.nota;
--     media := media + aluno.nota;   
--   END LOOP;
--   SELECT COUNT(*) FROM tb_aluno INTO total;
--   RAISE NOTICE 'Média: %', media / total;
-- END;
-- $$




-- SELECT * FROM tb_aluno;


-- DO $$
-- BEGIN
--   FOR i IN 1..10 LOOP
--     INSERT INTO tb_aluno(nota) VALUES(valor_aleatorio_entre(0, 10));
--   END LOOP;
-- END;
-- $$


-- CREATE TABLE tb_aluno(
--   cod_aluno SERIAL PRIMARY KEY,
--   nota INT
-- );



--while e controle por sentinela
-- DO $$
-- BEGIN
--   FOR i IN 1..10 LOOP
--     RAISE NOTICE '%', i;
--   END LOOP;
--   RAISE NOTICE '==========================';
--   FOR i IN 10..1 LOOP
--     RAISE NOTICE '%', i;  
--   END LOOP;
--   RAISE NOTICE '==========================';
--   FOR i IN REVERSE 10..1 LOOP
--     RAISE NOTICE '%', i;  
--   END LOOP;
--   RAISE NOTICE '==========================';
--   FOR i IN 1..50 BY 2 LOOP
--     RAISE NOTICE '%', i;
--   END LOOP;
-- END;
-- $$


-- DO $$
-- DECLARE
--   nota INT;
--   media NUMERIC(10, 2) := 0;
--   contador INT := 0;
-- BEGIN
--   --desejo valores de -1 a 10
--   --valor_aleatorio_entre(n, m): [n, m]
--   SELECT valor_aleatorio_entre(0, 11) - 1 INTO nota;
--   WHILE nota >= 0 LOOP
--     RAISE NOTICE '%', nota;
--     media := media + nota;
--     contador := contador + 1;
--     SELECT valor_aleatorio_entre(0, 11) - 1 INTO nota;
--   END LOOP;
--   IF contador > 0 THEN
--     RAISE NOTICE 'Média: %', media / contador;
--   ELSE
--     RAISE NOTICE 'Nenhuma nota gerada';
--   END IF;
-- END;
-- $$
-- DO $$
-- DECLARE
--   i INT;
--   j INT;
-- BEGIN
--   i := 0;
--   <<externo>>
--   LOOP
--     i := i + 1;
--     EXIT WHEN i > 10;
--     j := 1;
--     <<interno>>
--     LOOP
--       RAISE NOTICE '% %', i, j;
--       j := j + 1;
--       EXIT WHEN j > 10;
--       CONTINUE externo WHEN j > 5;
--     END LOOP;
--   END LOOP;
-- END;
-- $$




--continue, rótulos e loops aninhados
-- DO $$
-- DECLARE
--   i INT;
--   j INT;
-- BEGIN
--   i := 0;
--   <<externo>>
--   LOOP
--     i := i + 1;
--     EXIT WHEN i > 10;
--     j := 1;
--     <<interno>>
--     LOOP
--       RAISE NOTICE '% %', i, j;
--       j := j + 1;
--       EXIT WHEN j > 10;
--       EXIT externo WHEN j > 5;
--     END LOOP;
--   END LOOP;
-- END;
-- $$



--repetição controlada por contador
--teste de continuidade com exit/when

--continue (ignorar iterações específicas de um loop)
-- DO $$
-- DECLARE
--   contador INT := 0;
-- BEGIN
--   LOOP
--     contador := contador + 1;
--     EXIT WHEN contador > 100;
--     --detectar múltiplos de 7
--     IF contador % 7 = 0 THEN
--       CONTINUE;
--     END IF;    

--     --detectar múltiplos de 11
--     CONTINUE WHEN contador % 11 = 0;

--     RAISE NOTICE '%', contador;

--   END LOOP;
-- END;
-- $$

-- DO $$
-- DECLARE
--   contador INT := 1;
-- BEGIN
--   LOOP
--     RAISE NOTICE '%', contador;
--     contador := contador + 1;
--     EXIT WHEN contador > 10;
--   END LOOP;
-- END;
-- $$

--repetição controlada por contador
-- DO $$
-- DECLARE
--   contador INT := 1;
-- BEGIN
--   LOOP
--     RAISE NOTICE '%', contador;
--     contador := contador + 1;
--     IF contador > 10 THEN
--       EXIT;
--     END IF;
--   END LOOP;
-- END;
-- $$


-- DO $$
-- BEGIN
--   LOOP
--     RAISE NOTICE 'Teste loop simples...';
--   END LOOP;
-- END;
-- $$