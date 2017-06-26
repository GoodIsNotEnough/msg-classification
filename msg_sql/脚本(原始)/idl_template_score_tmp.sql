drop table idl_template_score_tmp;
CREATE TABLE idl_template_score_tmp
(tmp_id     STRING COMMENT '模板id',
signature   STRING COMMENT '模板签名',
dimension   STRING COMMENT '维度:类型,行业',
category    STRING COMMENT '类别',
probability FLOAT COMMENT  '标准化得分'
)
comment "每个类别的截距"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

--线上
ALTER TABLE idl_template_score_tmp DROP PARTITION(ds <= "{p0}" );
INSERT INTO idl_template_score_tmp PARTITION (ds="{p0}")
SELECT
t1.tmp_id,
t1.signature,
t1.dimension,
t1.category,
t1.score/t2.sum_score AS probability
FROM 
    (SELECT *
    FROM idl_template_raw_score_tmp
    WHERE ds="{p0}" 
    ) t1
LEFT JOIN 
    (SELECT 
    tmp_id,
    dimension,
    sum(score) sum_score
    FROM idl_template_raw_score_tmp
    WHERE ds="{p0}"
    GROUP BY tmp_id,dimension
    ) t2
ON t1.tmp_id=t2.tmp_id AND t1.dimension=t2.dimension;

--初始化
ALTER TABLE idl_template_score_tmp DROP PARTITION(ds <= "2017-06-22" );
INSERT INTO idl_template_score_tmp PARTITION (ds="2017-06-22")
SELECT
t1.tmp_id,
t1.signature,
t1.dimension,
t1.category,
t1.score/t2.sum_score AS probability
FROM 
    (SELECT *
    FROM idl_template_raw_score_tmp
    WHERE ds="2017-06-22" 
    ) t1
LEFT JOIN 
    (SELECT 
    tmp_id,
    dimension,
    sum(score) sum_score
    FROM idl_template_raw_score_tmp
    WHERE ds="2017-06-22"
    GROUP BY tmp_id,dimension
    ) t2
ON t1.tmp_id=t2.tmp_id AND t1.dimension=t2.dimension;