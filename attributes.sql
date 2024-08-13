-- ####################################

-- Replace ',' to '.'
DROP PROCEDURE IF EXISTS replace_char_product_name;
DELIMITER $$
CREATE PROCEDURE replace_char_product_name()
BEGIN
   DECLARE cursor_List_isdone BOOLEAN DEFAULT FALSE;
   DECLARE cur_product_id INT;
   DECLARE cur_name TEXT;
   DECLARE cur_finded TEXT;
   DECLARE cur_replaced TEXT;
   DECLARE cur_new_name TEXT;

   DECLARE cursor_List CURSOR FOR 
    SELECT product_id, text, REGEXP_SUBSTR(text, '[а-яА-Я],[ ]') AS finded
    FROM oc_product_attribute 
    WHERE text REGEXP '[а-яА-Я],[ ]'
    ;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;

   OPEN cursor_List;

   loop_List: LOOP
      FETCH cursor_List INTO cur_product_id, cur_name, cur_finded;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;

      SET cur_replaced = REPLACE(cur_finded, ',', '/');
      SET cur_new_name = REPLACE(cur_name, cur_finded, cur_replaced);
      
      UPDATE `oc_product_attribute` 
      SET `text`=cur_new_name 
      WHERE `product_id`=cur_product_id AND text LIKE cur_name;

   END LOOP loop_List;

   CLOSE cursor_List;
END

$$

DELIMITER ;

CALL replace_char_product_name();

-- END procedure ####################################

DROP PROCEDURE IF EXISTS delete_attribute;
DELIMITER $$
CREATE PROCEDURE delete_attribute()
BEGIN
   DECLARE cursor_List_isdone BOOLEAN DEFAULT FALSE;
   DECLARE cur_attribute_id INT;

   DECLARE cursor_List CURSOR FOR 
      SELECT a.attribute_id  
      FROM oc_attribute_description a 
      WHERE 
      NOT EXISTS (SELECT attribute_id FROM oc_product_attribute pa WHERE pa.attribute_id=a.attribute_id)
    ;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;

   OPEN cursor_List;

   loop_List: LOOP
      FETCH cursor_List INTO cur_attribute_id;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;

      DELETE FROM oc_attribute WHERE `attribute_id`=cur_attribute_id;
      DELETE FROM oc_attribute_description WHERE `attribute_id`=cur_attribute_id;

   END LOOP loop_List;

   CLOSE cursor_List;
END

$$

DELIMITER ;

CALL delete_attribute();

-- ############################

SELECT *
FROM `oc_product_attribute` pa 
LEFT JOIN `oc_attribute_description` a ON pa.attribute_id=a.attribute_id 
WHERE `pa.text` LIKE '220'
GROUP BY `pa.attribute_id`

SELECT *
FROM `oc_product_attribute` pa 
LEFT JOIN `oc_attribute_description` a ON pa.attribute_id=a.attribute_id and a.language_id=3
WHERE product_id = 5376 and pa.language_id=3 group by pa.attribute_id


SELECT attribute_id  
FROM oc_attribute_description a 
WHERE 
NOT EXISTS (SELECT attribute_id FROM oc_product_attribute pa WHERE pa.attribute_id=a.attribute_id);

UPDATE `oc_product_attribute` SET `text`='230' WHERE `attribute_id`=17 AND `text` LIKE '220'




SELECT * FROM `oc_product_attribute` WHERE `text` LIKE '%,%'

UPDATE `oc_product_attribute` SET `text`=REPLACE(text, '  ', ' ') WHERE text LIKE '%  %';

UPDATE `oc_product_attribute` SET `text`=REPLACE(text, ',', '/') WHERE text LIKE '%,%' AND attribute_id IN(345, 1991, 638);

SELECT pa.product_id, pa.attribute_id, name, text 
FROM oc_product_attribute pa
LEFT JOIN oc_attribute_description pd ON pa.attribute_id=pd.attribute_id
WHERE text REGEXP '[а-яА-Я],[ ]' AND pa.language_id = 3


attributes 345, 1991, 638  -- change ',' to '/'

-- 04.08.2023 -----------------------------------------------------
SELECT pa.product_id, pd.name, attribute_id, pa.language_id, TRIM(CAST(text AS DECIMAL(10,2))/1000)+0 AS text FROM `oc_product_attribute` pa 
LEFT JOIN oc_product_description pd ON pa.product_id=pd.product_id AND pd.language_id=3
WHERE attribute_id=629

SELECT pa.product_id, pd.name, attribute_id, pa.language_id, text
FROM `oc_product_attribute`
LEFT JOIN oc_product_description pd ON pa.product_id=pd.product_id AND pd.language_id=3
WHERE `attribute_id` =629 AND text < 10



SELECT product_id, attribute_id, text, TRIM(CAST(text AS DECIMAL(10,2))/1000)+0 AS text_new
FROM `oc_product_attribute`
WHERE `attribute_id` =629
AND text >= 10


UPDATE `oc_product_attribute` 
SET `text`=TRIM(CAST(text AS DECIMAL(10,2))/1000)+0,`attribute_id`=917 
WHERE `text`>=10 AND `attribute_id`=629;

-- ----------------------------------------------------------------

-- 07.08.2023 -----------------------------------------------------

SELECT pa.product_id, pd.name, attribute_id, pa.language_id, text
FROM `oc_product_attribute` pa
LEFT JOIN oc_product_description pd ON pa.product_id=pd.product_id AND pd.language_id=3
WHERE `attribute_id` =134


UPDATE `oc_product_attribute` SET `attribute_id`=560 WHERE `attribute_id`=894