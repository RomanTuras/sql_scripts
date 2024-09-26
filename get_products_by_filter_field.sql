-- Внутрішньопідлогові конвектори - id=100
-- Проточні фільтри для води - id=449
-- Фільтри зворотного осмосу - id=506

-- Побутові фільтри для води (родительска)
-- Системи комплексного очищення води 452
-- Фільтри для пом'якшення води 450
-- Вугільні фільтри 456
-- Фільтри від заліза 451
-- Фільтри від сірководню 507

-- Картриджні фільтри для води (родительска)
-- Механічні фільтри 462
-- Магістральні фільтри для води 453
-- Мембранні фільтри для води 454
-- Фільтри від накипу для побутової техніки 457
-- Дискові промивні фільтри 455
-- Магнітні фільтри 508

-- Get products from category
SELECT id_products FROM products_categories WHERE id_categories=446;

-- Get filter_fields
SELECT id FROM filter_fields_uk WHERE id_filters=10026;

-- I STEP
-- Get filters from products by certain category
-- (Внутрішньопідлогові конвектори) id=100
-- 449, 261, 454
-- 446, 447
-- Make CSV for manager Teploradost
SELECT f.id, f.title
FROM products_filter_fields as pff 
LEFT JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
LEFT JOIN filters_uk as f ON f.id=ff.id_filters 
WHERE pff.id_products IN(SELECT id_products FROM products_categories WHERE id_categories=446)
GROUP BY f.id;

-- II STEP
-- Delete filter_fields by certain products and specific filters
DELETE pff 
FROM products_filter_fields as pff 
LEFT JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10012,10015,10020,10025,10026,10089,10638,10896,10942,12216,12348,12468)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=449);

DELETE pff 
FROM products_filter_fields as pff 
LEFT JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10012,10015,10020,10025,10026,10077,10089,10134,10175,10207,10622,10870,10915,10942,12165,12166,12211,12216,12554,12642)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=506);





-- Get filters only from category (Внутрішньопідлогові конвектори) id=100
SELECT * FROM filters_uk as f
LEFT JOIN categories_filters as cf ON cf.id_filters=f.id
WHERE cf.id_categories=449 AND f.is_show=1;

-- Select  filter_fields by certain products and specific filters

SELECT pff.id, pff.id_products, ff.title, ff.id_filters FROM products_filter_fields as pff 
LEFT JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields
WHERE pff.id_products in(SELECT id_products FROM products_categories WHERE id_categories=506) AND ff.id_filters IN(10012, 10015);










-- Delete filter field from product by filter ID
SELECT * FROM filter_fields_uk as ff 
left join products_filter_fields as pff ON ff.id=pff.id_filter_fields 
where ff.id_filters=10915 and pff.id_products=75938;


-- Selecting all products from specific category, 
-- which are not have a particular value in ID_FILTER
SELECT p.id, p.title, p.upc, p.model 
FROM products_filter_fields as pff
LEFT JOIN products_uk as p ON p.id=pff.id_products
LEFT JOIN products_categories as pc ON pc.id_products=pff.id_products
WHERE 
  pff.id_filter_fields NOT IN(SELECT id FROM filter_fields_uk WHERE id_filters=10026)
  AND pc.id_categories=449
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
AND pc.id_categories=449 AND p.is_show=1;

SELECT p.id, p.title, p.upc, p.model FROM products_uk as p
LEFT JOIN products_categories as pc ON pc.id_products=p.id
WHERE p.weight=0 AND pc.id_categories=100 AND p.is_show=1;