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
where pff.id_products IN(SELECT id_products FROM products_categories where id_categories=458)
GROUP BY ff.id_filters;

-- Delete filter field from product by filter ID
SELECT * FROM filter_fields_uk as ff 
left join products_filter_fields as pff ON ff.id=pff.id_filter_fields 
where ff.id_filters=10915 and pff.id_products=75938;



DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10012,10020,10024,10026,10028,10288,10345,12061)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=458);

DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10012,10025,10026,10028,10089,10104,12468)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=513);

DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10012,10025,10026,10028,10089,10638,10942)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=463);

DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10025,10028,10895,12553)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=511);

DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10012,10024,10028,12553)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=512);

DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10012,10016,10021,10024,10025,10028,10032,10034,10051,10089,10895,10898,12461,12463,12553,12608)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=514);

DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10012,10025,10895,12553)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=464);

DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10012,12553)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=509);

DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10012,10017,10028,10896,10942)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=466);

-- id_filters


-- id categories
458,513,463,511,512,514,464,509,466
