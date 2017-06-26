drop table idl_template_dim;

CREATE TABLE idl_template_dim
(tmp_id             STRING COMMENT '模板id',
signature           STRING COMMENT '模板签名',
tmp_type            STRING COMMENT '最可能的类型',
type_prob           FLOAT COMMENT  '类型的概率',
type_prob_map       MAP<STRING,STRING> COMMENT'各类型得分字典',
tmp_industry        STRING  COMMENT '最可能的行业',
industry_prob       FLOAT COMMENT  '行业的概率',
industry_prob_map   MAP<STRING,STRING> COMMENT'各行业得分字典'
)
comment "每个类别的截距"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE;

-- 线上
ALTER TABLE idl_template_dim DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_template_dim DROP PARTITION(ds = "{p0}" );

INSERT INTO idl_template_dim PARTITION (ds="{p0}")
SELECT
tmp_id,
signature,
tmp_type,
type_prob,
type_prob_map,
tmp_industry,
industry_prob,
industry_prob_map
FROM idl_template_tmp
WHERE ds = "{p0}"
UNION ALL
SELECT
t0.tmp_id,
t0.signature,
t0.tmp_type,
t0.type_prob,
t0.type_prob_map,
t0.tmp_industry,
t0.industry_prob,
t0.industry_prob_map
FROM 
    (SELECT * 
    FROM idl_template_dim
    WHERE ds = "{p2}"
    ) t0
LEFT JOIN 
    (SELECT * 
    FROM idl_template_tmp
    WHERE ds = "{p0}"
    ) t1
ON t0.tmp_id=t1.tmp_id
WHERE t1.tmp_id IS NULL;