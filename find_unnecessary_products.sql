-- Getting all products where is_show=0 and haven't any images and any filters

USE teploradost;
SELECT p.id, p.title, p.upc, p.is_show, p.image, p.gallery FROM products_uk as p
where is_show=0 AND image = "" 
AND (gallery = "[]" OR gallery="")
AND NOT EXISTS (SELECT id FROM products_filter_fields as pff WHERE pff.id_products=p.id)
;

