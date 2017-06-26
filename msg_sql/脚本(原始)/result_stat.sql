1951343
1929999 1929999/1951343.0=0.9890618922454946
1692244 1692244/1951343.0=0.8672201658037567

SELECT 
count(distinct tmp_id) tmp_num, -- 模板的数量
sum(CASE WHEN dimension='类型' AND probability>0.5 THEN 1 ELSE 0 END) type_num, --"类型"确定的数量
sum(CASE WHEN dimension='行业' AND probability>0.5 THEN 1 ELSE 0 END) industry_num  --"行业"确定的数量
FROM idl_template_dim
WHERE ds="2017-06-20";

SELECT  --2246
count(distinct tmp_id) tmp_num -- 模板分词为空的数量
FROM idl_template_dim
WHERE ds="2017-06-20"
AND category IS NULL;

--------------------------------------------------------
drop table tmp_kgs_idl_template_dim;
CREATE TABLE tmp_kgs_idl_template_dim
(tmp_id          STRING COMMENT '模板id',
dimension        STRING COMMENT '维度:类型,行业',
category_list    ARRAY<STRING> COMMENT '类别类别',
category_score   ARRAY<STRING> COMMENT '类别得分',
sum_score        FLOAT COMMENT  '得分和'
)
comment "每个类别的截距"
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE;

INSERT INTO tmp_kgs_idl_template_dim
SELECT
t3.tmp_id,
t3.dimension,
collect_set(t3.category) category_list,
collect_list(concat_ws('\072', t3.category,CAST(t3.score AS STRING))) category_score,
sum(t3.score) sum_score
FROM
(SELECT
t1.tmp_id,
t1.dimension,
t1.category,
t1.score,
t1.probability,
row_number() over (PARTITION BY t1.tmp_id ORDER BY t1.probability desc) AS rn
FROM
    (SELECT *
    FROM idl_template_dim
    WHERE ds="2017-06-20"
    AND dimension='行业'
    ) t1
LEFT JOIN
    (SELECT * --要去除的tmp_id
    FROM idl_template_dim
    WHERE ds="2017-06-20"
    AND dimension='行业' 
    AND probability>0.5
    ) t2
ON t1.tmp_id=t2.tmp_id
WHERE t2.tmp_id IS NULL
) t3
WHERE rn<=2
GROUP BY t3.tmp_id,t3.dimension;

SELECT count(1)
FROM tmp_kgs_idl_template_dim
WHERE sum_score>0.6

SELECT
t1.category,
t2.category,
count(1) num
(SELECT
tmp_id,
category
FROM tmp_kgs_idl_template_dim
LATERAL VIEW OUTER explode(category_list) mytable1 AS category
) t1
LEFT JOIN
(SELECT
tmp_id,
category
FROM tmp_kgs_idl_template_dim
LATERAL VIEW OUTER explode(category_list) mytable1 AS category
) t2
ON t1.category=t2.category
GROUP BY t1.category,t2.category



--------------------------------------------------
drop table idl_template_dim_both;

CREATE TABLE idl_template_dim_both
(tmp_id     STRING COMMENT '模板id',
dimension   STRING COMMENT '维度:类型,行业',
category    STRING COMMENT '类别',
score       FLOAT COMMENT  '得分',
probability FLOAT COMMENT  '标准化得分'
)
comment "每个类别的截距"
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

INSERT INTO idl_template_dim_both
SELECT 
t1.tmp_id,
t1.dimension,
t1.category,
t1.score,
t1.probability
FROM
    (SELECT *
    FROM idl_template_dim
    WHERE ds="2017-06-20"
    AND probability>0.5
    ) t1
LEFT JOIN
    (SELECT 
    t0.tmp_id,
    t0.d_num
    FROM
        (SELECT 
        tmp_id,
        count(1) d_num
        FROM idl_template_dim
        WHERE ds="2017-06-20"
        AND probability>0.5
        group by tmp_id
        ) t0
    WHERE t0.d_num=2
    ) t2
ON t1.tmp_id=t2.tmp_id
WHERE t2.tmp_id IS NOT NULL;

(SELECT *
FROM idl_template_dim_both
WHERE dimension='行业'
) t1
LEFT JOIN
(SELECT *
FROM idl_template_dim_both
WHERE dimension='类型'
) t2
On t1.tmp_id=t2.tmp_id

SELECT
t2.industry_type,
count(1)
FROM
(SELECT
tmp_id,
collect_set(t1.category) industry_type
FROM
    (SELECT
    tmp_id,
    dimension,
    category
    FROM idl_template_dim_both
    ORDER BY tmp_id,dimension DESC
    ) t1
GROUP BY tmp_id
) t2 
GROUP BY t2.industry_type






