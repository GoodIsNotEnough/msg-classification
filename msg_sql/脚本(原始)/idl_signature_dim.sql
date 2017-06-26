drop table idl_signature_dim;

CREATE TABLE idl_signature_dim
(signature          STRING COMMENT  '短信签名',
sig_industry        STRING  COMMENT '行业',
ave_prob            FLOAT COMMENT   '平均得分',
sig_industry_2nd    STRING  COMMENT '排第二的行业',
ave_prob_2nd        FLOAT COMMENT   '排第二的平均得分'
)
comment "签名得分表"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

-- 线上
ALTER TABLE idl_signature_dim DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_signature_dim DROP PARTITION(ds = "{p0}" );

INSERT INTO idl_signature_dim PARTITION (ds="{p0}")
SELECT 
t2.signature,
t2.sig_industry, 
t2.ave_prob,
s2.sig_industry_2nd, 
s2.ave_prob_2nd
FROM 
(SELECT
t1.signature,
t1.sig_industry, 
t1.ave_prob
FROM 
    (SELECT
    signature,
    sig_industry, 
    ave_prob,  
    row_number() over (PARTITION BY signature ORDER BY ave_prob desc) AS rn
    FROM idl_signature_score_agg
    WHERE ds = "{p0}"
    ) t1
WHERE t1.rn=1
) t2
LEFT JOIN
(SELECT
s1.signature,
s1.sig_industry AS sig_industry_2nd, 
s1.ave_prob AS ave_prob_2nd
FROM 
    (SELECT
    signature,
    sig_industry, 
    ave_prob,  
    row_number() over (PARTITION BY signature ORDER BY ave_prob desc) AS rn
    FROM idl_signature_score_agg
    WHERE ds = "{p0}"
    ) s1
WHERE s1.rn=2
) s2
ON t2.signature=s2.signature
