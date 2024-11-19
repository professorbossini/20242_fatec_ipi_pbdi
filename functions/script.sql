-- Active: 1731611308283@@localhost@5432@20242_fatec_ipi_pbdi_rodrigo@public

DO $$
DECLARE
  v_resultado BOOLEAN;
BEGIN
  SELECT fn_all('fn_ehPar', 1, 2, 3, 4, 5, 6) INTO v_resultado;
  RAISE NOTICE '%', v_resultado;
  SELECT fn_all('fn_ehPar', 2, 4, 6) INTO v_resultado;
  RAISE NOTICE '%', v_resultado;
END;
$$

-- CREATE OR REPLACE FUNCTION fn_all(
--   IN fn_funcao TEXT,
--   VARIADIC elementos INT []
-- ) RETURNS BOOLEAN
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--   v_elemento INT;
--   v_resultado BOOLEAN;
-- BEGIN
--   FOREACH v_elemento IN ARRAY elementos LOOP
--     EXECUTE format ('SELECT %s(%s)', fn_funcao, v_elemento) INTO v_resultado;
--     IF NOT v_resultado THEN
--       RETURN FALSE;
--     END IF;  
--   END LOOP;
--   RETURN TRUE;
-- END;
-- $$;

-- DO $$
-- DECLARE
--   v_resultado BOOLEAN;
-- BEGIN
--   SELECT fn_some('fn_ehPar', 1, 2) INTO v_resultado;
--   RAISE NOTICE '%', v_resultado;
--   SELECT fn_some('fn_ehPar', 1, 3, 5) INTO v_resultado;
--   RAISE NOTICE '%', v_resultado;
-- END;
-- $$;


-- CREATE OR REPLACE FUNCTION fn_some(
--   IN fn_funcao TEXT, 
--   VARIADIC elementos INT []
-- ) RETURNS BOOLEAN
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--   v_elemento INT;
--   v_resultado BOOLEAN;
-- BEGIN
--   FOREACH v_elemento IN ARRAY elementos LOOP
--     EXECUTE format('SELECT %s (%s)', fn_funcao, v_elemento) INTO v_resultado;
--     IF v_resultado = TRUE THEN
--       RETURN TRUE;
--     END IF;
--   END LOOP;
--   RETURN FALSE;
-- END;
-- $$;
--escrever uma função que recebe um valor inteiro e responde se ele
-- é par
-- SELECT fn_executa('fn_ehPar', 2);
-- CREATE OR REPLACE FUNCTION fn_ehPar(IN n INT) RETURNS BOOLEAN
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   RETURN n % 2 = 0;
-- END;
-- $$;


-- CREATE OR REPLACE FUNCTION fn_executa(
--   IN fn_nomeFuncaoAExecutar TEXT,
--   IN n INT
-- ) RETURNS BOOLEAN 
-- LANGUAGE plpgsql AS $$
-- DECLARE
--   v_resultado BOOLEAN;
-- BEGIN
--   EXECUTE 'SELECT ' || fn_nomeFuncaoAExecutar || '(' || n || ')'
--   INTO v_resultado;   
--   RETURN v_resultado;
-- END;
-- $$;




-- chamando functions usando um bloquinho anônimo
-- DO $$
-- DECLARE
--   v_resultado TEXT;
-- BEGIN
--   --não vale chamar funções com CALL
--   -- CALL fn_hello();
--   -- executa descartando
--   -- PERFORM fn_hello();
--   --guardando numa variável
--   --v_resultado := fn_hello();
--   --RAISE NOTICE '%', v_resultado;
--   --fazendo um select into
--   SELECT fn_hello() INTO v_resultado;
--   RAISE NOTICE '%', v_resultado;
-- END;
-- $$;


-- CREATE FUNCTION fn_hello() RETURNS TEXT
-- LANGUAGE plpgsql AS $$
-- BEGIN
--   RETURN 'Hello, functions';
-- END;
-- $$;

-- SELECT fn_hello();