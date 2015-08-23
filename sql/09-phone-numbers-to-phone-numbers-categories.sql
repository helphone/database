\c helpnumber

-- BE
INSERT INTO phone_numbers_to_phone_numbers_categories SELECT ph.id, 'urgency' FROM phone_numbers ph WHERE country_code = 'BE' AND phone_number = '112';
INSERT INTO phone_numbers_to_phone_numbers_categories SELECT ph.id, 'fireman' FROM phone_numbers ph WHERE country_code = 'BE' AND phone_number = '112';
INSERT INTO phone_numbers_to_phone_numbers_categories SELECT ph.id, 'police' FROM phone_numbers ph WHERE country_code = 'BE' AND phone_number = '101';