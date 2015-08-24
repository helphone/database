\c helpnumber

CREATE OR REPLACE FUNCTION numbers_by_country_and_language(
  country_code VARCHAR,
  language_code VARCHAR
)
RETURNS TABLE (
  category_name VARCHAR,
  phone_number VARCHAR
)
AS $body$
DECLARE
  country_code ALIAS FOR $1;
  language_code ALIAS FOR $2;
  sql VARCHAR;
BEGIN

  sql := '
    SELECT tr.value AS "category", ph.phone_number AS "phonenumber"
    FROM phone_numbers ph
      LEFT JOIN phone_numbers_to_phone_numbers_categories phcat ON ph.id = phcat.phone_number_id
      LEFT JOIN phone_numbers_categories cat ON phcat.phone_number_categories_name = cat.name
      LEFT JOIN (
        SELECT e.category_name, COALESCE(o.value,e.value) AS "value"
        FROM phone_numbers_categories_translations              e
          LEFT OUTER JOIN phone_numbers_categories_translations o ON e.category_name=o.category_name and o.language_code=' || quote_literal(language_code) || '
        WHERE e.language_code='|| quote_literal('en') ||'
      ) tr ON cat.name = tr.category_name
    WHERE ph.country_code =' || quote_literal(country_code);

  RETURN QUERY EXECUTE sql;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100 ROWS 1000;