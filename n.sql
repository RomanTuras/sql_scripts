UPDATE products_ru
SET products_ru.content = ""
FROM products_ru
INNER JOIN products_uk ON products_ru.id = products_uk.id
WHERE LEN(products_uk.content) < 120
AND products_ru.id = products_uk.id;

UPDATE products_ru ru
LEFT JOIN products_uk g 
ON g.id = ru.id
SET ru.content = ""   
WHERE length(g.content)<120;


"SELECT DISTINCT table.id, table.*, pr.title AS title_ru
FROM product_".$lng." AS table
LEFT JOIN second_table AS pr ON pr.id = table.id
LEFT JOIN products_categories AS pc ON pc.id_products = table.id
WHERE (table.title LIKE '%value%' OR pr.title LIKE '%value%' OR table.model LIKE '%value%' OR table.upc LIKE '%value%')
AND (is_show_query) AND (category_query)"

select DISTINCT(products_ru.id), products_ru.*, pr.title as title_ru 
from `products_ru` 
left join `products_uk` as `pr` on `pr`.`id` = `products_ru`.`id` 
left join `products_categories` as `pc` on `pc`.`id_products` = `products_ru`.`id` 
where (products_ru.title LIKE '%ariston%' OR pr.title LIKE '%ariston%' OR products_ru.model LIKE '%ariston%' OR products_ru.upc LIKE '%ariston%') 
AND (products_ru.is_show=1 OR pr.is_show=1)  
order by (select `id` from `statuses_ru` where `statuses_ru`.`id` = `products_ru`.`id_statuses`) desc, `rating` desc limit 30 offset 0

