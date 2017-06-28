drop table idl_msg_template_info_tmp;

CREATE TABLE idl_msg_template_info_tmp
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
ALTER TABLE idl_msg_template_info_tmp DROP PARTITION(ds <= "2017-06-22" );

INSERT INTO idl_msg_template_info_tmp PARTITION (ds="2017-06-22")
SELECT
t012.tmp_id,
t012.signature,
t012.tmp_type,
t012.type_prob,
t012.type_prob_map,
s012.tmp_industry,
s012.industry_prob,
s012.industry_prob_map
FROM
(SELECT
t1.tmp_id,
t1.signature,
t1.category AS tmp_type,
t1.probability AS type_prob,
t2.prob_map AS type_prob_map
FROM
(SELECT
tmp_id,
signature,
category,
probability
FROM
    (SELECT
    tmp_id,
    signature,
    category,
    probability,
    row_number() over (PARTITION BY tmp_id ORDER BY probability desc) AS rn
    FROM idl_msg_template_score_tmp
    WHERE ds = "2017-06-22" 
    AND dimension='类型'
    ) t0
WHERE rn=1
) t1
LEFT JOIN
    (SELECT
    tmp_id,
    str_to_map(concat_ws("\073",collect_list(concat_ws('\072', category,CAST(probability AS STRING)))),"\073","\072") AS prob_map
    FROM idl_msg_template_score_tmp
    WHERE ds = "2017-06-22" 
    AND dimension='类型'
    GROUP BY tmp_id
    ) t2
ON t1.tmp_id=t2.tmp_id
) t012
LEFT JOIN
(SELECT
s1.tmp_id,
s1.category AS tmp_industry,
s1.probability AS industry_prob,
s2.prob_map AS industry_prob_map
FROM
(SELECT
tmp_id,
category,
probability
FROM
    (SELECT
    tmp_id,
    category,
    probability,
    row_number() over (PARTITION BY tmp_id ORDER BY probability desc) AS rn
    FROM idl_msg_template_score_tmp
    WHERE ds = "2017-06-22" 
    AND dimension='行业'
    ) s0
WHERE rn=1
) s1
LEFT JOIN
    (SELECT
    tmp_id,
    str_to_map(concat_ws("\073",collect_list(concat_ws('\072', category,CAST(probability AS STRING)))),"\073","\072") AS prob_map
    FROM idl_msg_template_score_tmp
    WHERE ds = "2017-06-22" 
    AND dimension='行业'
    GROUP BY tmp_id
    ) s2
ON s1.tmp_id=s2.tmp_id
) s012
ON t012.tmp_id=s012.tmp_id;