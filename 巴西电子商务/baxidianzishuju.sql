-- 查看每个数据表是否数据缺失
SELECT 'olist_customers_dataset' AS table_name,
COUNT(*) AS total
FROM olist_customers_dataset

UNION ALL

SELECT 'olist_geolocation_dataset' AS table_name,
COUNT(*) AS total
FROM olist_geolocation_dataset

UNION ALL

SELECT 'olist_order_items_dataset' AS table_name,
COUNT(*) as total
from olist_order_items_dataset

UNION ALL 

SELECT 'olist_order_payments_dataset' as table_name,
count(*) as total 
from olist_order_payments_dataset
 
UNION ALL 

SELECT 'olist_order_reviews_dataset' as table_name,
count(*) as total 
from olist_order_reviews_dataset

UNION ALL 

SELECT 'olist_orders_dataset' as table_name,
count(*) as total 
from olist_orders_dataset

UNION ALL 

SELECT 'olist_products_dataset' as table_name,
count(*) as total 
from olist_products_dataset

UNION ALL 

SELECT 'olist_sellers_dataset' as table_name,
count(*) as total 
from olist_sellers_dataset 

UNION all 

SELECT 'product_category_name_translation' as table_name,
count(*) as total 
from product_category_name_translation;

-- 检查olist_customers_dataset数据表的每一个标题是否有缺失值
SELECT
  COUNT(*) AS total,
  SUM(customer_state IS NULL) AS null_count,
  ROUND(100.0 * SUM(customer_state IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null
FROM olist_customers_dataset
 
 union all 
 
SELECT
  COUNT(*) AS total,
  SUM(customer_id IS NULL) AS null_count,
  ROUND(100.0 * SUM(customer_id IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null
FROM olist_customers_dataset
 
  union all 
 
 SELECT
  COUNT(*) AS total,
  SUM(customer_unique_id IS NULL) AS null_count,
  ROUND(100.0 * SUM(customer_unique_id IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null
FROM olist_customers_dataset
 
union all 
 
 SELECT
  COUNT(*) AS total,
  SUM(customer_zip_code_prefix IS NULL) AS null_count,
  ROUND(100.0 * SUM(customer_zip_code_prefix IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null
FROM olist_customers_dataset
 
union all 
 
 SELECT
  COUNT(*) AS total,
  SUM(customer_city IS NULL) AS null_count,
  ROUND(100.0 * SUM(customer_city IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null
FROM olist_customers_dataset;
 
-- 城市/州字段如果 DISTINCT 值 > 5500（巴西共 5570 市），大概率有拼错(检查城市/州是否有拼错)
 SELECT
    COUNT(*) AS total,
    SUM(CASE WHEN customer_city IS NULL OR TRIM(customer_city) = '' THEN 1 ELSE 0 END) AS null_or_empty,
    COUNT(DISTINCT customer_city) AS distinct_count
FROM olist_customers_dataset

union all 
 SELECT
    COUNT(*) AS total,
    SUM(CASE WHEN customer_state IS NULL OR TRIM(customer_state) = '' THEN 1 ELSE 0 END) AS null_or_empty,
    COUNT(DISTINCT customer_state) AS distinct_count
FROM olist_customers_dataset;

-- 统一格式
UPDATE olist_customers_dataset
SET customer_city  = TRIM(LOWER(customer_city)),
    customer_state = TRIM(UPPER(customer_state));

-- 显示那些目前是 4 位纯数字的邮编（将被补 0）
SELECT customer_id, customer_zip_code_prefix
FROM baxi.olist_customers_dataset
WHERE customer_zip_code_prefix REGEXP '^[0-9]{4}$'
LIMIT 200;

ALTER TABLE baxi.olist_customers_dataset
MODIFY COLUMN customer_zip_code_prefix VARCHAR(10);

UPDATE baxi.olist_customers_dataset
SET customer_zip_code_prefix = LPAD(customer_zip_code_prefix, 5, '0')
WHERE customer_zip_code_prefix REGEXP '^[0-9]{4}$';

SELECT COUNT(*) AS still_4_digits
FROM baxi.olist_customers_dataset
WHERE customer_zip_code_prefix REGEXP '^[0-9]{4}$';

-- 检查olist_geolocation_dataset数据表的每一个标题是否有缺失值
 
 SELECT
  COUNT(*) AS total,
  SUM(geolocation_zip_code_prefix IS NULL) AS null_count,
  ROUND(100.0 * SUM(geolocation_zip_code_prefix IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null
FROM olist_geolocation_dataset
 
 union all 
 
SELECT
  COUNT(*) AS total,
  SUM(geolocation_lat IS NULL) AS null_count,
  ROUND(100.0 * SUM(geolocation_lat IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null
FROM olist_geolocation_dataset
 
  union all 
 
 SELECT
  COUNT(*) AS total,
  SUM(geolocation_lng IS NULL) AS null_count,
  ROUND(100.0 * SUM(geolocation_lng IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null
FROM olist_geolocation_dataset
 
union all 
 
 SELECT
  COUNT(*) AS total,
  SUM(geolocation_city IS NULL) AS null_count,
  ROUND(100.0 * SUM(geolocation_city IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null
FROM olist_geolocation_dataset
 
union all 
 
 SELECT
  COUNT(*) AS total,
  SUM(geolocation_state IS NULL) AS null_count,
  ROUND(100.0 * SUM(geolocation_state IS NULL) / NULLIF(COUNT(*),0), 2) AS pct_null
FROM olist_geolocation_dataset;

-- 显示那些目前是 4 位纯数字的邮编（将被补 0）
SELECT geolocation_zip_code_prefix
FROM baxi.olist_geolocation_dataset
WHERE geolocation_zip_code_prefix REGEXP '^[0-9]{4}$'
LIMIT 200;

ALTER TABLE baxi.olist_geolocation_dataset
MODIFY COLUMN geolocation_zip_code_prefix VARCHAR(10);

UPDATE baxi.olist_geolocation_dataset
SET geolocation_zip_code_prefix = LPAD(geolocation_zip_code_prefix, 5, '0')
WHERE geolocation_zip_code_prefix REGEXP '^[0-9]{4}$';

SELECT COUNT(*) AS still_4_digits
FROM baxi.olist_geolocation_dataset
WHERE geolocation_zip_code_prefix REGEXP '^[0-9]{4}$';

-- 城市/州字段如果 DISTINCT 值 > 5500（巴西共 5570 市），大概率有拼错(检查城市/州是否有拼错)
 SELECT
    COUNT(*) AS total,
    SUM(CASE WHEN geolocation_city IS NULL OR TRIM(geolocation_city) = '' THEN 1 ELSE 0 END) AS null_or_empty,
    COUNT(DISTINCT geolocation_city) AS distinct_count
FROM olist_geolocation_dataset

union all 
 SELECT
    COUNT(*) AS total,
    SUM(CASE WHEN geolocation_state IS NULL OR TRIM(geolocation_state) = '' THEN 1 ELSE 0 END) AS null_or_empty,
    COUNT(DISTINCT geolocation_state) AS distinct_count
FROM olist_geolocation_dataset;

-- 删除开头所有不是字母/数字的字符（包括空格、标���、汉字等），直到遇到第一个字母/数字
-- 开始事务（可在确认无误后 COMMIT）
-- 直接覆盖原字段脚本（MySQL 8，支持 REGEXP_REPLACE）
START TRANSACTION;

-- 1) 基础：全部小写并去首尾空格
UPDATE olist_geolocation_dataset
SET geolocation_city = LOWER(TRIM(geolocation_city))
WHERE geolocation_city IS NOT NULL;

-- 2) 把一些常见的百分号编码（URL-encoded）替换为对应字符
UPDATE olist_geolocation_dataset
SET geolocation_city = REPLACE(geolocation_city, '%26apos%3b', '''')
WHERE geolocation_city LIKE '%25%26apos%25%3b%' OR geolocation_city LIKE '%25%26apos%3b%';
-- 也替换大写或不同小写形式
UPDATE olist_geolocation_dataset
SET geolocation_city = REPLACE(geolocation_city, '%26APOS%3B', '''')
WHERE geolocation_city LIKE '%25%26APOS%25%3B%';

-- 如果出现像 %20 (空格) 等也转换
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, '%20', ' ') WHERE geolocation_city LIKE '%25%20%';

-- 3) 替换常见 HTML 实体（葡语/西欧常见）
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, '&oacute;', 'o') WHERE geolocation_city LIKE '%&oacute;%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, '&aacute;', 'a') WHERE geolocation_city LIKE '%&aacute;%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, '&atilde;', 'a') WHERE geolocation_city LIKE '%&atilde;%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, '&ccedil;', 'c') WHERE geolocation_city LIKE '%&ccedil;%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, '&eacute;', 'e') WHERE geolocation_city LIKE '%&eacute;%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, '&iacute;', 'i') WHERE geolocation_city LIKE '%&iacute;%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, '&uacute;', 'u') WHERE geolocation_city LIKE '%&uacute;%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, '&uuml;', 'u') WHERE geolocation_city LIKE '%&uuml;%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, '&ntilde;', 'n') WHERE geolocation_city LIKE '%&ntilde;%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, '&apos;', '''') WHERE geolocation_city LIKE '%&apos;%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, '&amp;', '&') WHERE geolocation_city LIKE '%&amp;%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, '&quot;', '"') WHERE geolocation_city LIKE '%&quot;%';

-- 4) ���残留的百分号编码片段移除（比如 %C3%A1 等）
UPDATE olist_geolocation_dataset
SET geolocation_city = REGEXP_REPLACE(geolocation_city, '%[0-9A-Fa-f]{2}', '')
WHERE geolocation_city REGEXP '%[0-9A-Fa-f]{2}';

-- 5) 删除括号内的注释内容，例如 "bacaxa (saquarema)" -> "bacaxa"
UPDATE olist_geolocation_dataset
SET geolocation_city = REGEXP_REPLACE(geolocation_city, '\\s*\\(.*?\\)', '')
WHERE geolocation_city REGEXP '\\(';

-- 6) 删除以 " - " 或 "–" 开始的后缀（例如 " - distrito"）
UPDATE olist_geolocation_dataset
SET geolocation_city = REGEXP_REPLACE(geolocation_city, '\\s*-\\s*.*$', '')
WHERE geolocation_city REGEXP ' - ' OR geolocation_city REGEXP '–';

-- 7) 处理常见的带撇号 / 方言缩写问题，例如 d'oeste -> do oeste, "d'o" 类似
UPDATE olist_geolocation_dataset
SET geolocation_city = REPLACE(geolocation_city, "d'oeste", 'do oeste')
WHERE geolocation_city LIKE "%d'oeste%";

-- 如果有 "d'o" 这类其他情况，统一把 "d'" 转为 "do "（谨慎）
UPDATE olist_geolocation_dataset
SET geolocation_city = REGEXP_REPLACE(geolocation_city, "\\bd'", 'do ')
WHERE geolocation_city REGEXP "\\bd'";

-- 8) 删除非字母/数字/常用标点的噪声字符（例如中文、奇怪符号），保留字母（含重音）、数字、空格、点、逗号、连字符和括号（括号已在第5步清除内容）
UPDATE olist_geolocation_dataset
SET geolocation_city = REGEXP_REPLACE(geolocation_city, '[^[:alpha:][:digit:]\\s\\-\\.,\\'']+', '')
WHERE geolocation_city REGEXP '[^[:alpha:][:digit:]\\s\\-\\.,\\'']';

-- 9) 把常见葡语/西欧重音字符再转成 ASCII（如果仍有）
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, 'à', 'a') WHERE geolocation_city LIKE '%à%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, 'á', 'a') WHERE geolocation_city LIKE '%á%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, 'â', 'a') WHERE geolocation_city LIKE '%â%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, 'ã', 'a') WHERE geolocation_city LIKE '%ã%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, 'ä', 'a') WHERE geolocation_city LIKE '%ä%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, 'å', 'a') WHERE geolocation_city LIKE '%å%';

UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, 'ç', 'c') WHERE geolocation_city LIKE '%ç%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, 'è', 'e') WHERE geolocation_city LIKE '%è%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, 'é', 'e') WHERE geolocation_city LIKE '%é%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, 'ê', 'e') WHERE geolocation_city LIKE '%ê%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, 'í', 'i') WHERE geolocation_city LIKE '%í%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, 'ó', 'o') WHERE geolocation_city LIKE '%ó%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, 'ô', 'o') WHERE geolocation_city LIKE '%ô%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, 'õ', 'o') WHERE geolocation_city LIKE '%õ%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, 'ú', 'u') WHERE geolocation_city LIKE '%ú%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, 'ü', 'u') WHERE geolocation_city LIKE '%ü%';
UPDATE olist_geolocation_dataset SET geolocation_city = REPLACE(geolocation_city, 'ñ', 'n') WHERE geolocation_city LIKE '%ñ%';

-- 10) 删除残留的孤立百分号或特殊符号
UPDATE olist_geolocation_dataset
SET geolocation_city = REPLACE(geolocation_city, '%', '')
WHERE geolocation_city LIKE '%\%%';

-- 11) 合并多空格、去多余标点、最终 trim
UPDATE olist_geolocation_dataset
SET geolocation_city = REGEXP_REPLACE(geolocation_city, '\\s+', ' ')
WHERE geolocation_city REGEXP '\\s{2,}';

UPDATE olist_geolocation_dataset
SET geolocation_city = TRIM(BOTH ' .,' FROM geolocation_city)
WHERE geolocation_city LIKE '%.%' OR geolocation_city LIKE '%,%' OR geolocation_city LIKE ' %' OR geolocation_city LIKE '% ';

-- 12) 特例映射（你给出的例子和常见缩写）
UPDATE olist_geolocation_dataset SET geolocation_city = 'sao paulo' WHERE geolocation_city = 'saopaulo';
UPDATE olist_geolocation_dataset SET geolocation_city = 'maceio' WHERE geolocation_city = 'maceia' OR geolocation_city = 'maceio';
UPDATE olist_geolocation_dataset SET geolocation_city = 'florianopolis' WHERE geolocation_city = 'florianopolis' OR geolocation_city = 'florianopolis';
UPDATE olist_geolocation_dataset SET geolocation_city = 'belo horizonte' WHERE geolocation_city = 'bh';
-- 你可以把更多规则继续加入此处（例如地区缩写、常见拼写错误等）

-- 13) 最后一次统一 trim
UPDATE olist_geolocation_dataset
SET geolocation_city = TRIM(geolocation_city)
WHERE geolocation_city IS NOT NULL;

COMMIT;

-- 导入巴西所有城市数据
UPDATE `br-city-codes`
SET name = REGEXP_REPLACE(
             REGEXP_REPLACE(
             REGEXP_REPLACE(
             REGEXP_REPLACE(
             REGEXP_REPLACE(
             REGEXP_REPLACE(
             REGEXP_REPLACE(
             REGEXP_REPLACE(
             REGEXP_REPLACE(
             REGEXP_REPLACE(
             REGEXP_REPLACE(
             REGEXP_REPLACE(
             REGEXP_REPLACE(name,
             '[àáâãäå]','a'),
             '[èéêë]','e'),
             '[ìíîï]','i'),
             '[òóôõöø]','o'),
             '[ùúûü]','u'),
             '[ç]','c'),
             '[ñ]','n'),
             '[ÀÁÂÃÄÅ]','A'),
             '[ÈÉÊË]','E'),
             '[ÌÍÎÏ]','I'),
             '[ÒÓÔÕÖØ]','O'),
             '[ÙÚÛÜ]','U'),
             '[Ç]','C');
             
START TRANSACTION;

UPDATE `br-city-codes`
SET `name` = LOWER(`name`);

COMMIT;

-- 根据这个巴西所有城市数据，在对olist_geolocation_dataset的geolocation_city进行筛选
-- ================= 一键可运行（预览优先，删除需手动 CALL） =================

-- 给主表（要删除数据的表）的字段加索引
DELETE T1
FROM olist_geolocation_dataset AS T1
LEFT JOIN `br-city-codes` AS T2 ON T1.geolocation_city = T2.name
WHERE T2.name IS NULL;

-- olist_order_items_dataset 检查 price 是否有 =0 /<0 的字段
SELECT COUNT(*) AS cnt_invalid
FROM olist_order_items_dataset
WHERE price <= 0;

-- olist_order_payments_dataset 检查 payment_installments 是否为 0，或数值特别大，在进行删除处理
SELECT
    SUM(CASE WHEN payment_installments <= 0 THEN 1 ELSE 0 END) AS cnt_invalid,
    MAX(payment_installments) AS max_installments
FROM olist_order_payments_dataset;

DELETE FROM olist_order_payments_dataset
WHERE payment_installments <= 0;

-- olist_order_reviews_dataset 把评分的空值改成 ""
UPDATE olist_order_reviews_dataset SET review_comment_title = "" WHERE review_comment_title IS NULL;
UPDATE olist_order_reviews_dataset SET review_comment_message = "" WHERE review_comment_message IS NULL;

-- olist_orders_dataset 把有空值的一行删除
DELETE FROM olist_orders_dataset
WHERE order_purchase_timestamp IS NULL
    OR order_approved_at IS NULL
    OR order_delivered_carrier_date IS NULL
    OR order_delivered_customer_date IS NULL;

-- olist_products_dataset 把字段名给修改正确，检查是否有空值
SELECT *
FROM olist_products_dataset
WHERE (product_weight_g IS NULL OR product_weight_g <= 0)
    OR product_category_name IS NULL
    OR product_name_length IS NULL
    OR product_photos_qty IS NULL
    OR (product_length_cm IS NULL OR product_length_cm <= 0)
    OR (product_height_cm IS NULL OR product_height_cm <= 0)
    OR (product_width_cm IS NULL OR product_width_cm <= 0);


-- 1. 填充缺失的类别名称为 'unknown'
UPDATE olist_products_dataset
SET product_category_name = 'unknown'
WHERE product_category_name IS NULL;

-- 2. 填充缺失的名字长度为 0
UPDATE olist_products_dataset
SET product_name_length = 0
WHERE product_name_length IS NULL;

UPDATE olist_products_dataset
SET product_description_length = 0
WHERE product_description_length IS NULL;

UPDATE olist_products_dataset
SET product_photos_qty = 0
WHERE product_photos_qty IS NULL;

DELETE FROM olist_products_dataset
WHERE product_id = '5eb564652db742ff8f28759cd8d2652a';
-- olist_sellers_dataset 的四位数邮编改正
-- 显示那些目前是 4 位纯数字的邮编（将被补 0）
SELECT seller_zip_code_prefix
FROM olist_sellers_dataset
WHERE seller_zip_code_prefix REGEXP '^[0-9]{4}$'
LIMIT 200;

ALTER TABLE olist_sellers_dataset
MODIFY COLUMN seller_zip_code_prefix VARCHAR(10);

UPDATE olist_sellers_dataset
SET seller_zip_code_prefix = LPAD(seller_zip_code_prefix, 5, '0')
WHERE seller_zip_code_prefix REGEXP '^[0-9]{4}$';

SELECT COUNT(*) AS still_4_digits
FROM olist_sellers_dataset
WHERE seller_zip_code_prefix REGEXP '^[0-9]{4}$';

-- seller_city 统一一下字段
UPDATE olist_sellers_dataset
SET seller_city = LOWER(TRIM(seller_city));
