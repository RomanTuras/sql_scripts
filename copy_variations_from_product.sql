-- ###########################################################################################
--                                   Copying UA and RU variation titles                       
-- ###########################################################################################

DROP PROCEDURE IF EXISTS copy_variations_products;
DELIMITER $$
CREATE PROCEDURE copy_variations_products()
BEGIN
   DECLARE cursor_List_isdone BOOLEAN DEFAULT FALSE;
   DECLARE cur_product_id INT;
   DECLARE cur_variation_id INT;
   DECLARE cur_variation_title TEXT;
   DECLARE cur_variation_title_ru TEXT;

   DECLARE cursor_List CURSOR FOR 
    SELECT MIN(products_uk.id) AS id, products_uk.title_variant, products_ru.title_variant as title_variant_ru
    FROM products_uk 
    LEFT JOIN products_ru ON products_uk.id = products_ru.id
    GROUP BY products_uk.title_variant
    ;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;

   OPEN cursor_List;

   loop_List: LOOP
      FETCH cursor_List INTO cur_product_id, cur_variation_title, cur_variation_title_ru;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;

      INSERT INTO title_variations_uk(title_variant) VALUES(cur_variation_title);
      INSERT INTO title_variations_ru(title_variant) VALUES(cur_variation_title_ru);

   END LOOP loop_List;

   CLOSE cursor_List;
END

$$

DELIMITER ;

CALL copy_variations_products();

-- ##############
-- UA --
-- VARNING!!! For local DB use next code:
-- UPDATE variations_uk SET id_title_variations=coalesce((SELECT id FROM title_variations_uk WHERE title COLLATE utf8mb4_unicode_ci = cur_variation_title COLLATE utf8mb4_unicode_ci),0) WHERE id_products=cur_product_id;
-- ##############

DROP PROCEDURE IF EXISTS copy_variations_products;
DELIMITER $$
CREATE PROCEDURE copy_variations_products()
BEGIN
   DECLARE cursor_List_isdone BOOLEAN DEFAULT FALSE;
   DECLARE cur_product_id INT;
   DECLARE cur_variation_id INT;
   DECLARE cur_variation_title TEXT;

   DECLARE cursor_List CURSOR FOR 
    SELECT id, title_variant
    FROM products_uk
    ;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;

   OPEN cursor_List;

   loop_List: LOOP
      FETCH cursor_List INTO cur_product_id, cur_variation_title;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;

      UPDATE variations_uk SET id_title_variations=coalesce((SELECT id FROM title_variations_uk WHERE title_variant = cur_variation_title LIMIT 1),0)
      WHERE id_products=cur_product_id;

   END LOOP loop_List;

   CLOSE cursor_List;
END

$$

DELIMITER ;

CALL copy_variations_products();


-- ##############
-- RU --
-- VARNING!!! For local DB use next code:
-- UPDATE variations_ru SET id_title_variations=coalesce((SELECT id FROM title_variations_ru WHERE title COLLATE utf8mb4_unicode_ci = cur_variation_title COLLATE utf8mb4_unicode_ci),0) WHERE id_products=cur_product_id;
-- ##############


DROP PROCEDURE IF EXISTS copy_variations_products;
DELIMITER $$
CREATE PROCEDURE copy_variations_products()
BEGIN
   DECLARE cursor_List_isdone BOOLEAN DEFAULT FALSE;
   DECLARE cur_product_id INT;
   DECLARE cur_variation_id INT;
   DECLARE cur_variation_title TEXT;

   DECLARE cursor_List CURSOR FOR 
    SELECT id, title_variant
    FROM products_ru
    ;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;

   OPEN cursor_List;

   loop_List: LOOP
      FETCH cursor_List INTO cur_product_id, cur_variation_title;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;

      UPDATE variations_ru SET id_title_variations=
      COALESCE((SELECT id FROM title_variations_ru WHERE title_variant = cur_variation_title LIMIT 1),0)
      WHERE id_products=cur_product_id;

   END LOOP loop_List;

   CLOSE cursor_List;
END

$$

DELIMITER ;

CALL copy_variations_products();


-- #######################
-- Dummy data

INSERT INTO variations_ru (title, id_products, id_products_other, id_title_variations) 
VALUES('var-1', 79072, 79104, 2);
INSERT INTO variations_ru (title, id_products, id_products_other, id_title_variations) 
VALUES('var-2', 79072, 79104, 2);
INSERT INTO variations_ru (title, id_products, id_products_other, id_title_variations) 
VALUES('var-3', 79072, 79104, 2);
INSERT INTO variations_ru (title, id_products, id_products_other, id_title_variations) 
VALUES('var-4', 79072, 79104, 2);
INSERT INTO variations_ru (title, id_products, id_products_other, id_title_variations) 
VALUES('var-5', 79072, 79104, 2);
INSERT INTO variations_ru (title, id_products, id_products_other, id_title_variations) 
VALUES('var-6', 79072, 79104, 2);
INSERT INTO variations_ru (title, id_products, id_products_other, id_title_variations) 
VALUES('var-7', 79072, 79104, 2);
INSERT INTO variations_ru (title, id_products, id_products_other, id_title_variations) 
VALUES('var-8', 79072, 79104, 2);

INSERT INTO variations_uk (title, id_products, id_products_other, id_title_variations) 
VALUES('var-1', 79072, 79104, 2);
INSERT INTO variations_uk (title, id_products, id_products_other, id_title_variations) 
VALUES('var-2', 79072, 79104, 2);
INSERT INTO variations_uk (title, id_products, id_products_other, id_title_variations) 
VALUES('var-3', 79072, 79104, 2);
INSERT INTO variations_uk (title, id_products, id_products_other, id_title_variations) 
VALUES('var-4', 79072, 79104, 2);
INSERT INTO variations_uk (title, id_products, id_products_other, id_title_variations) 
VALUES('var-5', 79072, 79104, 2);
INSERT INTO variations_uk (title, id_products, id_products_other, id_title_variations) 
VALUES('var-6', 79072, 79104, 2);
INSERT INTO variations_uk (title, id_products, id_products_other, id_title_variations) 
VALUES('var-7', 79072, 79104, 2);
INSERT INTO variations_uk (title, id_products, id_products_other, id_title_variations) 
VALUES('var-8', 79072, 79104, 2);


INSERT INTO variations_ru (title, id_products, id_products_other, id_title_variations) 
VALUES('var-11', 79072, 79104, 8);
INSERT INTO variations_ru (title, id_products, id_products_other, id_title_variations) 
VALUES('var-12', 79072, 79104, 8);
INSERT INTO variations_ru (title, id_products, id_products_other, id_title_variations) 
VALUES('var-13', 79072, 79104, 8);
INSERT INTO variations_ru (title, id_products, id_products_other, id_title_variations) 
VALUES('var-14', 79072, 79104, 8);
INSERT INTO variations_ru (title, id_products, id_products_other, id_title_variations) 
VALUES('var-15', 79072, 79104, 8);
INSERT INTO variations_ru (title, id_products, id_products_other, id_title_variations) 
VALUES('var-16', 79072, 79104, 8);

INSERT INTO variations_uk (title, id_products, id_products_other, id_title_variations) 
VALUES('var-11', 79072, 79104, 8);
INSERT INTO variations_uk (title, id_products, id_products_other, id_title_variations) 
VALUES('var-12', 79072, 79104, 8);
INSERT INTO variations_uk (title, id_products, id_products_other, id_title_variations) 
VALUES('var-13', 79072, 79104, 8);
INSERT INTO variations_uk (title, id_products, id_products_other, id_title_variations) 
VALUES('var-14', 79072, 79104, 8);
INSERT INTO variations_uk (title, id_products, id_products_other, id_title_variations) 
VALUES('var-15', 79072, 79104, 8);
INSERT INTO variations_uk (title, id_products, id_products_other, id_title_variations) 
VALUES('var-16', 79072, 79104, 8);


TRUNCATE TABLE title_variations_ru;
TRUNCATE TABLE title_variations_uk;

UPDATE variations_uk SET id_title_variations=0 WHERE 1;
UPDATE variations_ru SET id_title_variations=0 WHERE 1;