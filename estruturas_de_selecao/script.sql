-- Active: 1724757618200@@127.0.0.1@5432@20242_fatec_ipi_pbdi_rodrigo@public

DO $$
DECLARE
  --testar
  --22102022: valida
  --29022020: valida, 2020 foi bissexto
  --29022021: invalida, 2021 nao foi bissexto
  --31062023: invalida, junho nao tem 31
  data INT := 31062023;
  dia INT;
  mes INT;
  ano INT;
  data_valida BOOL := TRUE;
BEGIN
  dia := data / 1000000;
  mes := data % 1000000 / 10000;
  ano := data % 10000;
  RAISE NOTICE '%/%/%', dia, mes, ano;
  IF ano >= 1 THEN
    CASE
      WHEN mes > 12 OR mes < 1 OR dia < 1 OR dia > 31 THEN
        RAISE NOTICE 'a';
        data_valida := FALSE;
      ELSE
        IF  ((mes = 4 OR mes = 6 OR mes = 9 OR mes = 11) AND dia > 30) THEN
          RAISE NOTICE 'b';
          data_valida := FALSE;
        ELSE
          IF mes = 2 THEN
            CASE
                WHEN ((ano % 4 = 0 AND ano % 100 <> 0) OR ano % 400 = 0) THEN
                  
                  IF dia > 29 THEN
                    RAISE NOTICE 'c';
                    data_valida := FALSE;
                  END IF;
                ELSE
                  IF dia > 28 THEN
                    RAISE NOTICE 'd';
                    data_valida := FALSE;
                  END IF;
            END CASE;
          END IF;
        END IF;
    END CASE;
  ELSE
    RAISE NOTICE 'e';
    data_valida := FALSE;
  END IF;
  CASE
    WHEN data_valida THEN
      RAISE NOTICE '% é uma data válida', data;
    ELSE
      RAISE NOTICE '% é uma data inválida', data;
  END CASE;
END;
$$



-- DO $$
-- DECLARE
--   a INT := valor_aleatorio_entre(0, 20);
--   b INT := valor_aleatorio_entre(0, 20);
--   c INT := valor_aleatorio_entre(0, 20);
--   delta NUMERIC(10, 2);
--   raizUm NUMERIC(10, 2);
--   raizDois NUMERIC(10, 2);
-- BEGIN
--   -- 2x² + 3x + 1 = 0
--   RAISE NOTICE '%x% + %x + % = 0', a, U&'\00B2', b, c;
--   IF a = 0 THEN
--     RAISE NOTICE 'Não é uma equação do segundo grau';
--   ELSE
--     delta := (b ^ 2) - (4 * a * c);
--     RAISE NOTICE 'Delta: %', delta;
--     IF delta < 0 THEN
--       RAISE NOTICE 'Nenhuma raiz';
--     ELSIF delta = 0 THEN
--       raizUm := (-b + |/delta) / (2 * a);
--       RAISE NOTICE 'Uma raiz: %', raizUm;
--     ELSE
--       raizUm := (-b + |/delta) / (2 * a);
--       raizDois := (-b - |/delta) / (2 * a);
--       RAISE NOTICE 'Duas raizes: % e %', raizUm, raizDois;
--     END IF;
--   END IF;
-- END;
-- $$



-- CREATE OR REPLACE FUNCTION valor_aleatorio_entre (lim_inferior INT, lim_superior
-- INT) RETURNS INT AS
-- $$
-- BEGIN
-- RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
-- END;
-- $$ LANGUAGE plpgsql;