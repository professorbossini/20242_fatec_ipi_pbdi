-- Active: 1731007942713@@127.0.0.1@5432@20242_fatec_ipi_pbdi_rodrigo@public

--14: escrever um proc que minimiza o número de notas a serem utilizadas para representar o troco

--calcular o valor de troco

DO $$
DECLARE
  v_troco INT;
  v_valor_total INT;
  v_valor_a_pagar INT := 100;
BEGIN
  CALL sp_calcular_valor_de_um_pedido(1, v_valor_total);
  CALL sp_calcular_troco(v_troco, v_valor_a_pagar, v_valor_total);
  RAISE NOTICE 'A conta foi de R$% e você pagou R$%. Portanto, seu troco é R$%.', v_valor_total, v_valor_a_pagar, v_troco;
END;
$$;
-- CREATE OR REPLACE PROCEDURE sp_calcular_troco(
--   OUT p_troco INT,
--   IN p_valor_a_pagar INT,
--   IN p_valor_total INT
-- ) LANGUAGE plpgsql AS $$
-- BEGIN
--   p_troco := p_valor_a_pagar - p_valor_total;
-- END;
-- $$;


--calcular valor total de um pedido
-- SELECT * FROM tb_pedido;

-- DO $$
-- BEGIN
--   CALL sp_fechar_pedido(200, 1);
-- END;
-- $$;


-- CREATE OR REPLACE PROCEDURE sp_fechar_pedido(
--   IN p_valor_a_pagar INT,
--   IN p_cod_pedido INT
-- ) LANGUAGE plpgsql AS $$
-- DECLARE
--   v_valor_total INT;
-- BEGIN
--   --vamos verificar se o valor a pagar é suficiente
--   CALL sp_calcular_valor_de_um_pedido(p_cod_pedido, v_valor_total);
--   IF p_valor_a_pagar < v_valor_total THEN
--     RAISE NOTICE 
--       'R$% insuficiente para pagar a conta de R$%', 
--       p_valor_a_pagar, v_valor_total;
--   ELSE
--     UPDATE tb_pedido SET
--       data_modificacao = CURRENT_TIMESTAMP,
--       status = 'fechado'
--       WHERE cod_pedido = $2;
--   END IF;
-- END;
-- $$;


-- DO $$
-- DECLARE
--   v_valor_total INT;
-- BEGIN
--   CALL sp_calcular_valor_de_um_pedido(1, v_valor_total);
--   RAISE NOTICE 'Total do pedido %: R$%.', 1, v_valor_total; 
-- END;
-- $$;

-- CREATE OR REPLACE PROCEDURE sp_calcular_valor_de_um_pedido(
--   IN p_cod_pedido INT,
--   OUT p_valor_total INT
-- ) LANGUAGE plpgsql AS $$
-- BEGIN
--   SELECT SUM(i.valor) FROM
--     tb_pedido p
--   INNER JOIN tb_item_pedido ip ON
--     p.cod_pedido = ip.cod_pedido
--   INNER JOIN tb_item i ON
--     ip.cod_item = i.cod_item
--   WHERE p.cod_pedido = p_cod_pedido
--   INTO p_valor_total;
-- END;
-- $$;


-- SELECT * FROM tb_pedido;
-- SELECT * FROM tb_item;

-- SELECT * FROM tb_item_pedido;
-- CALL sp_adicionar_item_a_pedido(1, 1);

--adicionar um item a um pedido
-- CREATE OR REPLACE PROCEDURE sp_adicionar_item_a_pedido(
--   IN p_cod_item INT,
--   IN p_cod_pedido INT
-- ) LANGUAGE plpgsql AS $$
-- BEGIN
--   --insere novo item
--   INSERT INTO tb_item_pedido (cod_item, cod_pedido) VALUES($1, $2);
--   --atualiza data de modificação do pedido
--   UPDATE tb_pedido p 
--     SET data_modificacao = CURRENT_TIMESTAMP
--       WHERE p.cod_pedido = p_cod_pedido;  
-- END;
-- $$;


-- DO $$
-- DECLARE
--   v_cod_pedido INT;
--   v_cod_cliente INT;
-- BEGIN
--   SELECT c.cod_cliente FROM tb_cliente c WHERE nome  LIKE 'João' INTO v_cod_cliente;
--   CALL sp_criar_pedido(v_cod_pedido, v_cod_cliente);
--   RAISE NOTICE 'Código do pedido recém criado: %', v_cod_pedido;
-- END;
-- $$;



--cadastro de novos pedidos
-- CREATE OR REPLACE PROCEDURE sp_criar_pedido(
--   OUT p_cod_pedido INT,
--   IN p_cod_cliente INT
-- ) LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   INSERT INTO tb_pedido(cod_cliente) VALUES (p_cod_cliente);
--   SELECT LASTVAL() INTO p_cod_pedido;
-- END;
-- $$;

--cadastro de cliente
-- CALL sp_cadastrar_cliente('João');
-- CALL sp_cadastrar_cliente('Maria');
-- SELECT * FROM tb_cliente;
--vamos usar um parâmetro com valor padrão
-- CREATE OR REPLACE PROCEDURE sp_cadastrar_cliente(
--   IN p_nome VARCHAR(200), IN p_cod_cliente INT DEFAULT NULL
-- ) LANGUAGE plpgsql AS $$
-- BEGIN
--   IF p_cod_cliente IS NULL THEN
--     INSERT INTO tb_cliente(nome) VALUES(p_nome);
--   ELSE
--     INSERT INTO tb_cliente(cod_cliente, nome) 
--       VALUES(p_cod_cliente, p_nome);
--   END IF;
-- END;
-- $$;


-- DROP TABLE IF NOT EXISTS tb_item_pedido;
-- CREATE TABLE tb_item_pedido(
--   --surrogate key
--   cod_item_pedido SERIAL PRIMARY KEY,
--   cod_item INT,
--   cod_pedido INT,
--   CONSTRAINT fk_item FOREIGN KEY (cod_item)
--     REFERENCES tb_item (cod_item),
--   CONSTRAINT fk_pedido FOREIGN KEY (cod_pedido)
--     REFERENCES tb_pedido (cod_pedido)
-- );

-- DROP TABLE IF EXISTS tb_item;
-- CREATE TABLE tb_item(
--   cod_item SERIAL PRIMARY KEY,
--   descricao VARCHAR(200) NOT NULL,
--   valor NUMERIC(10, 2) NOT NULL,
--   cod_tipo INT NOT NULL,
--   CONSTRAINT fk_tipo_item FOREIGN KEY (cod_tipo) REFERENCES tb_tipo_item(cod_tipo)
-- );

-- INSERT INTO tb_item (descricao, valor, cod_tipo) VALUES
-- ('Refrigerante', 7, 1),
-- ('Suco', 8, 1),
-- ('Hamburguer', 12, 2),
-- ('Batata frita', 9, 2);



-- DROP TABLE IF EXISTS tb_tipo_item;
-- CREATE TABLE tb_tipo_item(
--   cod_tipo SERIAL PRIMARY KEY,
--   descricao VARCHAR(200) NOT NULL
-- );
-- INSERT INTO tb_tipo_item (descricao) VALUES
-- ('Bebida'), ('Comida');

-- SELECT * FROM tb_tipo_item;


-- DROP TABLE IF EXISTS tb_cliente;
-- CREATE TABLE tb_cliente(
--   cod_cliente SERIAL PRIMARY KEY,
--   nome VARCHAR(200) NOT NULL
-- );

-- DROP TABLE IF EXISTS tb_pedido;
-- CREATE TABLE IF NOT EXISTS tb_pedido(
--   cod_pedido SERIAL PRIMARY KEY,
--   data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   data_modificacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   status VARCHAR DEFAULT 'aberto',
--   cod_cliente INT NOT NULL,
--   CONSTRAINT fk_cliente FOREIGN KEY (cod_cliente) REFERENCES tb_cliente(cod_cliente)
-- );







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