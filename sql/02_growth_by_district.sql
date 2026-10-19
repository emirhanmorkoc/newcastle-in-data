-- 02_growth_by_district.sql
-- Growth in median sale price per postcode district, 2018 to 2025.
-- Only districts with at least 30 sales in both years are included,
-- so that small samples do not distort the ranking.
-- 2026 is excluded because it is a partial year.
-- Requires the view median_by_year (script 01).

DROP VIEW IF EXISTS growth_by_district;

CREATE VIEW growth_by_district AS
SELECT
    a.pc_district,
    a.n_sales                                              AS n_sales_2018,
    b.n_sales                                              AS n_sales_2025,
    ROUND(a.median_price)                                  AS median_2018,
    ROUND(b.median_price)                                  AS median_2025,
    ROUND((b.median_price - a.median_price) * 100.0
          / a.median_price, 1)                             AS growth_pct,
    RANK() OVER (
        ORDER BY (b.median_price - a.median_price) * 1.0
                 / a.median_price DESC
    )                                                      AS growth_rank
FROM median_by_year a
JOIN median_by_year b
  ON a.pc_district = b.pc_district
WHERE a.year = 2018
  AND b.year = 2025
  AND a.n_sales >= 30
  AND b.n_sales >= 30;

SELECT * FROM growth_by_district
ORDER BY growth_rank;