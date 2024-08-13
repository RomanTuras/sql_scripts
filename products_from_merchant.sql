-- Getting products ID and MODEL with google merchant params

SELECT id, model FROM products_uk WHERE is_show=1 AND id_statuses<>5 LIMIT 10;