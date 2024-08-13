SELECT p.product_id, pd.name, p.price AS price, new.price AS new_price, p.status  FROM `oc_product` p 
LEFT JOIN `oc_product_description` pd ON p.product_id=pd.product_id 
LEFT JOIN `products_ru` new ON p.product_id=new.id 
WHERE 
NOT EXISTS (SELECT id FROM `products_ru` WHERE p.product_id=id) 
OR p.price<>new.price

-- Result:
94677 Труба медная мягкая Sanha 8 х1.0 мм без изоляции (...
96022 Ванна акриловая Knief Lugano Fit 180х80, встраивае...
96023 Ванна квариловая Villeroy&amp;Boch Aveo 190x95 с б...
96024 Ванна акрилова SOANA 160х70 + ніжки

-- *****************************

SELECT uk.id FROM products_uk uk 
LEFT JOIN products_ru ru ON uk.id=ru.id
WHERE uk.is_show=1 AND (
uk.price<>ru.price OR uk.video<>ru.video OR uk.model<>ru.model OR uk.garantia<>ru.garantia 
OR uk.garantia_sum<>ru.garantia_sum OR uk.sku<>ru.sku OR uk.upc<>ru.upc OR uk.ean<>ru.ean 
OR uk.jan<>ru.jan OR uk.isbn<>ru.isbn OR uk.mpn<>ru.mpn OR uk.ship_pay<>ru.ship_pay OR uk.quantity<>ru.quantity OR uk.weight<>ru.weight 
OR uk.length<>ru.length OR uk.width<>ru.width OR uk.height<>ru.height OR uk.subtract<>ru.subtract OR uk.minimum<>ru.minimum 
OR uk.sort<>ru.sort OR uk.is_show<>ru.is_show OR uk.viewed<>ru.viewed OR uk.cat_parts<>ru.cat_parts OR uk.unit<>ru.unit 
OR uk.credit<>ru.credit OR uk.chast<>ru.chast OR uk.rassroch<>ru.rassroch OR uk.rating<>ru.rating OR uk.rating_write<>ru.rating_write 
OR uk.id_brands<>ru.id_brands OR uk.id_statuses<>ru.id_statuses OR uk.id_weight_class<>ru.id_weight_class 
OR uk.id_length_class<>ru.id_length_class OR uk.id_products_present<>ru.id_products_present 
OR uk.id_products<>ru.id_products OR uk.is_top<>ru.is_top OR uk.is_recomended<>ru.is_recomended OR uk.is_new<>ru.is_new 
OR uk.is_blackfriday<>ru.is_blackfriday OR uk.id_1c<>ru.id_1c)


SELECT uk.id, 
ru.video as ru_video, uk.video as uk_video,
ru.model as ru_model, uk.model as uk_model,
ru.garantia as ru_garantia, uk.garantia as uk_garantia 
FROM products_uk uk 
LEFT JOIN products_ru ru ON uk.id=ru.id
WHERE 
uk.price<>ru.price OR uk.video<>ru.video OR uk.model<>ru.model OR uk.garantia<>ru.garantia 
-- NONE

SELECT uk.id FROM products_uk uk 
LEFT JOIN products_ru ru ON uk.id=ru.id
WHERE uk.is_show=1 AND (uk.garantia_sum<>ru.garantia_sum OR uk.sku<>ru.sku OR uk.upc<>ru.upc OR uk.ean<>ru.ean 
OR uk.is_blackfriday<>ru.is_blackfriday OR uk.id_1c<>ru.id_1c)
-- NONE

SELECT uk.id, uk.viewed as uk_viewed, ru.viewed as ru_viewed FROM products_uk uk 
LEFT JOIN products_ru ru ON uk.id=ru.id
WHERE uk.is_show=1 AND (uk.viewed<>ru.viewed)
-- 11



-- Exclude:
-- image
-- slug
-- gallery
-- content


-- ***********************


SELECT p.product_id, pd.name, p.status  FROM `oc_product` p 
LEFT JOIN `oc_product_description` pd ON p.product_id=pd.product_id 
WHERE pd.language_id=3 AND
EXISTS (SELECT id FROM `products_uk` WHERE p.product_id=id) 

-- ##########################


SELECT uk.id FROM products_uk uk 
LEFT JOIN products_ru ru ON uk.id=ru.id
WHERE uk.is_show=1 AND (
uk.price<>ru.price OR uk.video<>ru.video OR uk.model<>ru.model OR uk.garantia<>ru.garantia 
OR uk.garantia_sum<>ru.garantia_sum OR uk.sku<>ru.sku OR uk.upc<>ru.upc OR uk.ean<>ru.ean 
OR uk.jan<>ru.jan OR uk.isbn<>ru.isbn OR uk.mpn<>ru.mpn OR uk.ship_pay<>ru.ship_pay OR uk.quantity<>ru.quantity OR uk.weight<>ru.weight 
OR uk.length<>ru.length OR uk.width<>ru.width OR uk.height<>ru.height OR uk.subtract<>ru.subtract OR uk.minimum<>ru.minimum 
OR uk.sort<>ru.sort OR uk.is_show<>ru.is_show OR uk.viewed<>ru.viewed OR uk.cat_parts<>ru.cat_parts OR uk.unit<>ru.unit 
OR uk.credit<>ru.credit OR uk.chast<>ru.chast OR uk.rassroch<>ru.rassroch OR uk.rating<>ru.rating OR uk.rating_write<>ru.rating_write 
OR uk.id_brands<>ru.id_brands OR uk.id_statuses<>ru.id_statuses OR uk.id_weight_class<>ru.id_weight_class 
OR uk.id_length_class<>ru.id_length_class OR uk.id_products_present<>ru.id_products_present 
OR uk.id_products<>ru.id_products OR uk.is_top<>ru.is_top OR uk.is_recomended<>ru.is_recomended OR uk.is_new<>ru.is_new 
OR uk.is_blackfriday<>ru.is_blackfriday OR uk.id_1c<>ru.id_1c)

-- #########################################################################

SELECT old.product_id FROM oc_product old 
LEFT JOIN oc_product_to_1c c ON old.product_id=c.product_id
LEFT JOIN products_uk uk ON uk.id=old.product_id
WHERE uk.is_show=1 AND (
uk.id<>old.product_id
OR uk.price<>old.price
OR uk.video<>old.video
OR uk.model<>old.model
OR uk.garantia<>old.garantia
OR uk.garantia_sum<>old.garantia_sum
OR uk.sku<>old.sku
OR uk.upc<>old.upc
OR uk.ean<>old.ean
OR uk.jan<>old.jan
OR uk.isbn<>old.isbn
OR uk.mpn<>old.mpn
OR uk.ship_pay<>old.ship_pay
OR uk.quantity<>old.quantity
OR uk.weight<>old.weight
OR uk.length<>old.length
OR uk.width<>old.width
OR uk.height<>old.height
OR uk.subtract<>old.subtract
OR uk.minimum<>old.minimum
OR uk.sort<>old.sort_order
OR uk.is_show<>old.status
OR uk.viewed<>old.viewed
OR uk.cat_parts<>old.cat_parts
OR uk.unit<>old.unit
OR uk.credit<>old.credit
OR uk.chast<>old.chast
OR uk.rassroch<>old.rassroch
OR uk.rating<>old.rating
OR uk.rating_write<>old.rating_write
OR uk.id_1c<>1c_id)



SELECT old.product_id,uk.viewed as uk_viewed, old.viewed  FROM oc_product old 
LEFT JOIN oc_product_to_1c c ON old.product_id=c.product_id
LEFT JOIN products_uk uk ON uk.id=old.product_id
WHERE old.status=1 AND (
uk.viewed<>old.viewed)


SELECT old.product_id,uk.id_1c,1c_id  FROM oc_product old 
LEFT JOIN oc_product_to_1c c ON old.product_id=c.product_id
LEFT JOIN products_uk uk ON uk.id=old.product_id
WHERE old.status=1 AND (uk.id_1c<>1c_id)


DELETE FROM `oc_product_to_1c` WHERE `1c_id` LIKE '86ff67f2-313c-11ee-b2b9-00155df1fb04' OR `1c_id` LIKE '9183313e-313c-11ee-b2b9-00155df1fb04' OR `1c_id` LIKE '650e044c-bbf3-11e8-bc9f-005056b1440a' OR `1c_id` LIKE '942f5916-1a65-11ee-b2b9-00155df1fb04' OR `1c_id` LIKE '7c3044c8-e66b-11e9-98a7-005056b1440a' OR `1c_id` LIKE '1086afdb-0532-11ea-ad49-005056b1440a' OR `1c_id` LIKE '6a0e87f2-f3db-11ed-a49e-005056988a75' OR `1c_id` LIKE '5092950c-01f4-11ea-ad49-005056b1440a' OR `1c_id` LIKE 'a7eeabc6-c11b-11eb-82bd-005056b1440a' OR `1c_id` LIKE '2c11b2ae-eff4-11ed-a49e-005056988a75' OR `1c_id` LIKE '0946e554-b2b1-11ec-90b0-005056b1440a' OR `1c_id` LIKE '292439c3-1407-11ee-b2b9-00155df1fb04' OR `1c_id` LIKE '5a1ef97d-c1b6-11ed-a49e-005056988a75' OR `1c_id` LIKE '07ad2913-2485-11ee-b2b9-00155df1fb04' OR `1c_id` LIKE '07ad290f-2485-11ee-b2b9-00155df1fb04' OR `1c_id` LIKE '3b462bf9-251b-11ed-ab27-005056b1440a' OR `1c_id` LIKE '4f7ed590-f3db-11ed-a49e-005056988a75' OR `1c_id` LIKE '001920e2-53f4-11ea-a1d8-005056b1440a' OR `1c_id` LIKE '001920de-53f4-11ea-a1d8-005056b1440a' OR `1c_id` LIKE '17ae3968-5480-11ea-a1d8-005056b1440a' OR `1c_id` LIKE '17ae396c-5480-11ea-a1d8-005056b1440a' OR `1c_id` LIKE '17ae398d-5480-11ea-a1d8-005056b1440a' OR `1c_id` LIKE '80503ae8-d9ef-11ed-a49e-005056988a75' OR `1c_id` LIKE '603bbace-1a08-11e8-8c42-005056b1440a' OR `1c_id` LIKE 'e6a4cc44-3504-11ee-b2b9-00155df1fb04' OR `1c_id` LIKE 'e6a4cc40-3504-11ee-b2b9-00155df1fb04' OR `1c_id` LIKE 'e6a4cc32-3504-11ee-b2b9-00155df1fb04' OR `1c_id` LIKE 'e6f2988e-350b-11ee-b2b9-00155df1fb04' OR `1c_id` LIKE 'f9df5597-350b-11ee-b2b9-00155df1fb04' OR `1c_id` LIKE '33e575fc-3513-11ee-b2b9-00155df1fb04' 


-- ##############################################################

SELECT pc.product_id, pc.category_id, id_categories FROM `oc_product_to_category` pc 
LEFT JOIN oc_product p ON p.product_id=pc.product_id 
LEFT JOIN products_categories pp ON pc.product_id=id_products 
WHERE p.status=1  
NOT EXISTS (SELECT id FROM `products_categories` WHERE pc.product_id=id_products AND pc.category_id=id_categories)

SELECT * FROM products_ru p WHERE image = '' AND is_show=1 AND 
NOT EXISTS (SELECT id FROM products_categories pc WHERE pc.id_products=p.id);

-- ##############################################################

