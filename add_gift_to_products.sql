-- Сталеві радіатори з нижнім підключенням (id=169)
-- Сталеві радіатори з боковим підключенням (id=171)
-- Kermi (id=46)


SELECT p.id FROM products_uk as p
LEFT JOIN products_categories as pc ON pc.id_products=p.id 
WHERE pc.id_categories IN(169,171) AND id_brands=46 
AND model IN("ZB03380001_RAL9005_M","PLK220501401N2K","PLK220501601N2K","PLV220201001RXK","PLV22_400_1300_RAL9005_M","PLV220501001R2K","PLV220501201R2K","PLV220501401R2K","PLV220501601R2K","PLV220501801R2K","PLV220500401R2K","PLV220500501R2K","PLV220500701R2K","PLV220500901R2K","PLV220600701R2K","PLV330201401RXK","PTV220301801R2K","FK0110311W02","FK0110312W02","FK0110314W02","FK0110316W02","FK0110306W02","FK0110307W02","FK0110308W02","FK0110309W02","FK0110416W02","FK0110426W02","FK0110514W02","FK0110516W02","FK0110506W02","FK0110508W02","FK0220301001N2Z","FK0220310W02","FK0220311W02","FK0220312W02","FK0220314W02","FK0220316W02","FK0220305W02","FK0220306W02","FK0220307W02","FK0220308W02","FK0220309W02","FK0220408W02","FK0220510W02","FK0220511W02","FK0220512W02","FK0220513W02","FK0220501301N2Z","FK0220514W02","FK0220516W02","FK0220501601N2Z","FK0220518W02","FK0220520W02","FK0220500401N2Z","FK0220505W02","FK0220506W02","FK0220507W02","FK0220500701N2Z","FK0220508W02","FK0220509W02","FTV110301001R2K","FTV110301101R2Z","FTV110301201R2K","FTV110301401R2K","FTV110301601R2K","FTV110301801R2K","FTV110300501R2K","FTV110300601R2K","FTV110300701R2K","FTV110300801R2K","FTV110300901R2K","FTV110501001R2K","FTV110501201R2K","FTV110501401R2K","FTV110501601R2K","FTV110500401R2K","FTV110500501R2K","FTV110500601R2K","FTV110500701R2K","FTV110500801R2K","FTV110500901R2K","FTV120601601R2K","FTV220200601RXK","FTV220200801RXK","FTV220301001R2K","FTV220301101R2K","FTV220301201R2K","FTV220301301R2K","FTV220301401R2K","FTV220301801R2K","FTV220302001R2Z","FTV220300501R2K","FTV220300601R2K","FTV220300701R2K","FTV220300801R2K","FTV220300801R2Z","FTV220300901R2K","FTV220401201R2K","FTV220501001R2K","FTV220501101R2K","FTV220501101R2Z","FTV220501201R2K","FTV220501301R2K","FTV220501301R2Z","FTV220501401R2Z","FTV220501601R2K","FTV220501601R2Z","FTV220501801R2K","FTV220502001R2K","FTV220502301R2Z","FTV220502601R2Z","FTV220500401R2K","FTV220500501R2Z","FTV220500601R2K","FTV220500601R2Z","FTV220500701R2Z","FTV220500901R2K","FTV220500901R2Z","FTV330301001R2K","FTV330301001R2Z","FTV330301101R2Z","FTV330300501R2Z","FTV330501001R2K","FTV330501201R2K","FTV330501401R2K","FTV330501601R2K","FTV330501801R2Z","FTV330502001R2K","FTV330500501R2Z","FTV330500601R2K","FTV330500801R2Z","FTV330500901R2K");


UPDATE products_uk SET id_products_present=17458 
WHERE id IN(5293,5295,5300,5301,5317,5321,5357,5360,5361,5363,5364,5365,5367,5419,5421,5424,5425,5426,5427,5429,5430,5431,5443,5548,5549,5550,5551,5552,5553,5554,5555,5556,5557,5558,5559,5567,5611,5612,5613,5614,5615,5616,5617,5619,5620,5621,6538,6539,6540,6541,6542,6543,6545,6546,6547,6548,6554,6555,6556,6557,6558,6559,6560,6561,6562,6563,6586,6587,6588,6589,6590,6591,6592,6593,6594,6596,6607,7353,7354,7355,7356,7358,7359,7360,7361,11169,11171,58237,58238,58240,58243,58245,58246,58247,58248,58249,58251,58253,58257,59240,68478,123141);

UPDATE products_ru SET id_products_present=17458 
WHERE id IN(5293,5295,5300,5301,5317,5321,5357,5360,5361,5363,5364,5365,5367,5419,5421,5424,5425,5426,5427,5429,5430,5431,5443,5548,5549,5550,5551,5552,5553,5554,5555,5556,5557,5558,5559,5567,5611,5612,5613,5614,5615,5616,5617,5619,5620,5621,6538,6539,6540,6541,6542,6543,6545,6546,6547,6548,6554,6555,6556,6557,6558,6559,6560,6561,6562,6563,6586,6587,6588,6589,6590,6591,6592,6593,6594,6596,6607,7353,7354,7355,7356,7358,7359,7360,7361,11169,11171,58237,58238,58240,58243,58245,58246,58247,58248,58249,58251,58253,58257,59240,68478,123141);

-- Tag подарок (id=7)
INSERT INTO products_tags (id_products, id_tags) 
VALUES 
(5293, 7),
(5295, 7),
(5300, 7),
(5301, 7),
(5317, 7),
(5321, 7),
(5357, 7),
(5360, 7),
(5361, 7),
(5363, 7),
(5364, 7),
(5365, 7),
(5367, 7),
(5419, 7),
(5421, 7),
(5424, 7),
(5425, 7),
(5426, 7),
(5427, 7),
(5429, 7),
(5430, 7),
(5431, 7),
(5443, 7),
(5548, 7),
(5549, 7),
(5550, 7),
(5551, 7),
(5552, 7),
(5553, 7),
(5554, 7),
(5555, 7),
(5556, 7),
(5557, 7),
(5558, 7),
(5559, 7),
(5567, 7),
(5611, 7),
(5612, 7),
(5613, 7),
(5614, 7),
(5615, 7),
(5616, 7),
(5617, 7),
(5619, 7),
(5620, 7),
(5621, 7),
(6538, 7),
(6539, 7),
(6540, 7),
(6541, 7),
(6542, 7),
(6543, 7),
(6545, 7),
(6546, 7),
(6547, 7),
(6548, 7),
(6554, 7),
(6555, 7),
(6556, 7),
(6557, 7),
(6558, 7),
(6559, 7),
(6560, 7),
(6561, 7),
(6562, 7),
(6563, 7),
(6586, 7),
(6587, 7),
(6588, 7),
(6589, 7),
(6590, 7),
(6591, 7),
(6592, 7),
(6593, 7),
(6594, 7),
(6596, 7),
(6607, 7),
(7353, 7),
(7354, 7),
(7355, 7),
(7356, 7),
(7358, 7),
(7359, 7),
(7360, 7),
(7361, 7),
(11169, 7),
(11171, 7),
(58237, 7),
(58238, 7),
(58240, 7),
(58243, 7),
(58245, 7),
(58246, 7),
(58247, 7),
(58248, 7),
(58249, 7),
(58251, 7),
(58253, 7),
(58257, 7),
(59240, 7),
(68478, 7),
(123141, 7);


DELETE FROM products_tags WHERE id_tags=7 AND id_products IN(5293,5295,5300,5301,5317,5321,5357,5360,5361,5363,5364,5365,5367,5419,5421,5424,5425,5426,5427,5429,5430,5431,5443,5548,5549,5550,5551,5552,5553,5554,5555,5556,5557,5558,5559,5567,5611,5612,5613,5614,5615,5616,5617,5619,5620,5621,6538,6539,6540,6541,6542,6543,6545,6546,6547,6548,6554,6555,6556,6557,6558,6559,6560,6561,6562,6563,6586,6587,6588,6589,6590,6591,6592,6593,6594,6596,6607,7353,7354,7355,7356,7358,7359,7360,7361,11169,11171,58237,58238,58240,58243,58245,58246,58247,58248,58249,58251,58253,58257,59240,68478,123141);

--"ZB03380001_RAL9005_M","PLK220501401N2K","PLK220501601N2K","PLV220201001RXK","PLV22_400_1300_RAL9005_M","PLV220501001R2K","PLV220501201R2K","PLV220501401R2K","PLV220501601R2K","PLV220501801R2K","PLV220500401R2K","PLV220500501R2K","PLV220500701R2K","PLV220500901R2K","PLV220600701R2K","PLV330201401RXK","PTV220301801R2K","FK0110311W02","FK0110312W02","FK0110314W02","FK0110316W02","FK0110306W02","FK0110307W02","FK0110308W02","FK0110309W02","FK0110416W02","FK0110426W02","FK0110514W02","FK0110516W02","FK0110506W02","FK0110508W02","FK0220301001N2Z","FK0220310W02","FK0220311W02","FK0220312W02","FK0220314W02","FK0220316W02","FK0220305W02","FK0220306W02","FK0220307W02","FK0220308W02","FK0220309W02","FK0220408W02","FK0220510W02","FK0220511W02","FK0220512W02","FK0220513W02","FK0220501301N2Z","FK0220514W02","FK0220516W02","FK0220501601N2Z","FK0220518W02","FK0220520W02","FK0220500401N2Z","FK0220505W02","FK0220506W02","FK0220507W02","FK0220500701N2Z","FK0220508W02","FK0220509W02","FTV110301001R2K","FTV110301101R2Z","FTV110301201R2K","FTV110301401R2K","FTV110301601R2K","FTV110301801R2K","FTV110300501R2K","FTV110300601R2K","FTV110300701R2K","FTV110300801R2K","FTV110300901R2K","FTV110501001R2K","FTV110501201R2K","FTV110501401R2K","FTV110501601R2K","FTV110500401R2K","FTV110500501R2K","FTV110500601R2K","FTV110500701R2K","FTV110500801R2K","FTV110500901R2K","FTV120601601R2K","FTV220200601RXK","FTV220200801RXK","FTV220301001R2K","FTV220301101R2K","FTV220301201R2K","FTV220301301R2K","FTV220301401R2K","FTV220301801R2K","FTV220302001R2Z","FTV220300501R2K","FTV220300601R2K","FTV220300701R2K","FTV220300801R2K","FTV220300801R2Z","FTV220300901R2K","FTV220401201R2K","FTV220501001R2K","FTV220501101R2K","FTV220501101R2Z","FTV220501201R2K","FTV220501301R2K","FTV220501301R2Z","FTV220501401R2Z","FTV220501601R2K","FTV220501601R2Z","FTV220501801R2K","FTV220502001R2K","FTV220502301R2Z","FTV220502601R2Z","FTV220500401R2K","FTV220500501R2Z","FTV220500601R2K","FTV220500601R2Z","FTV220500701R2Z","FTV220500901R2K","FTV220500901R2Z","FTV330301001R2K","FTV330301001R2Z","FTV330301101R2Z","FTV330300501R2Z","FTV330501001R2K","FTV330501201R2K","FTV330501401R2K","FTV330501601R2K","FTV330501801R2Z","FTV330502001R2K","FTV330500501R2Z","FTV330500601R2K","FTV330500801R2Z","FTV330500901R2K"