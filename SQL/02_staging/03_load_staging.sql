TRUNCATE TABLE staging.sparcs_raw;

COPY staging.sparcs_raw
FROM 'D:\projects\sparcs-healthcare-analytics-platform\sparcs-healthcare-analytics-platform-2\data\sparcs_2024_raw.csv'
DELIMITER ','
CSV HEADER
ENCODING 'UTF8';