

-- QUERY 1: Grade Distribution

SELECT
    nutriscan_grade,
    COUNT(*) AS total_products,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM nutriscan_clean), 1) AS pct_of_total
FROM nutriscan_clean
GROUP BY nutriscan_grade
ORDER BY nutriscan_grade;


-- QUERY 2: Top 20 Brands by Average Healthiness

SELECT
    brand,
    COUNT(*) AS products,
    ROUND(AVG(sugar_g), 1)         AS avg_sugar_g,
    ROUND(AVG(fat_g), 1)           AS avg_fat_g,
    ROUND(AVG(sodium_mg), 0)       AS avg_sodium_mg,
    ROUND(AVG(protein_g), 1)       AS avg_protein_g,
    ROUND(AVG(calories_kcal), 0)   AS avg_kcal,
    SUM(CASE WHEN nutriscan_grade IN ('A','B') THEN 1 ELSE 0 END) AS grade_ab_count
FROM nutriscan_clean
WHERE brand != 'Unknown Brand'
GROUP BY brand
HAVING COUNT(*) >= 3
ORDER BY avg_sugar_g ASC
LIMIT 20;


-- QUERY 3: THE HEALTHY HALO

SELECT
    product_name,
    brand,
    nutriscan_grade,
    calories_kcal,
    sugar_g,
    fat_g,
    sodium_mg
FROM nutriscan_clean
WHERE has_health_claim = True
  AND nutriscan_grade IN ('D','E','F')
ORDER BY nutriscan_grade DESC, sugar_g DESC
LIMIT 50;



-- QUERY 4: Protein Claims vs Reality

SELECT
    product_name,
    brand,
    protein_g,
    calories_kcal,
    protein_per_100kcal,
    protein_level,
    nutriscan_grade
FROM nutriscan_clean
WHERE LOWER(product_name) LIKE '%protein%'
ORDER BY protein_per_100kcal DESC;



-- QUERY 5: Hidden Gems — Grade A or B, Low Calorie

SELECT
    product_name,
    brand,
    nutriscan_grade,
    calories_kcal,
    protein_g,
    sugar_g,
    fibre_g
FROM nutriscan_clean
WHERE nutriscan_grade IN ('A', 'B')
  AND calories_kcal < 200
ORDER BY protein_g DESC
LIMIT 30;



-- QUERY 6: Allergen Risk Analysis

SELECT
    CASE
        WHEN allergens LIKE '%Gluten%'    THEN 'Gluten'
        WHEN allergens LIKE '%Dairy%'     THEN 'Dairy'
        WHEN allergens LIKE '%Peanuts%'   THEN 'Peanuts'
        WHEN allergens LIKE '%Tree Nuts%' THEN 'Tree Nuts'
        WHEN allergens LIKE '%Soy%'       THEN 'Soy'
        WHEN allergens LIKE '%Eggs%'      THEN 'Eggs'
        ELSE 'Other'
    END AS allergen_type,
    COUNT(*) AS product_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM nutriscan), 1) AS pct_of_all
FROM nutriscan_clean
WHERE allergens != 'None detected'
GROUP BY allergen_type
ORDER BY product_count DESC;



-- QUERY 7: Sugar vs Health Grade Correlation

SELECT
    nutriscan_grade,
    COUNT(*)                        AS products,
    ROUND(AVG(sugar_g), 1)          AS avg_sugar,
    ROUND(AVG(fat_g), 1)            AS avg_fat,
    ROUND(AVG(sodium_mg), 0)        AS avg_sodium,
    ROUND(AVG(protein_g), 1)        AS avg_protein,
    ROUND(AVG(calories_kcal), 0)    AS avg_kcal
FROM nutriscan_clean
GROUP BY nutriscan_grade
ORDER BY nutriscan_grade;


-- QUERY 8: High Protein Products (NutriScan Definition)

SELECT
    product_name,
    brand,
    protein_g,
    calories_kcal,
    protein_per_100kcal,
    nutriscan_grade
FROM nutriscan_clean
WHERE protein_level = 'High'
ORDER BY protein_per_100kcal DESC
LIMIT 30;
"""

print(SQL_QUERIES)


with open('nutriscan_queries.sql', 'w') as f:
    f.write(SQL_QUERIES)
files.download('nutriscan_queries.sql')
print('\nSQL file downloaded!')

