-- Active: 1724757618200@@127.0.0.1@5432@20242_fatec_ipi_pbdi_rodrigo@public

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