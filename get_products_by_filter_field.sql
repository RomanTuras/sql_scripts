-- Selecting all products from specific category, 
-- which are not have a particular value in ID_FILTER
-- Внутрішньопідлогові конвектори - id=100

-- Get products from category
SELECT id_products FROM products_categories WHERE id_categories=100;

-- Get filter_fields
SELECT id FROM filter_fields_uk WHERE id_filters=10026;

SELECT p.id, p.title, p.upc, p.model 
FROM products_filter_fields as pff
LEFT JOIN products_uk as p ON p.id=pff.id_products
LEFT JOIN products_categories as pc ON pc.id_products=ppf.id_products
WHERE 
  pff.id_filter_fields NOT IN(SELECT id FROM filter_fields_uk WHERE id_filters=10026)
  AND pc.id_categories=100
  AND p.is_show=1
GROUP BY p.id;


SELECT p.id, p.title, p.upc, p.model FROM products_uk as p
LEFT JOIN products_categories as pc ON pc.id_products=p.id
WHERE 
  p.id NOT IN(
    SELECT pff.id_products 
    FROM products_filter_fields as pff 
    WHERE pff.id_filter_fields 
    IN(
      SELECT id FROM filter_fields_uk WHERE id_filters=10026
      )
  )
AND pc.id_categories=100 AND p.is_show=1;

SELECT p.id, p.title, p.upc, p.model FROM products_uk as p
LEFT JOIN products_categories as pc ON pc.id_products=p.id
WHERE p.weight=0 AND pc.id_categories=100 AND p.is_show=1;


-- Get filters from category (Внутрішньопідлогові конвектори) id=100

SELECT * FROM filters_uk as f
LEFT JOIN categories_filters as cf ON cf.id_filters=f.id
WHERE cf.id_categories=100 AND f.is_show=1;