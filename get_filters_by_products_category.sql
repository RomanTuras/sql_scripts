-- Getting all filters wich are exists in products values certain category
-- Category name: "Внутрішньопідлогові конвектори" (id=100)


SELECT id_products FROM products_categories where id_categories=100;

-- By one product
SELECT ff.id_filters, f.title  FROM products_filter_fields as pff
left join filter_fields_uk as ff on ff.id=pff.id_filter_fields
left join filters_uk as f on f.id=ff.id_filters
where pff.id_products=75938;

-- By products from category
SELECT ff.id_filters, f.title FROM products_filter_fields as pff
left join filter_fields_uk as ff on ff.id=pff.id_filter_fields
left join filters_uk as f on f.id=ff.id_filters
where pff.id_products IN(SELECT id_products FROM products_categories where id_categories=100)
GROUP BY ff.id_filters;

-- Delete filter field from product by filter ID
SELECT * FROM filter_fields_uk as ff 
left join products_filter_fields as pff ON ff.id=pff.id_filter_fields 
where ff.id_filters=10915 and pff.id_products=75938;

DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10025,10026,10028,10040,10089,10175,10301,10317,10561,10731,10803,10903,10915,11986,11987,12059,12061,12062,12090,12166,12186,12216,12236)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=100);

-- id_filters
-- 10025,10026,10028,10040,10089,10175,10301,10317,10561,10731,10803,10903,10915,11986,11987,12059,12061,12062,12090,12166,12186,12216,12236