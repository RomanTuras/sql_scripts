
DELIMITER $$ 
DROP TRIGGER IF EXISTS update_product_status_trigger $$ 
CREATE TRIGGER update_product_status_trigger AFTER UPDATE ON products_uk FOR EACH ROW BEGIN 
IF new.id_statuses = 7 AND new.quantity>0 THEN
UPDATE products_uk SET id_statuses=9 WHERE `id`=new.id;
END IF; END$$ 
DELIMITER ;



-- Trigger for `oc_product_to_category`
-- 1) IF INSERTED a new row with main_category = 1
-- 2) IF UPDATED with: new.main_category = 1

DELIMITER $$ 
DROP TRIGGER IF EXISTS update_product_trigger $$ 
CREATE TRIGGER update_product_trigger AFTER UPDATE ON oc_product_to_category FOR EACH ROW BEGIN 
IF NOT EXISTS(SELECT * FROM oc_version_changes WHERE entity_id=new.product_id AND entity_type='product') AND new.main_category = 1 THEN 
INSERT INTO oc_version_changes (entity_id,entity_type) VALUES (new.product_id, 'product'); END IF; END$$ 
DELIMITER ;

DELIMITER $$ 
DROP TRIGGER IF EXISTS insert_product_trigger $$
CREATE TRIGGER insert_product_trigger AFTER INSERT ON oc_product_to_category FOR EACH ROW BEGIN 
IF new.main_category = 1 
THEN INSERT INTO oc_version_changes (entity_id,entity_type) VALUES (new.product_id, 'product');
END IF; 
END$$ 
DELIMITER ;



-- Trigger for `oc_category`
-- 1) IF INSERTED a new row for oc_category
-- 2) IF UPDATED with: new.parent_id <> old.parent_id
-- 3) If INSERTED a new category THEN generate UUID for it

DELIMITER $$ 
DROP TRIGGER IF EXISTS insert_category_trigger $$
CREATE TRIGGER insert_category_trigger AFTER INSERT ON oc_category FOR EACH ROW BEGIN 
INSERT INTO oc_version_changes (entity_id,entity_type) VALUES (new.category_id, 'category');
INSERT INTO oc_category_to_1c (category_id,1c_id) VALUES (new.category_id, uuid());
END$$ 
DELIMITER ;

DELIMITER $$ 
DROP TRIGGER IF EXISTS update_category_trigger $$ 
CREATE TRIGGER update_category_trigger AFTER UPDATE ON oc_category FOR EACH ROW BEGIN 
IF NOT EXISTS(SELECT * FROM oc_version_changes WHERE entity_id=new.product_id AND entity_type='category') AND new.parent_id <> old.parent_id THEN 
INSERT INTO oc_version_changes (entity_id,entity_type) VALUES (new.category_id, 'category'); END IF; END$$ 
DELIMITER ;





-- create a new table
CREATE TABLE IF NOT EXISTS oc_version_changes (
  entity_id int(11),
  entity_type varchar(30)
  );

-- fix collation error
SELECT * FROM your_table
WHERE column1 COLLATE utf8mb4_unicode_ci = column2 COLLATE utf8mb4_unicode_ci;
