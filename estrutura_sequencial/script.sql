-- Active: 1724757618200@@127.0.0.1@5432@20242_fatec_ipi_pbdi_rodrigo@public

DO
$$
DECLARE
  n1 NUMERIC(10, 2);
  n2 INTEGER;
  limite_inferior INTEGER := 1;
  limite_superior INTEGER := 1;
BEGIN
  -- 0 <= n1 < 1
  n1 := random();
  RAISE NOTICE '%', n1;
  n2 := floor(random() * 10 + 1)::int;
  RAISE NOTICE '%', n2;
  --[limite_inferior, limite_superior]
  n2:= limite_inferior + floor(random() * (limite_superior - limite_inferior + 1) )::int;
  RAISE NOTICE '%', n2;
END;
$$

-- DO
-- $$
-- DECLARE
--   codigo INTEGER := 1;
--   nome_completo VARCHAR(200) := 'João';
--   salario NUMERIC(7, 2) := 20.5;
-- BEGIN
--   RAISE NOTICE 'Meu código é %, me chamo % e meu salário é R$%', codigo,  nome_completo, salario;  
-- END;
-- $$



-- DO
-- $$
-- BEGIN
--   RAISE NOTICE '% + % = %', 2, 3, 2 + 3; 
-- END;
-- $$



-- DO
-- $$
-- BEGIN
--   RAISE NOTICE 'Meu primeiro bloquinho anônimo';
-- END;
-- $$


-- DO
-- $$
-- BEGIN
--     RAISE NOTICE 'Meu primeiro bloquinho anônimo';
-- END;
-- $$