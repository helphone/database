\c helpnumber

CREATE OR REPLACE FUNCTION numbers_by_language(
  input_language_code VARCHAR
)
RETURNS TABLE (
  category_name VARCHAR,
  phone_number VARCHAR,
  country_code CHAR(2)
)
AS $body$
DECLARE
  input_language_code ALIAS FOR $1;
  sql VARCHAR;
BEGIN

  sql := '
    SELECT tr.value AS "category", ph.phone_number, ph.country_code AS "phonenumber"
    FROM phone_numbers ph
      LEFT JOIN phone_numbers_to_phone_numbers_categories phcat ON ph.id = phcat.phone_number_id
      LEFT JOIN phone_numbers_categories cat ON phcat.phone_number_categories_name = cat.name
      LEFT JOIN (
        SELECT e.category_name, COALESCE(o.value,e.value) AS "value"
        FROM phone_numbers_categories_translations              e
          LEFT OUTER JOIN phone_numbers_categories_translations o ON e.category_name=o.category_name and o.language_code=' || quote_literal(input_language_code) || '
        WHERE e.language_code='|| quote_literal('en') ||'
      ) tr ON cat.name = tr.category_name';

  RETURN QUERY EXECUTE sql;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100 ROWS 1000;