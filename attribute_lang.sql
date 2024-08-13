DROP PROCEDURE IF EXISTS get_skipped_language_attribute;
DELIMITER $$
CREATE PROCEDURE get_skipped_language_attribute()
BEGIN
   DECLARE cursor_List_isdone BOOLEAN DEFAULT FALSE;
   DECLARE cur_product_id INT;
   DECLARE cur_attribute_id INT;
   DECLARE cur_name TEXT;
   DECLARE cur_attr_name TEXT;
   DECLARE cur_attr_text TEXT;
   DECLARE ru INT DEFAULT 1;
   DECLARE ua INT DEFAULT 3;

   DECLARE cursor_List CURSOR FOR 
    SELECT pa.product_id, pa.attribute_id, pd.name, pa.text 
    FROM oc_product_attribute pa
    LEFT JOIN oc_product p ON p.product_id = pa.product_id AND p.status = 1 
    LEFT JOIN oc_product_description pd ON pa.product_id = pd.product_id AND pd.language_id = ru
    WHERE pa.language_id = ru
    ;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;

   OPEN cursor_List;

   loop_List: LOOP
      FETCH cursor_List INTO cur_product_id, cur_attribute_id, cur_name, cur_attr_text;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;

      IF NOT EXISTS (
        SELECT product_id FROM oc_product_attribute 
        WHERE product_id = cur_product_id AND attribute_id = cur_attribute_id AND language_id = ua) 
      THEN 
        INSERT INTO oc_product_attribute(product_id, attribute_id, language_id, text) VALUES(cur_product_id, cur_attribute_id, ua, cur_attr_text);
      END IF;

   END LOOP loop_List;

   CLOSE cursor_List;
END

$$

DELIMITER ;

CALL get_skipped_language_attribute();


-- ################################

DROP PROCEDURE IF EXISTS get_skipped_language_attribute;
DELIMITER $$
CREATE PROCEDURE get_skipped_language_attribute()
BEGIN
   DECLARE cursor_List_isdone BOOLEAN DEFAULT FALSE;
   DECLARE cur_product_id INT;
   DECLARE cur_attribute_id INT;
   DECLARE cur_name TEXT;
   DECLARE cur_attr_name TEXT;
   DECLARE cur_attr_text TEXT;
   DECLARE ru INT DEFAULT 3;
   DECLARE ua INT DEFAULT 1;

   DECLARE cursor_List CURSOR FOR 
    SELECT pa.product_id, pa.attribute_id, pd.name, ad.name, pa.text 
    FROM oc_product_attribute pa
    LEFT JOIN oc_product p ON p.product_id = pa.product_id AND p.status = 1 
    LEFT JOIN oc_product_description pd ON pa.product_id = pd.product_id AND pd.language_id = ru
    LEFT JOIN oc_attribute_description ad ON ad.attribute_id = pa.attribute_id AND ad.language_id = ru
    WHERE pa.language_id = ru
    ;

   DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_List_isdone = TRUE;

   OPEN cursor_List;

   loop_List: LOOP
      FETCH cursor_List INTO cur_product_id, cur_attribute_id, cur_name, cur_attr_name, cur_attr_text;
      IF cursor_List_isdone THEN
        LEAVE loop_List;
      END IF;

      IF NOT EXISTS (
        SELECT product_id FROM oc_product_attribute 
        WHERE product_id = cur_product_id AND attribute_id = cur_attribute_id AND language_id = ua) 
      THEN 
        INSERT INTO temp_attribute(product_id, name, attribute_id, attr_name, lang_id) VALUES(cur_product_id, cur_name, cur_attribute_id, cur_attr_name, ua);
      END IF;

   END LOOP loop_List;

   CLOSE cursor_List;
END

$$

DELIMITER ;

CALL get_skipped_language_attribute();

-- ###################################################################


INSERT INTO oc_product_attribute(product_id, attribute_id, language_id, text) VALUES(cur_product_id, cur_attribute_id, 3, cur_attr_text);

CREATE TABLE IF NOT EXISTS temp_attribute (
  product_id INT,
  name TEXT,
  attribute_id INT,
  attr_name TEXT,
  lang_id INT
);

-- ###############################################

UPDATE `oc_product_attribute` SET `text`='Внутрішня-Зовнішня' WHERE `language_id`=3 AND `text`='Внутренняя-Наружная';
UPDATE `oc_product_attribute` SET `text`='Внутрішня-Зовнішня-Внутрішня' WHERE `language_id`=3 AND `text`='Внутренняя-Наружная-Внутренняя';
UPDATE `oc_product_attribute` SET `text`='Німеччина' WHERE `language_id`=3 AND `text`='Германия';
UPDATE `oc_product_attribute` SET `text`='Опція' WHERE `language_id`=3 AND `text`='опция';
UPDATE `oc_product_attribute` SET `text`='Франція' WHERE `language_id`=3 AND `text`='Франция';
UPDATE `oc_product_attribute` SET `text`='Сталь оцинкована' WHERE `language_id`=3 AND `text`='Сталь оцинкованная';
UPDATE `oc_product_attribute` SET `text`='Білий' WHERE `language_id`=3 AND `text`='Белый';
UPDATE `oc_product_attribute` SET `text`='Силіконовий герметик' WHERE `language_id`=3 AND `text`='Силиконовый герметик';
UPDATE `oc_product_attribute` SET `text`='Для герметичного ущільнення навколо санітарних пристроїв' WHERE `language_id`=3 AND `text`='Для герметичного уплотнения вокруг санитарных устройств';
UPDATE `oc_product_attribute` SET `text`='Внутрішня-Зовнішня' WHERE `language_id`=3 AND `text`='Внутренняя-Наружная';
UPDATE `oc_product_attribute` SET `text`='50 шт. при встановленому радіомодулі' WHERE `language_id`=3 AND `text`='50 шт. при установленном радиомодуле';
UPDATE `oc_product_attribute` SET `text`='Відкрита' WHERE `language_id`=3 AND `text`='Открытая';
UPDATE `oc_product_attribute` SET `text`='Електронний (автоматичний)' WHERE `language_id`=3 AND `text`='Электронный (автоматический)';
UPDATE `oc_product_attribute` SET `text`='Чорний' WHERE `language_id`=3 AND `text`='Черный';
UPDATE `oc_product_attribute` SET `text`='Так' WHERE `language_id`=3 AND `text`='Да';
UPDATE `oc_product_attribute` SET `text`='Горизонтальна' WHERE `language_id`=3 AND `text`='Горизонтальная';
UPDATE `oc_product_attribute` SET `text`='Сепаратор шламу' WHERE `language_id`=3 AND `text`='Сепаратор шлама';
UPDATE `oc_product_attribute` SET `text`='Гільза' WHERE `language_id`=3 AND `text`='Гильза';
UPDATE `oc_product_attribute` SET `text`='Трійник' WHERE `language_id`=3 AND `text`='Тройник';
UPDATE `oc_product_attribute` SET `text`='Закрита' WHERE `language_id`=3 AND `text`='Закрытая';
UPDATE `oc_product_attribute` SET `text`='Конвектор із примусовою конвекцією' WHERE `language_id`=3 AND `text`='Конвектор с принудительной конвекцией';
UPDATE `oc_product_attribute` SET `text`='Нержавіюча сталь' WHERE `language_id`=3 AND `text`='Нержавеющая сталь';
UPDATE `oc_product_attribute` SET `text`='Україна' WHERE `language_id`=3 AND `text`='Украина';
UPDATE `oc_product_attribute` SET `text`='Внутрішньопідлоговий конвектор/ Решітка купується окремо (є в супутніх товарах до кожного конвектора)' WHERE `language_id`=3 AND `text`='Внутрипольный конвектор/ Решетка приобретается отдельно (есть в сопутствующих товарах к каждому конвектору)';
UPDATE `oc_product_attribute` SET `text`='Підлоговий' WHERE `language_id`=3 AND `text`='Напольный';
UPDATE `oc_product_attribute` SET `text`='Помаранчево-чорний' WHERE `language_id`=3 AND `text`='Оранжево-черный';
UPDATE `oc_product_attribute` SET `text`='Ні' WHERE `language_id`=3 AND `text`='Нет';
UPDATE `oc_product_attribute` SET `text`='Двоконтурний' WHERE `language_id`=3 AND `text`='Двухконтурный';
UPDATE `oc_product_attribute` SET `text`='Турбований' WHERE `language_id`=3 AND `text`='Турбированный';
UPDATE `oc_product_attribute` SET `text`='Мідь (вторинний - із нержавіючої сталі)' WHERE `language_id`=3 AND `text`='Медь (вторичный - из нержавеющей стали)';
UPDATE `oc_product_attribute` SET `text`='Настінний' WHERE `language_id`=3 AND `text`='Настенный';
UPDATE `oc_product_attribute` SET `text`='Конвекційний' WHERE `language_id`=3 AND `text`='Конвекционный';
UPDATE `oc_product_attribute` SET `text`='Італія' WHERE `language_id`=3 AND `text`='Италия';
UPDATE `oc_product_attribute` SET `text`='1-бітермічний' WHERE `language_id`=3 AND `text`='1-битермический';
UPDATE `oc_product_attribute` SET `text`='Вентиляційна (примусове відведення продуктів згоряння)' WHERE `language_id`=3 AND `text`='Вентиляционная (принудительный отвод продуктов сгорания)';



UPDATE `oc_product_attribute` SET `text`='Отвод сточных вод' WHERE `language_id`=1 AND `text`='Відведення стічних вод';
UPDATE `oc_product_attribute` SET `text`='Без смесительного узла' WHERE `language_id`=1 AND `text`='Без змішувального вузла';
UPDATE `oc_product_attribute` SET `text`='Для радиаторного отопления' WHERE `language_id`=1 AND `text`='Для радіаторного опалення';
UPDATE `oc_product_attribute` SET `text`='Профильный' WHERE `language_id`=1 AND `text`='Профільний';
UPDATE `oc_product_attribute` SET `text`='Нет' WHERE `language_id`=1 AND `text`='Немає';
UPDATE `oc_product_attribute` SET `text`='Для отопления' WHERE `language_id`=1 AND `text`='Для опалення';
UPDATE `oc_product_attribute` SET `text`='Для теплого пола' WHERE `language_id`=1 AND `text`='Для теплої підлоги';
UPDATE `oc_product_attribute` SET `text`='Без смесительного узла' WHERE `language_id`=1 AND `text`='Без змішувального вузла';
UPDATE `oc_product_attribute` SET `text`='Коллектор' WHERE `language_id`=1 AND `text`='Колектор';
UPDATE `oc_product_attribute` SET `text`='Топливо' WHERE `language_id`=1 AND `text`='паливо';
UPDATE `oc_product_attribute` SET `text`='Для радиаторного отопления' WHERE `language_id`=1 AND `text`='Для радіаторного опалення';
UPDATE `oc_product_attribute` SET `text`='Под заказ' WHERE `language_id`=1 AND `text`='Під замовлення';
UPDATE `oc_product_attribute` SET `text`='Механическая' WHERE `language_id`=1 AND `text`='Механічна';
UPDATE `oc_product_attribute` SET `text`='2-раздельных' WHERE `language_id`=1 AND `text`='2-роздільних';
UPDATE `oc_product_attribute` SET `text`='Закрытая' WHERE `language_id`=1 AND `text`='Закрита';
UPDATE `oc_product_attribute` SET `text`='Боковой' WHERE `language_id`=1 AND `text`='Бічний';
UPDATE `oc_product_attribute` SET `text`='Белый' WHERE `language_id`=1 AND `text`='Білий';
UPDATE `oc_product_attribute` SET `text`='Италия' WHERE `language_id`=1 AND `text`='Італія';
UPDATE `oc_product_attribute` SET `text`='Наружная' WHERE `language_id`=1 AND `text`='Зовнішня';
UPDATE `oc_product_attribute` SET `text`='Полотенцесушитель/ крепление к-кт 4 шт./ паспорт/ кран маевского/ заглушка/ картонная упаковка/ пакет' WHERE `language_id`=1 AND `text`='Сушка для рушників/ кріплення к-кт 4 шт./ паспорт/ кран маєвського/ заглушка/ картона упаковка/ пакет';
UPDATE `oc_product_attribute` SET `text`='Да' WHERE `language_id`=1 AND `text`='Так';
UPDATE `oc_product_attribute` SET `text`='Черный' WHERE `language_id`=1 AND `text`='Чорний';
UPDATE `oc_product_attribute` SET `text`='Проводной' WHERE `language_id`=1 AND `text`='Дротовий';
UPDATE `oc_product_attribute` SET `text`='Электронный' WHERE `language_id`=1 AND `text`='Електронний';
UPDATE `oc_product_attribute` SET `text`='Германия' WHERE `language_id`=1 AND `text`='Німеччина';
UPDATE `oc_product_attribute` SET `text`='Нет' WHERE `language_id`=1 AND `text`='Немає';
UPDATE `oc_product_attribute` SET `text`='Для солнечных систем' WHERE `language_id`=1 AND `text`='Для сонячних систем';
UPDATE `oc_product_attribute` SET `text`='Накладной' WHERE `language_id`=1 AND `text`='Накладний';
UPDATE `oc_product_attribute` SET `text`='Количество заданных гидравлических схем – 7' WHERE `language_id`=1 AND `text`='Кількість заданих гідравлічних схем – 7';
UPDATE `oc_product_attribute` SET `text`='Есть' WHERE `language_id`=1 AND `text`='Є';


SELECT pd.product_id, pd.name 
FROM oc_product_description pd
LEFT JOIN oc_product p ON p.product_id = pd.product_id
WHERE p.product_id IS NULL


UPDATE IGNORE `oc_product_attribute` SET `attribute_id`=28 WHERE `attribute_id`=918;

