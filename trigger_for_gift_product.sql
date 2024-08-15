-- Clearing and inserting "Gift" sticker to the product, when id_products_present
-- is changed from 0 to any ID
DELIMITER $$ 
DROP TRIGGER IF EXISTS update_product_present_trigger $$ 
CREATE TRIGGER update_product_present_trigger AFTER UPDATE ON products_uk FOR EACH ROW BEGIN 
IF new.id_products_present > 0 THEN 
DELETE FROM products_tags WHERE id_tags=7 AND id_products=old.id;
INSERT INTO products_tags (id_products, id_tags) VALUES (old.id, 7);
END IF; END$$ 
DELIMITER ;

-- Clearing "Gift" sticker from the product, when id_products_present
-- is changed to 0 from any ID
DELIMITER $$ 
DROP TRIGGER IF EXISTS delete_product_present_trigger $$ 
CREATE TRIGGER delete_product_present_trigger AFTER UPDATE ON products_uk FOR EACH ROW BEGIN 
IF new.id_products_present = 0 THEN 
DELETE FROM products_tags WHERE id_tags=7 AND id_products=old.id;
END IF; END$$ 
DELIMITER ;

--The same for the RU table

DELIMITER $$ 
DROP TRIGGER IF EXISTS update_product_ru_present_trigger $$ 
CREATE TRIGGER update_product_ru_present_trigger AFTER UPDATE ON products_ru FOR EACH ROW BEGIN 
IF new.id_products_present > 0 THEN 
DELETE FROM products_tags WHERE id_tags=7 AND id_products=old.id;
INSERT INTO products_tags (id_products, id_tags) VALUES (old.id, 7);
END IF; END$$ 
DELIMITER ;


DELIMITER $$ 
DROP TRIGGER IF EXISTS delete_product_ru_present_trigger $$ 
CREATE TRIGGER delete_product_ru_present_trigger AFTER UPDATE ON products_ru FOR EACH ROW BEGIN 
IF new.id_products_present = 0 THEN 
DELETE FROM products_tags WHERE id_tags=7 AND id_products=old.id;
END IF; END$$ 
DELIMITER ;