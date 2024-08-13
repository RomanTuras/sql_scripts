SELECT p.product_id, p.upc, pc.1c_id, pd.name FROM oc_product p 
LEFT JOIN oc_product_to_1c pc ON p.product_id = pc.product_id
LEFT JOIN oc_product_description pd ON p.product_id = pd.product_id AND pd.language_id=1 
WHERE p.product_id IN (77725,77737,77738,77792,77901);



SELECT p.product_id, p.upc, pc.1c_id, pd.name FROM oc_product p 
LEFT JOIN oc_product_to_1c pc ON p.product_id = pc.product_id
LEFT JOIN oc_product_description pd ON p.product_id = pd.product_id AND pd.language_id=1 
WHERE 1c_id LIKE '1f2a9584-0c4e-11ea-b1a3-005056b1440a' OR 1c_id LIKE '24c134e7-bf56-11ed-a49e-005056988a75'  

SELECT p.product_id, model, upc FROM oc_product p 
LEFT JOIN oc_product_description d ON p.product_id = d.product_id 
WHERE d.product_id IS NULL

SELECT * FROM oc_product WHERE `credit` = 0 AND (`chast`=1 AND `rassroch`=1) AND `status`=1;
UPDATE `oc_product` SET `credit`=1 WHERE `product_id` IN(1974,1975,10799,10801,10805,10806,10807,16268,16278,16279,16280,16281,16282,16283,16284,16285,16286,16287,16288,16289,16290,16291,16292,16293,16294,16295,16296,16297,16298,16299,16300,16301,16302,16303,16304,22172,22173,22174,22176,22177,22178,22179,22180,22181,22182,22183,22184,22185,22186,22187,22188,22189,22190,22191,22192,22194,22195,23041,23042,23044,23048,23050,23051,23052,23053,23322,23325,23326,23327,23328,23329,23330,23332,23333,23334,55384,79328,79987,79988,80164,80165,81677,81678,81679,81680,81681);


-- ######### Mono Bank & Privat Bank Tasks ##############

-- Privat
SELECT `product_id` FROM `oc_product_description` WHERE (`name` like '%cooper%' and `name` like '%Кондиционер%' and `language_id`=1) OR ((`name` like '%cooper%' and `name` like '%блок%' and `language_id`=1) and `name` not like '%теплового%');

SELECT `product_id` FROM `oc_product_description` WHERE (`name` like '%cooper%' and `name` like '%блок%' and `language_id`=1) and `name` not like '%теплового%';

UPDATE `oc_product_privat` SET `partscount_pp`=10 WHERE `product_id` IN();

-- Mono
SELECT p.product_id FROM `oc_product` as pd 
LEFT JOIN `oc_product_description` as p ON p.product_id = pd.product_id 
AND price > 10000 AND price IS NOT NULL WHERE (`name` like '%Nexans%' OR `name` like '%Mario%') and `language_id`=1;

SELECT p.product_id, name, price FROM `oc_product` as pd 
LEFT JOIN `oc_product_description` as p ON p.product_id = pd.product_id 
AND price > 10000 AND price IS NOT NULL 
WHERE (`name` like '%BWT%' 
OR `name` like '%Ecosoft%' 
OR `name` like '%Paffoni%' 
OR `name` like '%Salus%' 
OR `name` like '%Tesy%' 
OR `name` like '%Hemstedt%') 
AND `language_id`=1;

UPDATE `oc_product` SET `cat_parts`='10,9,8,7,6,5,4,3,2' WHERE `product_id` IN(4116,86421,9974,9961,3441,3433,49220,9949,3469,3463,59766,24564,3472,4117,3461,9979,3447,3464,3435,9950,9962,3604,49221,66613,72951,86416,3438,86417,3470,3454,43939,3457,24565,3481,86445,3468,59163,86446,59665,3445,9951,86437,86412,86438,86413,9963,3440,3466,66608,9964,3485,3431,72952,9980,3449,49222,62416,3465,86432,9952,3483,3462,63288,9929,3442,86414,86415,3432,66609,3437,3459,66604,3443,3482,3605,86433,66605,3473,86434,66614,59809,49223,86410,3446,9953,3436,86411,86442,86443,3450,3606,3467,3471,72950,3458,9954,9965,3486,86435,86444,76883,3455,86436,49225,72949,3484,66607,86430,86431,9966,3434,9955,3451,3452,3460,3439,3444,3448,76884,66074,9956,60035,59977,3453,3429,3456,59666,3430);

-- ######### ############################### ##############

DROP PROCEDURE IF EXISTS _tmp_fill_description;
DELIMITER $$
CREATE PROCEDURE _tmp_fill_description()
BEGIN
   DECLARE cursor_List_isdone BOOLEAN DEFAULT FALSE;
   DECLARE cur_product_id INT;

   DECLARE cursor_List CURSOR FOR 
    SELECT p.product_id FROM oc_product p 
    LEFT JOIN oc_product_description d ON p.product_id = d.product_id 
    WHERE d.product_id IS NULL
    ;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;

   OPEN cursor_List;

   loop_List: LOOP
      FETCH cursor_List INTO cur_product_id;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;

      INSERT IGNORE INTO `oc_product_description` (`product_id`, `language_id`, `name`, `description`) VALUES (cur_product_id, 1, CONCAT('test',cur_product_id) , 'Test description');

   END LOOP loop_List;

   CLOSE cursor_List;
END

$$

DELIMITER ;

CALL _tmp_fill_description();



SELECT * FROM `oc_product_to_1c` pc 
WHERE 1 GROUP BY `1c_id` HAVING COUNT(`1c_id`) > 1;

SHOW PROCESSLIST;


-- searching doubles by guid
SELECT  *
FROM    oc_product_to_1c mto
WHERE   EXISTS
        (
        SELECT  1
        FROM    oc_product_to_1c mti
        WHERE   mti.1c_id = mto.1c_id
        LIMIT 1, 1
        )
ORDER BY 1c_id



-- searching doubles by id
-- represent in the result all duplicated rows
SELECT  ptc.product_id, 1c_id, p.status, p.date_added, p.date_modified  
FROM  oc_product_to_1c ptc 
LEFT JOIN oc_product p ON ptc.product_id=p.product_id 
WHERE  EXISTS
        (
        SELECT  1
        FROM    oc_product_to_1c ptcii
        WHERE   ptcii.product_id = ptc.product_id
        LIMIT 1, 1
        )
ORDER BY product_id



-- 
WHERE name REGEXP '[0-9]х[0-9]'

WHERE name REGEXP_SUBSTR(name, '[0-9]х[0-9]')  


-- ####################################

-- Restoring product name from backup table 
-- where new name != backup name AND backup table name is `oc_product_description_n`
-- Starting for each language ID - 1,3
DROP PROCEDURE IF EXISTS restore_product_name;
DELIMITER $$
CREATE PROCEDURE restore_product_name()
BEGIN
   DECLARE cursor_List_isdone BOOLEAN DEFAULT FALSE;
   DECLARE cur_product_id INT;
   DECLARE cur_name TEXT;

   DECLARE cursor_List CURSOR FOR 
    SELECT product_id, name 
    FROM oc_product_description_n
    WHERE language_id=1
    ;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;

   OPEN cursor_List;

   loop_List: LOOP
      FETCH cursor_List INTO cur_product_id, cur_name;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;

      IF NOT EXISTS (
        SELECT product_id FROM oc_product_description 
        WHERE product_id = cur_product_id AND name LIKE cur_name AND language_id=1) 
      THEN 
        UPDATE `oc_product_description` SET `name`=cur_name WHERE product_id=cur_product_id AND language_id=1;
      END IF;

   END LOOP loop_List;

   CLOSE cursor_List;
END

$$

DELIMITER ;

CALL restore_product_name();

-- END procedure ####################################


-- ########################

SELECT pr.product_id, related_id, pd.name FROM `oc_product_related` pr 
LEFT JOIN oc_product_description pd ON pr.product_id=pd.product_id
WHERE pr.product_id=related_id AND pd.language_id=1

-- ########################



UPDATE `oc_product_description` SET `name`=REPLACE(name, '/ ', '/') WHERE name LIKE '%/ %';

UPDATE `oc_product_description` SET `description`=REPLACE(description, ' /', '/') WHERE description LIKE '% /%';


SELECT p.product_id, 1c_id, p.status, p.image
FROM oc_product p 
LEFT JOIN oc_product_to_1c pc ON p.product_id=pc.product_id 
WHERE p.status=0 AND (p.image IS NULL OR p.image LIKE '') AND 
NOT EXISTS (SELECT product_id FROM oc_product_to_category pc WHERE pc.product_id=p.product_id);


SELECT p.product_id, image, status 
FROM oc_product p 
WHERE 
p.status=0 AND (p.image IS NULL OR p.image LIKE '') AND 
NOT EXISTS (SELECT product_id FROM oc_product_to_category pc WHERE pc.product_id=p.product_id) 
AND p.product_id IN(5711,5713,5714,5715,5718,5720);

oc_product_attribute
oc_product_description
oc_product_image
oc_product_newtabcontent
oc_product_privat
oc_product_related
oc_product_reward
oc_product_special
oc_product_to_1c
oc_product_to_category
oc_product_to_download
oc_product_to_layout
oc_product_to_store
oc_product_variations


-- ####################



-- ##################
DROP PROCEDURE IF EXISTS delete_products;
DELIMITER $$
CREATE PROCEDURE delete_products()
BEGIN
   DECLARE cursor_List_isdone BOOLEAN DEFAULT FALSE;
   DECLARE cur_product_id INT;
   DECLARE cur_name TEXT;
   DECLARE cur_finded TEXT;
   DECLARE cur_replaced TEXT;
   DECLARE cur_new_name TEXT;

   DECLARE cursor_List CURSOR FOR 
      SELECT p.product_id
      FROM oc_product p 
      WHERE 
      p.status=0 AND (p.image IS NULL OR p.image LIKE '') AND 
      NOT EXISTS (SELECT product_id FROM oc_product_to_category pc WHERE pc.product_id=p.product_id) 
    ;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;

   OPEN cursor_List;

   loop_List: LOOP
      FETCH cursor_List INTO cur_product_id;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;

      DELETE FROM oc_product WHERE `product_id`=cur_product_id;
      DELETE FROM oc_product_attribute WHERE `product_id`=cur_product_id;
      DELETE FROM oc_product_description WHERE `product_id`=cur_product_id;
      DELETE FROM oc_product_image WHERE `product_id`=cur_product_id;
      DELETE FROM oc_product_newtabcontent WHERE `product_id`=cur_product_id;
      DELETE FROM oc_product_privat WHERE `product_id`=cur_product_id;
      DELETE FROM oc_product_related WHERE `product_id`=cur_product_id;
      DELETE FROM oc_product_reward WHERE `product_id`=cur_product_id;
      DELETE FROM oc_product_special WHERE `product_id`=cur_product_id;
      DELETE FROM oc_product_to_1c WHERE `product_id`=cur_product_id;
      DELETE FROM oc_product_to_category WHERE `product_id`=cur_product_id;
      DELETE FROM oc_product_to_download WHERE `product_id`=cur_product_id;
      DELETE FROM oc_product_to_layout WHERE `product_id`=cur_product_id;
      DELETE FROM oc_product_to_store WHERE `product_id`=cur_product_id;
      DELETE FROM oc_product_variations WHERE `product_id`=cur_product_id;

   END LOOP loop_List;

   CLOSE cursor_List;
END
$$

DELIMITER ;

CALL delete_products();

-- #################################################









UPDATE products_uk SET cat_parts='5,4,3,2' WHERE cat_parts not like '10%';

select count(cat_parts) from products_uk WHERE cat_parts not like '10%';


UPDATE products_ru SET quantity=999 WHERE is_show=1 AND quantity=0;

select count(*) from products_ru WHERE is_show=1 AND quantity=0;


-- searching not existed products from related
SELECT pp.id_products
FROM  products_products pp
WHERE NOT EXISTS (SELECT p.id FROM products_uk p WHERE p.id = pp.id_products)
GROUP BY pp.id_products

-- searching not existed related products from related
SELECT pp.id_products_other
FROM  products_products pp
WHERE NOT EXISTS (SELECT p.id FROM products_uk p WHERE p.id = pp.id_products_other)
GROUP BY pp.id_products_other;


DELETE FROM products_products WHERE id_products IN(7554,7555,7556,7557,7558,7559,7560,10128,10131,10134,10135,11065,15556,15557,15558,15559,15560,15561,15562,15563,15572,15579,15580,15581,15582,15650,15651,15652,15677,15678,15679,15680,15681,15682,15683,15684,15685,15686,15687,15688,15690,15772,15773,15774,15775,15776,15777,15778,15779,15788,15795,15796,15797,15798,15865,15866,15867,15892,15893,15894,15895,15896,15897,15898,15899,15900,15901,15902,15903,15905,96023,96024)
DELETE FROM products_products WHERE id_products_other IN(7189,28385,28386,28387,28388,28389,28390,28391,28392,28393,28394,28396,30605,47815,47967,48386,48389,48391,48394,48397,48400,48403,48406,48409,50204,94903)


USE teploradost;
SELECT * FROM categories_ru c 
LEFT JOIN products_categories pc ON c.id=pc.id_categories WHERE pc.id_products IN(79333,79334,1541);

SELECT DISTINCT(title_variant), COUNT(title_variant) AS c FROM products_uk GROUP BY title_variant ORDER BY c DESC;
SELECT DISTINCT(title), COUNT(title) AS c FROM attributes_uk GROUP BY title ORDER BY c DESC;


UPDATE products_uk SET title_variant="Варіант" WHERE title_variant="варіант";
UPDATE products_uk SET title_variant="Варіант" WHERE title_variant="Вариант";
UPDATE products_uk SET title_variant="Варіант" WHERE title_variant="варіанти:";
UPDATE products_uk SET title_variant="Кількість контурів" WHERE title_variant="Количество контуров";
UPDATE products_uk SET title_variant="Об'єм (л)" WHERE title_variant="Объем (л)";
UPDATE products_uk SET title_variant="Висота (мм)" WHERE title_variant="Высота (мм):";
UPDATE products_uk SET title_variant="Висота (мм)" WHERE title_variant="Высота (мм)";
UPDATE products_uk SET title_variant="Площа приміщення (м2)" WHERE title_variant="Площадь помещения (м2)";
UPDATE products_uk SET title_variant="Довжина (мм)" WHERE title_variant="Длина (мм) ";
UPDATE products_uk SET title_variant="Довжина (мм)" WHERE title_variant="Длинна (мм)";
UPDATE products_uk SET title_variant="Кількість секцій" WHERE title_variant="Количество секций";
UPDATE products_uk SET title_variant="Колір" WHERE title_variant="Цвет";
UPDATE products_uk SET title_variant="Опалювальна площа (м2)" WHERE title_variant="Отапливаемая площадь (м2)";
UPDATE products_uk SET title_variant="Довжина кабелю (м)" WHERE title_variant="Длина кабеля (м)";
UPDATE products_uk SET title_variant="Об'єм води (л)" WHERE title_variant="Объем воды (л)";
UPDATE products_uk SET title_variant="Потужність (кВт)" WHERE title_variant="Мощность (кВт)";
UPDATE products_uk SET title_variant="Різьбове з'єднання (дюйми)" WHERE title_variant="Резьбовое соединение (дюймы)";
UPDATE products_uk SET title_variant="Діаметр (мм)" WHERE title_variant="Диаметр (мм)";
UPDATE products_uk SET title_variant="Міжосьова відстань (мм)" WHERE title_variant="Межосевое расстояние (мм)";
UPDATE products_uk SET title_variant="Потужність (Вт)" WHERE title_variant="Мощность (Вт)";
UPDATE products_uk SET title_variant="Продуктивність (кБТЕ/год)" WHERE title_variant="Производительность (кБТЕ/ч)";
UPDATE products_uk SET title_variant="Теплова потужність (кВт):" WHERE title_variant="Тепловая мощность (кВт):";
UPDATE products_uk SET title_variant="Теплова потужність (кВт)" WHERE title_variant="Теплова потужність (кВт):";


UPDATE products_uk SET title_variant="Об'єм (л)" WHERE title_variant="Обсяг (л)";
UPDATE products_uk SET title_variant="Об'єм води (л)" WHERE title_variant="Объем воды";
UPDATE products_uk SET title_variant="Об'єм бака (л)" WHERE title_variant="Объем бака (л)";


UPDATE products_uk SET video='' WHERE video LIKE 'ei5tNn8G9Aw' OR video LIKE 'OYsIfWcbE7Y' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'GvtIAOlGaW9' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'kmm8gpt_7Po' OR video LIKE 'kmm8gpt_7Po' OR video LIKE 'KxfJiQHIDCs' OR video LIKE '0Bm9NQ9gA_E' OR video LIKE 'f-Y0u31PMmY' OR video LIKE 'ZU8_8X-ucEU' OR video LIKE '0Bm9NQ9gA_E' OR video LIKE 'f-Y0u31PMmY' OR video LIKE 'ZU8_8X-ucEU' OR video LIKE '0010021634' OR video LIKE 'ZePWix7g-FI' OR video LIKE 'ZePWix7g-FI' OR video LIKE 'ZePWix7g-FI' OR video LIKE 'ZePWix7g-FI' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE '9T3Ps0x7Tjk' OR video LIKE '9T3Ps0x7Tjk' OR video LIKE 'zj0eN6QZw79' OR video LIKE 'GeYCYIqZ3k' OR video LIKE '1rNu-_p0yC1' OR video LIKE '1rNu-_p0yC2' OR video LIKE '1rNu-_p0yC3' OR video LIKE '1rNu-_p0yC4' OR video LIKE '1rNu-_p0yC1' OR video LIKE '1rNu-_p0yC2' OR video LIKE '1rNu-_p0yC3' OR video LIKE '1rNu-_p0yC4' OR video LIKE 'OnyA79ic8U';

SELECT id, video FROM products_uk WHERE video LIKE 'ei5tNn8G9Aw' OR video LIKE 'OYsIfWcbE7Y' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'GvtIAOlGaW9' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'kmm8gpt_7Po' OR video LIKE 'kmm8gpt_7Po' OR video LIKE 'KxfJiQHIDCs' OR video LIKE '0Bm9NQ9gA_E' OR video LIKE 'f-Y0u31PMmY' OR video LIKE 'ZU8_8X-ucEU' OR video LIKE '0Bm9NQ9gA_E' OR video LIKE 'f-Y0u31PMmY' OR video LIKE 'ZU8_8X-ucEU' OR video LIKE '0010021634' OR video LIKE 'ZePWix7g-FI' OR video LIKE 'ZePWix7g-FI' OR video LIKE 'ZePWix7g-FI' OR video LIKE 'ZePWix7g-FI' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE 's0nn0k2cx_w' OR video LIKE '9T3Ps0x7Tjk' OR video LIKE '9T3Ps0x7Tjk' OR video LIKE 'zj0eN6QZw79' OR video LIKE 'GeYCYIqZ3k' OR video LIKE '1rNu-_p0yC1' OR video LIKE '1rNu-_p0yC2' OR video LIKE '1rNu-_p0yC3' OR video LIKE '1rNu-_p0yC4' OR video LIKE '1rNu-_p0yC1' OR video LIKE '1rNu-_p0yC2' OR video LIKE '1rNu-_p0yC3' OR video LIKE '1rNu-_p0yC4' OR video LIKE 'OnyA79ic8U';


SELECT ffu.*, ffr.*, f.title FROM teploradost.filter_fields_uk as ffu 
LEFT JOIN teploradost.filter_fields_ru as ffr ON ffu.id=ffr.id 
LEFT JOIN teploradost.filters_uk as f ON ffu.id_filters=f.id;


select count(*) as aggregate from `products_uk` where (`title` LIKE '%Бойлер%' or `model` LIKE '%Бойлер%' or `upc` LIKE '%Бойлер%') and `is_show` = 1

select `products_uk`.*, (select count(*) from `reviews` 
where `products_uk`.`id` = `reviews`.`id_products` and `is_show` = 1) as `reviews_count`, 
(select avg(`reviews`.`rating`) from `reviews` where `products_uk`.`id` = `reviews`.`id_products` and `is_show` = 1) as `reviews_avg_rating` 
from `products_uk` 
where (`title` LIKE '%Бойлер%' or `model` LIKE '%Бойлер%' or `upc` LIKE '%Бойлер%') and `is_show` = 1 
order by (select `id` from `statuses_uk` where `statuses_uk`.`id` = `products_uk`.`id_statuses`) desc, `sort` desc limit 5 offset 0

select * from `statuses_uk` where `statuses_uk`.`id` in (7)

select `tags_uk`.*, `products_tags`.`id_products` as `pivot_id_products`, `products_tags`.`id_tags` as `pivot_id_tags` 
from `tags_uk` inner join `products_tags` on `tags_uk`.`id` = `products_tags`.`id_tags` 
where `products_tags`.`id_products` in (13112, 98841, 98842, 98843, 100132)

select * from `saved` where `saved`.`id_products` in (13112, 98841, 98842, 98843, 100132)

select * from `promotions` 
where `promotions`.`id_products` in (13112, 98841, 98842, 98843, 100132) 
and ((`date_start` <= '2023-11-22' and `date_end` >= '2023-11-22') 
or (`date_start` = '0000-00-00' or `date_end` = '0000-00-00'))

select `products_uk`.*, (select count(*) from `reviews` where `products_uk`.`id` = `reviews`.`id_products` and `is_show` = 1) as `reviews_count`, 
(select avg(`reviews`.`rating`) from `reviews` where `products_uk`.`id` = `reviews`.`id_products` and `is_show` = 1) as `reviews_avg_rating` 
from `products_uk` where (`title` LIKE '%Бойлер%' or `model` LIKE '%Бойлер%' or `upc` LIKE '%Бойлер%') and `is_show` = 1 
order by (select `id` from `statuses_uk` where `statuses_uk`.`id` = `products_uk`.`id_statuses`) desc, `sort` desc limit 5 offset 0

select * from `statuses_uk` where `statuses_uk`.`id` in (7)

select `tags_uk`.*, `products_tags`.`id_products` as `pivot_id_products`, `products_tags`.`id_tags` as `pivot_id_tags` 
from `tags_uk` inner join `products_tags` on `tags_uk`.`id` = `products_tags`.`id_tags` 
where `products_tags`.`id_products` in (13112, 98841, 98842, 98843, 100132)

select * from `saved` where `saved`.`id_products` in (13112, 98841, 98842, 98843, 100132)

select * from `promotions` 
where `promotions`.`id_products` in (13112, 98841, 98842, 98843, 100132) 
and ((`date_start` <= '2023-11-22' and `date_end` >= '2023-11-22') or (`date_start` = '0000-00-00' or `date_end` = '0000-00-00'))


select id, video from products_uk where video LIKE 'ei5tNn8G9Aw' OR video LIKE 'OYsIfWcbE7Y' OR video LIKE 'wqJ3L3ZLgvY' OR video LIKE 'GvtIAOlGaW9' OR video LIKE 'kmm8gpt_7Po' OR video LIKE 'KxfJiQHIDCs' OR video LIKE '0Bm9NQ9gA_E' OR video LIKE 'f-Y0u31PMmY' OR video LIKE 'ZU8_8X-ucEU' OR video LIKE '0010021634' OR video LIKE 'ZePWix7g-FI' OR video LIKE 'AjefuDWJfGY' OR video LIKE 's0nn0k2cx_w' OR video LIKE 'XXf9kOKH_ps' OR video LIKE '9T3Ps0x7Tjk' OR video LIKE 'zj0eN6QZw79' OR video LIKE 'GeYCYIqZ3k' OR video LIKE '1rNu-_p0yC1' OR video LIKE '1rNu-_p0yC2' OR video LIKE '1rNu-_p0yC3' OR video LIKE '1rNu-_p0yC4';



-- searching doubles by guid
SELECT  *
FROM    products_filter_fields mto
WHERE   EXISTS
        (
        SELECT  1
        FROM    products_filter_fields mti
        WHERE   mti.1c_id = mto.1c_id
        LIMIT 1, 1
        )
ORDER BY 1c_id




SELECT * FROM teploradost.products_ru where LENGTH(content)<120;

UPDATE teploradost.products_ru SET content='' WHERE LENGTH(content)<120;