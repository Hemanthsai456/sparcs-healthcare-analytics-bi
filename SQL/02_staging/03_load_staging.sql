TRUNCATE TABLE staging.sparcs_raw;

COPY staging.sparcs_raw
FROM '..\data\sparcs_20xx_raw.csv'
DELIMITER ','
CSV HEADER
ENCODING 'UTF8';
