drop table idl_msg_signature_score_agg;

CREATE TABLE idl_msg_signature_score_agg
(signature    STRING COMMENT  '短信签名',
sig_industry  STRING  COMMENT '行业',
tmp_num       INT COMMENT     '行业的模板数',
ave_prob      FLOAT COMMENT   '模板的平均得分'
)
comment "签名得分表"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

-- 线上
ALTER TABLE idl_msg_signature_score_agg DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_msg_signature_score_agg DROP PARTITION(ds = "{p0}" );

INSERT INTO idl_msg_signature_score_agg PARTITION (ds="{p0}")
SELECT
signature,
tmp_industry AS sig_industry,
count(tmp_id) AS tmp_num,     
avg(industry_prob) AS ave_prob
FROM idl_msg_template_info_dim
WHERE ds = "{p0}"
GROUP BY signature,tmp_industry
