-- Add fulltext search
ALTER TABLE products ADD FULLTEXT(text);

-- Copy from products_ table
DROP PROCEDURE IF EXISTS copy_products_titles;
DELIMITER $$
CREATE PROCEDURE copy_products_titles()
BEGIN
   DECLARE cursor_List_isdone BOOLEAN DEFAULT FALSE;
   DECLARE cur_product_id INT;
   DECLARE cur_title TEXT;

   DECLARE cursor_List CURSOR FOR 
    SELECT id, title
    FROM products_ru 
    WHERE is_show=1
    ;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;

   OPEN cursor_List;

   loop_List: LOOP
      FETCH cursor_List INTO cur_product_id, cur_title;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;
      
      INSERT INTO `products` (`id`, `text`, `language`) VALUES (cur_product_id, cur_title, 'ru');

   END LOOP loop_List;

   CLOSE cursor_List;
END

$$

DELIMITER ;

CALL copy_products_titles();


-- Triggers for `product_uk` and `product_ru`

-- UK
DELIMITER $$ 
DROP TRIGGER IF EXISTS update_product_trigger $$ 
CREATE TRIGGER update_product_trigger AFTER UPDATE ON products_uk FOR EACH ROW BEGIN 
IF EXISTS(SELECT * FROM products WHERE id=new.id AND language LIKE 'uk') THEN 
UPDATE products SET text=new.title WHERE id=new.id AND language LIKE 'uk'; END IF; END$$ 
DELIMITER ;

DELIMITER $$ 
DROP TRIGGER IF EXISTS insert_product_trigger $$ 
CREATE TRIGGER insert_product_trigger AFTER INSERT ON products_uk FOR EACH ROW BEGIN 
IF NOT EXISTS(SELECT * FROM products WHERE id=new.id AND language LIKE 'uk') THEN 
INSERT INTO products (id, text, language) VALUES (new.id, new.title, 'uk'); END IF; END$$ 
DELIMITER ;

-- DELIMITER $$ 
-- DROP TRIGGER IF EXISTS delete_product_trigger $$
-- CREATE TRIGGER delete_product_trigger AFTER DELETE ON products_uk FOR EACH ROW BEGIN 
-- IF EXISTS(SELECT * FROM products WHERE id=id AND language LIKE 'uk') THEN 
-- DELETE FROM products WHERE id=id AND language LIKE 'uk'; END IF; END$$ 
-- DELIMITER ;

-- RU
DELIMITER $$ 
DROP TRIGGER IF EXISTS update_product_trigger_ru $$ 
CREATE TRIGGER update_product_trigger_ru AFTER UPDATE ON products_ru FOR EACH ROW BEGIN 
IF EXISTS(SELECT * FROM products WHERE id=new.id AND language LIKE 'ru') THEN 
UPDATE products SET text=new.title WHERE id=new.id AND language LIKE 'ru'; END IF; END$$ 
DELIMITER ;

DELIMITER $$ 
DROP TRIGGER IF EXISTS insert_product_trigger_ru $$ 
CREATE TRIGGER insert_product_trigger_ru AFTER INSERT ON products_ru FOR EACH ROW BEGIN 
IF NOT EXISTS(SELECT * FROM products WHERE id=new.id AND language LIKE 'ru') THEN 
INSERT INTO products (id, text, language) VALUES (new.id, new.title, 'ru'); END IF; END$$ 
DELIMITER ;

-- DELIMITER $$ 
-- DROP TRIGGER IF EXISTS delete_product_trigger_ru $$
-- CREATE TRIGGER delete_product_trigger_ru AFTER DELETE ON products_ru FOR EACH ROW BEGIN 
-- IF EXISTS(SELECT * FROM products WHERE id=id AND language LIKE 'ru') THEN 
-- DELETE FROM products WHERE id=id AND language LIKE 'ru'; END IF; END$$ 
-- DELIMITER ;


DELIMITER $$ 
DROP TRIGGER IF EXISTS update_product_trigger $$ 
DROP TRIGGER IF EXISTS insert_product_trigger $$ 
DROP TRIGGER IF EXISTS update_product_trigger_ru $$ 
DROP TRIGGER IF EXISTS insert_product_trigger_ru $$ 
DELIMITER ;

