-- Crear la función de limpieza de enteros INT64
CREATE OR REPLACE FUNCTION `datawarehouse-keepcoding-sql.keepcoding.fnc_clean_integer`(number INT64) RETURNS NUMERIC AS (
( SELECT IFNULL(number, -999999))
);