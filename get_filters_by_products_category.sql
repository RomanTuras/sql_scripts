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
WHERE ff.id_filters IN(10017,10023,10024,10025,10026,10028,10089,10089,10626,12165,12166,12470)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=452);

DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10017,10024,10025,10026,10028,10089,10197,10622,12165,12166,12216,12470,12533)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=450);

DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10024,10025,10026,10028,10089,12165)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=456);

DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10017,10024,10025,10026,10028,10089,10622,10638,12165,12166,12533)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=451);

DELETE pff 
FROM products_filter_fields as pff
INNER JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields 
WHERE ff.id_filters IN(10024,10025,10026,10028,10089,12165,12470)
AND pff.id_products IN(SELECT id_products FROM products_categories where id_categories=507);

-- id_filters
-- 10017,10023,10024,10025,10026,10028,10089,10089,10626,12165,12166,12470

-- 10017,10024,10025,10026,10028,10089,10197,10622,12165,12166,12216,12470,12533

-- 10017,10024,10025,10026,10028,10089,10622,10638,12165,12166,12533

-- 10024,10025,10026,10028,10089,12165,12470