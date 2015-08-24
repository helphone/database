\c helpnumber

CREATE TABLE countries (
  code CHAR(2) CONSTRAINT PK_countries PRIMARY KEY -- ISO 3166-1 alpha-2
);

CREATE TABLE languages (
  code CHAR(2) CONSTRAINT PK_languages PRIMARY KEY -- ISO 639-1
);

CREATE TABLE countries_translations (
  country_code CHAR(2) REFERENCES countries (code),
  language_code CHAR(2) REFERENCES languages (code),
  value VARCHAR(255) NOT NULL,
  CONSTRAINT PK_countries_translations PRIMARY KEY (country_code, language_code)
);

CREATE TABLE phone_numbers_categories (
  name VARCHAR(100) CONSTRAINT PK_phone_numbers_categories PRIMARY KEY
);

CREATE TABLE phone_numbers_categories_translations (
  category_name VARCHAR(100) REFERENCES phone_numbers_categories (name),
  language_code CHAR(2) REFERENCES languages (code),
  value VARCHAR(255) NOT NULL,
  CONSTRAINT PK_phone_numbers_categories_translations PRIMARY KEY (category_name, language_code)
);

CREATE TABLE phone_numbers (
  id BIGSERIAL CONSTRAINT PK_phone_numbers PRIMARY KEY,
  country_code CHAR(2) REFERENCES countries (code) NOT NULL,
  phone_number VARCHAR(100) NOT NULL,
  CONSTRAINT UNIQUE_phone_numbers UNIQUE (country_code, phone_number)
);

CREATE TABLE phone_numbers_to_phone_numbers_categories (
  phone_number_id BIGINT REFERENCES phone_numbers (id) NOT NULL,
  phone_number_categories_name VARCHAR(100) REFERENCES phone_numbers_categories (name) NOT NULL,
  CONSTRAINT UNIQUE_phone_numbers_to_phone_numbers_categories UNIQUE (phone_number_id, phone_number_categories_name)
);