\c helpnumber

CREATE TABLE countries (
  code CHAR(2) CONSTRAINT PK_countries PRIMARY KEY -- ISO 3166-1 alpha-2
);

CREATE TABLE languages (
  code CHAR(2) CONSTRAINT PK_languages PRIMARY KEY -- ISO 639-1
);

CREATE TABLE countries_translations (
  country_code CHAR(2) REFERENCES countries (code) NOT NULL,
  language_code CHAR(2) REFERENCES languages (code) NOT NULL,
  value VARCHAR(255) NOT NULL,
  CONSTRAINT PK_countries_translations PRIMARY KEY (country_code, language_code)
);
CREATE INDEX IN_countries_translations_country_code ON countries_translations USING betree (country_code);
CREATE INDEX IN_countries_translations_language_code ON countries_translations USING betree (language_code);

CREATE TABLE phone_numbers_categories (
  name VARCHAR(100) CONSTRAINT PK_phone_numbers_categories PRIMARY KEY
);

CREATE TABLE phone_numbers_categories_translations (
  category_name VARCHAR(100) REFERENCES phone_numbers_categories (name) NOT NULL,
  language_code CHAR(2) REFERENCES languages (code) NOT NULL,
  value VARCHAR(255) NOT NULL,
  CONSTRAINT PK_phone_numbers_categories_translations PRIMARY KEY (category_name, language_code)
);
CREATE INDEX IN_phone_numbers_categories_translations_category_name ON phone_numbers_categories_translations USING betree (country_code);
CREATE INDEX IN_phone_numbers_categories_translations_language_code ON phone_numbers_categories_translations USING betree (language_code);

CREATE TABLE phone_numbers (
  id BIGSERIAL CONSTRAINT PK_phone_numbers PRIMARY KEY,
  country_code CHAR(2) REFERENCES countries (code) NOT NULL,
  phone_number VARCHAR(100) NOT NULL,
  CONSTRAINT UNIQUE_phone_numbers UNIQUE (country_code, phone_number)
);
CREATE INDEX IN_phone_numbers_country_code ON phone_numbers USING betree (country_code);

CREATE TABLE phone_numbers_to_phone_numbers_categories (
  phone_number_id BIGINT REFERENCES phone_numbers (id) NOT NULL,
  phone_number_categories_name VARCHAR(100) REFERENCES phone_numbers_categories (name) NOT NULL,
  CONSTRAINT PK_phone_numbers_to_phone_numbers_categories PRIMARY KEY (phone_number_id, phone_number_categories_name)
);
CREATE INDEX IN_phone_numbers_to_phone_numbers_categories_phone_number_id ON phone_numbers_to_phone_numbers_categories USING betree (phone_number_id);
CREATE INDEX IN_phone_numbers_to_phone_numbers_categories_phone_number_categories_name ON phone_numbers_to_phone_numbers_categories USING betree (phone_number_categories_name);