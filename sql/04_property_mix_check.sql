-- 04_property_mix_check.sql
-- Share of flat sales per district in 2018 vs 2025.
-- A big shift in the property mix can distort the district median growth.

SELECT
    pc_district,
    year,
    COUNT(*) AS n_sales,
    ROUND(100.0 * SUM(CASE WHEN property_type = 'Flat' THEN 1 ELSE 0 END)
          / COUNT(*), 1) AS flat_share_pct
FROM sales
WHERE year IN (2018, 2025)
GROUP BY pc_district, year
ORDER BY pc_district, year;