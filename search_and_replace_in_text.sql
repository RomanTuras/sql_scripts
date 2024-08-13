-- ####################################

SELECT title FROM products_uk WHERE title LIKE '% Q &E %';
SELECT title FROM products_uk WHERE title LIKE '% Q &E %';

-- Replace 'Теплорадость' to 'Теплорадість' Казани
-- Replace 'Teploradost' to 'Teploradist'
DROP PROCEDURE IF EXISTS search_and_replace_in_text;
DELIMITER $$
CREATE PROCEDURE search_and_replace_in_text()
BEGIN
   DECLARE cursor_List_isdone BOOLEAN DEFAULT FALSE;
   DECLARE cur_product_id INT;
   DECLARE cur_title TEXT;
   DECLARE cur_new_name TEXT;

   DECLARE cursor_List CURSOR FOR 
    SELECT id, title
    FROM products_ru 
    WHERE title LIKE '% Q &E %'
    ;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;

   OPEN cursor_List;

   loop_List: LOOP
      FETCH cursor_List INTO cur_product_id, cur_title;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;

      SET cur_new_name = REPLACE(cur_title, 'Q &E', 'Q&E');
      
      UPDATE `products_ru` 
      SET `title`=cur_new_name 
      WHERE `id`=cur_product_id;

   END LOOP loop_List;

   CLOSE cursor_List;
END

$$

DELIMITER ;

CALL search_and_replace_in_text();

-- END procedure ####################################

SELECT count(*) 
    FROM products_ru 
    WHERE content LIKE '%Теплорадость%'
    ;
-- Teploradost 30750 / 1851
-- Теплорадость 27548 / 1 