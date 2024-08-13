USE teploradost;

-- Searching and deleting doubles from filters values
DROP TABLE temp;

CREATE TABLE IF NOT EXISTS temp (
  product_id BIGINT,
  ff_id BIGINT,
  product_title TEXT,
  ff_title TEXT,
  filter_title TEXT,
  category_title TEXT
);
    
DROP PROCEDURE IF EXISTS products_filters_doubles;
DELIMITER $$
CREATE PROCEDURE products_filters_doubles()
BEGIN
   DECLARE cursor_List_isdone BOOLEAN DEFAULT FALSE;
   DECLARE cur_ff_id BIGINT;
   DECLARE cur_product_id BIGINT;
   DECLARE cur_ff_title TEXT;
   DECLARE cur_finded TEXT;
   DECLARE cur_replaced TEXT;
   DECLARE cur_new_name TEXT;

   DECLARE cursor_List CURSOR FOR 
    SELECT id_products, id_filter_fields, title
    FROM products_filter_fields as pff
    LEFT JOIN filter_fields_uk as ff ON pff.id_filter_fields=ff.id
    GROUP BY id_products, id_filter_fields, title
    HAVING COUNT(*) > 1
    ;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;

   OPEN cursor_List;

   loop_List: LOOP
      FETCH cursor_List INTO cur_product_id, cur_ff_id, cur_ff_title;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;

      -- INSERT INTO temp(product_id, ff_id, ff_title) VALUES(cur_product_id, cur_ff_id, cur_ff_title);

      DELETE FROM products_filter_fields WHERE id_products=cur_product_id and id_filter_fields=cur_ff_id;
      INSERT INTO products_filter_fields(id_products, id_filter_fields) VALUES(cur_product_id, cur_ff_id);

   END LOOP loop_List;

   CLOSE cursor_List;
END

$$

DELIMITER ;

CALL products_filters_doubles();


-- Searching and deleting doubles from filters values
DROP TABLE temp;

CREATE TABLE IF NOT EXISTS temp (
  product_id BIGINT,
  ff_id BIGINT,
  product_title TEXT,
  ff_title TEXT,
  filter_title TEXT,
  category_title TEXT
);
    
DROP PROCEDURE IF EXISTS products_filters_doubles;
DELIMITER $$
CREATE PROCEDURE products_filters_doubles()
BEGIN
   DECLARE cursor_List_isdone BOOLEAN DEFAULT FALSE;
   DECLARE cur_ff_id BIGINT;
   DECLARE cur_product_id BIGINT;
   DECLARE cur_ff_title TEXT;
   DECLARE cur_finded TEXT;
   DECLARE cur_replaced TEXT;
   DECLARE cur_new_name TEXT;

   DECLARE cursor_List CURSOR FOR 
    SELECT id_products, id_filters
    FROM products_filter_fields as pff
    LEFT JOIN filter_fields_uk as ff ON pff.id_filter_fields=ff.id
    GROUP BY id_products, id_filters
    HAVING COUNT(*) > 1
    ;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;

   OPEN cursor_List;

   loop_List: LOOP
      FETCH cursor_List INTO cur_product_id, cur_ff_id;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;

      INSERT INTO temp(product_id, ff_id) VALUES(cur_product_id, cur_ff_id);

      -- DELETE FROM products_filter_fields WHERE id_products=cur_product_id and id_filter_fields=cur_ff_id;
      -- INSERT INTO products_filter_fields(id_products, id_filter_fields) VALUES(cur_product_id, cur_ff_id);

   END LOOP loop_List;

   CLOSE cursor_List;
END

$$

DELIMITER ;

CALL products_filters_doubles();


-- 
--Select from temp:

SELECT product_id, p.title, p.model, p.is_show, f.title, c.title FROM teploradost.temp
LEFT JOIN products_uk as p ON p.id=product_id
LEFT JOIN filters_uk as f ON f.id=ff_id
LEFT JOIN products_categories as pc ON pc.id_products=product_id
LEFT JOIN categories_uk as c ON c.id=pc.id_categories
;