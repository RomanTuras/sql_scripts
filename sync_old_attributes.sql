-- 'Высота (мм)'; -- 10034
-- 'Висота (мм)'; -- 10034
-- 'Довжина (мм)'; -- 10021
-- 'Длина (мм)'; -- 10021
-- 'Ширина (мм)'; -- 10032
-- 'Ширина (мм)'; -- 10032
-- 'Глубина (мм)'; -- 12461
-- 'Глибина (мм)'; -- 12461

-- Select all products in which not exists filters (10021, 10034, 10032, 12461)
USE teploradost;
SELECT p.id, p.title, p.upc, c.title FROM products_uk as p 
left join products_categories as pc ON pc.id_products=p.id
left join categories_uk as c ON c.id=pc.id_categories
WHERE p.is_show=1 AND p.id NOT IN(SELECT p.id FROM products_uk as p
left join products_filter_fields as pff ON pff.id_products=p.id
left join filter_fields_uk as ff ON ff.id=pff.id_filter_fields
WHERE ff.id_filters IN(10021, 10034, 10032, 12461));

-- ################################################

-- Select all products have id_filters=10021
USE teploradost;
SELECT p.id, p.title, p.upc, c.title FROM products_uk p 
LEFT JOIN products_filter_fields as pff ON pff.id_products=p.id 
LEFT JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields
left join products_categories as pc ON pc.id_products=p.id
left join categories_uk as c ON c.id=pc.id_categories
WHERE ff.id_filters=10021 and p.is_show=1;

-- ##############################

USE teploradost_com_ua;

SELECT p.product_id, pd.name, p.status, p.model, p.upc, ovd.name as znachennya, od.name FROM oc_product p 
LEFT JOIN oc_product_description pd ON pd.product_id=p.product_id AND pd.language_id=3 
LEFT JOIN oc_ocfilter_option_value_to_product as ovp ON p.product_id=ovp.product_id 
LEFT JOIN oc_ocfilter_option_value_description as ovd ON ovp.value_id=ovd.value_id AND ovd.language_id=3 
LEFT JOIN oc_ocfilter_option_description as od ON od.option_id=ovp.option_id AND ovd.language_id=3 
WHERE ovp.option_id=10021 AND ovp.value_id>0;

USE teploradost;

SELECT p.id, p.title, p.is_show, p.model, p.upc, ff.title as znachennya, od.name FROM products_uk p 
LEFT JOIN products_filter_fields as pff ON pff.id_products=p.id 
LEFT JOIN filter_fields_uk as ff ON ff.id=pff.id_filter_fields
WHERE ff.id_filters=10021;


SELECT p.product_id, pd.name, p.status, p.model, p.upc, ovd.name as znachennya, od.name
FROM teploradost_com_ua.oc_product p
LEFT JOIN teploradost_com_ua.oc_product_description pd ON pd.product_id = p.product_id AND pd.language_id = 3
LEFT JOIN teploradost_com_ua.oc_ocfilter_option_value_to_product as ovp ON p.product_id = ovp.product_id
LEFT JOIN teploradost_com_ua.oc_ocfilter_option_value_description as ovd ON ovp.value_id = ovd.value_id AND ovd.language_id = 3
LEFT JOIN teploradost_com_ua.oc_ocfilter_option_description as od ON od.option_id = ovp.option_id AND ovd.language_id = 3
WHERE ovp.option_id = 100034 AND ovp.value_id > 0
AND NOT EXISTS (
    SELECT 1
    FROM teploradost.products_uk p2
    LEFT JOIN teploradost.products_filter_fields as pff ON pff.id_products = p2.id
    LEFT JOIN teploradost.filter_fields_uk as ff ON ff.id = pff.id_filter_fields
    WHERE ff.id_filters = 10034
    AND p2.id = p.product_id -- Adjust this based on the actual column linking the two tables
);

-- #################



DROP PROCEDURE IF EXISTS sync_attr_old_db;
DELIMITER $$
CREATE PROCEDURE sync_attr_old_db()
BEGIN
   DECLARE cursor_List_isdone BOOLEAN DEFAULT FALSE;
   DECLARE cur_product_id INT;
   DECLARE cur_value TEXT;
   DECLARE option_id INT DEFAULT 12154;
   DECLARE ru INT DEFAULT 1;
   DECLARE ua INT DEFAULT 3;

   DECLARE cursor_List CURSOR FOR 
    SELECT p.product_id, ovd.name FROM oc_product p 
    LEFT JOIN oc_ocfilter_option_value_to_product as ovp ON p.product_id=ovp.product_id 
    LEFT JOIN oc_ocfilter_option_value_description as ovd ON ovp.value_id=ovd.value_id AND ovd.language_id=ru 
    LEFT JOIN oc_ocfilter_option_description as od ON od.option_id=ovp.option_id AND ovd.language_id=ru 
    WHERE p.status=1 AND ovp.option_id=option_id AND ovp.value_id>0
    ;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;

   OPEN cursor_List;

   loop_List: LOOP
      FETCH cursor_List INTO cur_product_id, cur_value;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;

      INSERT INTO temp_attribute(product_id, attr_name) VALUES(cur_product_id, cur_value);

   END LOOP loop_List;

   CLOSE cursor_List;
END

$$

DELIMITER ;

CALL sync_attr_old_db();


