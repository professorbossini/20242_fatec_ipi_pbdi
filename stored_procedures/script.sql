-- Active: 1724757618200@@127.0.0.1@5432@20242_fatec_ipi_pbdi_rodrigo@public

DROP TABLE IF EXISTS tb_cliente;
CREATE TABLE tb_cliente(
  cod_cliente SERIAL PRIMARY KEY,
  nome VARCHAR(200) NOT NULL
);

DROP TABLE IF EXISTS tb_pedido;
CREATE TABLE IF NOT EXISTS tb_pedido(
  cod_pedido SERIAL PRIMARY KEY,
  data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  data_modificacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR DEFAULT 'aberto',
  cod_cliente INT NOT NULL,
  CONSTRAINT fk_cliente FOREIGN KEY (cod_cliente) REFERENCES tb_cliente(cod_cliente)
);







-- CALL sp_calcula_media(1);
-- CALL sp_calcula_media(1, 2, 4, 5, 43);

-- CALL sp_calcula_media(ARRAY[1, 2]);


-- CREATE OR REPLACE PROCEDURE sp_calcula_media
--   (VARIADIC p_valores INT [])
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--  v_media NUMERIC(10, 2) := 0;
--  v_valor INT;
-- BEGIN
--   FOREACH v_valor IN ARRAY p_valores LOOP
--     v_media := v_media + v_valor;
--   END LOOP;
--   RAISE NOTICE 'A média é %', v_media / array_length(p_valores, 1);
-- END;
-- $$;

-- DO $$
-- DECLARE
--   v_valor1 INT := 2;
--   v_valor2 INT := 3;
-- BEGIN
--   CALL sp_acha_maior(v_valor1, v_valor2);
--   RAISE NOTICE '% é o maior', v_valor1;
-- END;
-- $$;

-- CREATE OR REPLACE PROCEDURE 
--   sp_acha_maior(INOUT p_valor1 INT, IN p_valor2 INT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   IF p_valor2 > p_valor1 THEN
--     p_valor1 := p_valor2;
--   END IF;
-- END;
-- $$


-- DROP PROCEDURE IF EXISTS sp_acha_maior;





--declarar um bloquinho anônimo
-- DO $$
-- DECLARE
--   v_resultado INT;
-- BEGIN
--   CALL sp_acha_maior(v_resultado, 4, 3);
--   RAISE NOTICE '% é o maior', v_resultado;
-- END;
-- $$

-- DROP PROCEDURE IF EXISTS sp_acha_maior;
-- CREATE OR REPLACE PROCEDURE sp_acha_maior(OUT p_resultado INT, IN p_valor1 INT, IN p_valor2 INT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   CASE
--     WHEN p_valor1 > p_valor2 THEN
--       p_resultado := p_valor1;
--     ELSE
--       $1 := p_valor2;
--   END CASE;
-- END;
-- $$



-- CALL sp_acha_maior(2, 3);
-- CREATE OR REPLACE PROCEDURE sp_acha_maior(IN p_valor1 INT, p_valor2 INT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   -- mostrar o maior usando parâmetros com nome e número, o primeiro com nome e o segundo com número
--   --não faça isso! (misturar número com nome)
--   CASE
--     WHEN p_valor1 > $2 THEN
--       RAISE NOTICE 'O primeiro (%) é maior', $1;
--     WHEN $1 < p_valor2 THEN
--       RAISE NOTICE 'O segundo (%) é maior', $2;
--     ELSE
--       RAISE NOTICE '% e % são iguais', $1, p_valor2;
--   END CASE;
-- END;
-- $$


-- class Pessoa:
--   def __init__(self, idade):
--     self.idade = idade

-- p = Pessoa(18)

-- def fazAniversario(p):
--   p.idade = p.idade + 1

-- fazAniversario(p)

-- print(p.idade)


-- idade = 18
-- def f(idade):
--   idade = idade + 1
-- f(idade)
-- print(idade)




-- CALL sp_ola_usuario('Pedro');

-- CREATE OR REPLACE PROCEDURE sp_ola_usuario(p_nome VARCHAR(200))
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   --neste caso, p_nome e $1 referem-se ao primeiro e único parâmetro
--   RAISE NOTICE 'Olá, %', p_nome;
--   RAISE NOTICE 'Olá, %', $1;
-- END;
-- $$


-- CALL sp_ola_procedures();

-- CREATE OR REPLACE PROCEDURE sp_ola_procedures()
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   RAISE NOTICE 'Olá, procedures';
-- END;
-- $$