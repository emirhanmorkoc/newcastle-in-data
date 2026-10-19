-- 05_overall_median.sql
-- Citywide median sale price for 2018 and 2025 (used for the headline KPI)

WITH ranked AS (

    SELECT year, price,
           ROW_NUMBER() OVER (PARTITION BY year ORDER BY price) AS rn,
           COUNT(*) OVER (PARTITION BY year) AS cnt
    FROM sales
    WHERE year IN (2018, 2025)
)
SELECT year, AVG(price) AS median_price
FROM ranked
WHERE rn IN ((cnt + 1) / 2, (cnt + 2) / 2)
GROUP BY year;