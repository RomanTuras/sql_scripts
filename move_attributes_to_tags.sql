DELETE FROM attributes_ru WHERE id_products=24074 AND title LIKE 'Бесплатная доставка';
DELETE FROM attributes_uk WHERE id_products=24074 AND title LIKE 'Безкоштовна доставка';
-- INSERT INTO products_tags(id_products, id_tags) VALUES(24074, 5);



SELECT count(a.id) FROM attributes_uk a 
LEFT JOIN products_tags p ON a.id_products=p.id_products AND id_tags=6
WHERE 
NOT EXISTS(SELECT id FROM products_tags WHERE a.id_products=p.id_products AND id_tags=6) 
AND title LIKE 'Товари з акціями';
-- 8040

SELECT count(a.id) FROM attributes_ru a 
LEFT JOIN products_tags p ON a.id_products=p.id_products AND id_tags=6
WHERE 
NOT EXISTS(SELECT id FROM products_tags WHERE a.id_products=p.id_products AND id_tags=6) 
AND title LIKE 'Товары с акциями';
-- 41

SELECT count(id) FROM attributes_uk WHERE title LIKE 'Товари з акціями';
-- 56
SELECT count(id) FROM attributes_ru WHERE title LIKE 'Товары с акциями';
-- 56

DELETE FROM attributes_uk WHERE title LIKE 'Товари з акціями';

DELETE FROM attributes_ru WHERE title LIKE 'Товары с акциями';


-- #########################################

DROP PROCEDURE IF EXISTS move_attributes_to_tags;
DELIMITER $$
CREATE PROCEDURE move_attributes_to_tags()
BEGIN
   DECLARE cursor_List_isdone BOOLEAN DEFAULT FALSE;
   DECLARE cur_product_id INT;
   DECLARE tag INT DEFAULT 6;

   DECLARE cursor_List CURSOR FOR 
    SELECT a.id_products FROM attributes_uk a 
    LEFT JOIN products_tags p ON a.id_products=p.id_products AND p.id_tags=tag
    WHERE 
    NOT EXISTS(SELECT id FROM products_tags WHERE a.id_products=p.id_products AND id_tags=tag) 
    AND title LIKE 'Товари з акціями'
    ;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;

   OPEN cursor_List;

   loop_List: LOOP
      FETCH cursor_List INTO cur_product_id;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;

      INSERT INTO products_tags(id_products, id_tags) VALUES(cur_product_id, tag);

   END LOOP loop_List;

   CLOSE cursor_List;
END

$$

DELIMITER ;

CALL move_attributes_to_tags();


-- #######################  copy value of attributes from ru to ua #####################

SELECT p.title product, p.model, ar.title attribute, ar.id_products, ar.value value_ru, au.value value_uk 
FROM attributes_ru ar 
LEFT JOIN attributes_uk au ON ar.id=au.id 
LEFT JOIN products_ru p ON ar.id_products=p.id AND p.is_show=1 
WHERE ar.value REGEXP '^[0-9]+$' AND ar.value<>au.value AND p.is_show=1;


-- ################


SELECT ff.id, ff.id_filters, f.title, ff.title, ff.slug FROM filter_fields_uk ff 
LEFT JOIN filters_uk f ON f.id=ff.id_filters  
where ff.title REGEXP '^[0-9]+$' and ff.title not like ff.slug and f.title NOT LIKE '';

-- @@@@@@@@@@@

DROP PROCEDURE IF EXISTS copy_attributes_value;
DELIMITER $$
CREATE PROCEDURE copy_attributes_value()
BEGIN
   DECLARE cursor_List_isdone BOOLEAN DEFAULT FALSE;
   DECLARE cur_id BIGINT;
   DECLARE cur_slug TEXT;

   DECLARE cursor_List CURSOR FOR 
      SELECT ff.id, ff.slug 
      FROM filter_fields_uk ff 
      LEFT JOIN filters_uk f ON f.id=ff.id_filters  
      WHERE ff.title REGEXP '^[0-9]+$' AND ff.title NOT LIKE ff.slug AND f.title NOT LIKE ''
      ;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;

   OPEN cursor_List;

   loop_List: LOOP
      FETCH cursor_List INTO cur_id, cur_slug;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;

      UPDATE filter_fields_uk SET title=cur_slug WHERE id=cur_id;

   END LOOP loop_List;

   CLOSE cursor_List;
END

$$

DELIMITER ;

CALL copy_attributes_value();


-- #############
SELECT * FROM nova_poshta_cities WHERE description LIKE '%чернігів%' ORDER BY description DESC

SELECT description FROM nova_poshta_cities WHERE description LIKE 'чернігів' 
UNION DISTINCT SELECT description FROM nova_poshta_cities WHERE description LIKE 'чернігів%'  
UNION DISTINCT SELECT description FROM nova_poshta_cities WHERE description LIKE '%чернігів%'

--  ############
