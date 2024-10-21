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
where pff.id_products IN(SELECT id_products FROM products_categories where id_categories=64)
GROUP BY ff.id_filters;

-- Delete filter field from product by filter ID
SELECT * FROM filter_fields_uk as ff 
left join products_filter_fields as pff ON ff.id=pff.id_filter_fields 
where ff.id_filters=10915 and pff.id_products=75938;



DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10012,10040,10089,12055,12470)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=462);

DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10012,10019,10089,10200,10345,10622,10638,10895,10896,10942,12055,12470)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=453);

DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10012,10016,10023,10024,10028,10033,10040,10089,10142,10197,10339,10895,11986,11987,12009,12051,12055,12061,12062,12463)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=457);

DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10012,10016,10023,10024,10028,10033,10040,10142,10339,12463)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=508);


-- id_filters
