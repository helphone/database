\c helphone

CREATE OR REPLACE FUNCTION countries_by_language(
  input_language_code VARCHAR
)
RETURNS TABLE (
  country_name VARCHAR,
  country_code CHAR(2)
)
AS $body$
DECLARE
  input_language_code ALIAS FOR $1;
  sql VARCHAR;
BEGIN

  sql := '
    SELECT tr.value AS "country_name", countries.code as "country_code"
    FROM countries
      LEFT JOIN (
        SELECT e.country_code, COALESCE(o.value,e.value) AS "value"
        FROM countries_translations              e
          LEFT OUTER JOIN countries_translations o ON e.country_code=o.country_code and o.language_code=' || quote_literal(input_language_code) || '
        WHERE e.language_code='|| quote_literal('en') ||'
      ) tr ON countries.code = tr.country_code';

  RETURN QUERY EXECUTE sql;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100 ROWS 1000;
