SELECT * FROM products_uk as p 
LEFT JOIN products_categories as pc ON p.id=pc.id_products 
LEFT JOIN categories_uk as c ON c.id=pc.id_categories 
WHERE p.is_show=1 AND c.is_show=0;