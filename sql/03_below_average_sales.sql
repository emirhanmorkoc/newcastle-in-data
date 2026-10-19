-- 03_below_average_sales.sql
-- Sales since 2023 priced at least 20% below the average price
-- of the same property type in the same postcode district.
-- Groups with fewer than 30 sales are excluded.

WITH district_avg AS (
    SELECT
        pc_district,
        property_type,
        AVG(price)  AS avg_price,
        COUNT(*)    AS n_sales
    FROM sales
    WHERE year >= 2023
    GROUP BY pc_district, property_type
    HAVING COUNT(*) >= 30
)
SELECT
    s.postcode,
    s.pc_district,
    s.property_type,
    s.date,
    s.price,
    ROUND(d.avg_price)                                       AS district_avg,
    ROUND((s.price - d.avg_price) * 100.0 / d.avg_price, 1)  AS diff_pct
FROM sales s
JOIN district_avg d
  ON s.pc_district   = d.pc_district
 AND s.property_type = d.property_type
WHERE s.year >= 2023
  AND s.price < d.avg_price * 0.8
ORDER BY diff_pct
LIMIT 50;