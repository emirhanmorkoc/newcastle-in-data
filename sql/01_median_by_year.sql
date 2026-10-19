-- 01_median_by_year.sql
-- Median sale price per postcode district and year.
-- SQLite has no MEDIAN function, so we use window functions.

DROP VIEW IF EXISTS median_by_year;

CREATE VIEW median_by_year AS
WITH ranked AS (
    SELECT
        pc_district,
        year,
        price,
        ROW_NUMBER() OVER (PARTITION BY pc_district, year ORDER BY price) AS rn,
        COUNT(*)     OVER (PARTITION BY pc_district, year)                AS cnt
    FROM sales
)
SELECT
    pc_district,
    year,
    MAX(cnt)    AS n_sales,
    AVG(price)  AS median_price
FROM ranked
WHERE rn IN ((cnt + 1) / 2, (cnt + 2) / 2)
GROUP BY pc_district, year;

SELECT * FROM median_by_year
ORDER BY pc_district, year;

