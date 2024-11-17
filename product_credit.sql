use teploradost;
SELECT * FROM products_uk where is_show=1 and (credit=0 or chast=0 or rassroch=0 or privat_parts=0 or sensebank=0 or sensebank_parts=0);


SELECT id,title,model FROM products_uk 
where is_show=1 and credit=0 and id not in (SELECT id_products FROM products_categories where id_categories=391 OR id_categories=491 OR id_categories=83);


UPDATE products_ru SET credit=1, chast=1, rassroch=1, sensebank=1 
where is_show=1 and credit=0 and id not in (SELECT id_products FROM products_categories where id_categories=391 OR id_categories=491 OR id_categories=83);

UPDATE products_uk SET credit=1, chast=1, rassroch=1, sensebank=1 
where is_show=1 and credit=0 and id not in (SELECT id_products FROM products_categories where id_categories=391 OR id_categories=491 OR id_categories=83);