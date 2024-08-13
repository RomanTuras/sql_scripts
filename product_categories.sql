-- Get all categories First level
select id from categories_uk where id_categories=0 and is_show=1;
1,2,3,5,45,62,77,114,127,136,165

-- Get all categories Second level
select id from categories_uk where id_categories IN(select id from categories_uk where id_categories=0 and is_show=1) and is_show=1;


-- Get all products from first level categories
select p.id, p.title, upc, model from products_uk as p 
left join products_categories as pc on p.id=pc.id_products 
where pc.id_categories IN(select id from categories_uk as c where id_categories=0 and is_show=1) and p.is_show=1;

-- Get all products from second level categories
select p.id, p.title, upc, model, c.title from products_uk as p 
left join products_categories as pc on p.id=pc.id_products 
left join categories_uk as c on c.id=pc.id_categories 
where pc.id_categories IN(select id from categories_uk where id_categories IN(select id from categories_uk where id_categories=0 and is_show=1) and is_show=1) and p.is_show=1;