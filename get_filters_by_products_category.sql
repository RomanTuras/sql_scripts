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