SELECT T.transaction_id, T.date,T.branch_id, C.branch_name, C.kota, C.provinsi,C.rating As rating_cabang,T.customer_name,T.product_id, P.product_name, P.price AS actual_price ,T.discount_percentage,
 
CASE
  WHEN P.price <= 50000 THEN 10
  WHEN P.price > 50000 AND P.price <= 100000 THEN 15
  WHEN P.price > 100000 AND P.price <= 300000 THEN 20
  WHEN P.price > 300000 AND P.price <= 500000 THEN 25
  WHEN P.price > 500000 THEN 30
  ELSE 0
END AS persentase_gross_laba, 
P.price*(1-T.discount_percentage) AS nett_sales,
(SELECT SUM(P.price)-SUM(P.price*discount_percentage) FROM kimia_farma.kf_final_transaction) AS nett_profit, 
T.rating AS rating_transaksi
FROM kimia_farma.kf_final_transaction AS T
JOIN kimia_farma.kf_kantor_cabang AS C ON T.branch_id = C.branch_id
JOIN kimia_farma.kf_product AS P ON T.product_id = P.product_id
ORDER BY T.transaction_id;
