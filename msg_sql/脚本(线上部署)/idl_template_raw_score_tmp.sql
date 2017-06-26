add jar hdfs://172.31.9.255:9000/user/dc/func/hive-third-functions-2.1.1-shaded.jar;
create temporary function array_concat as 'cc.shanruifeng.functions.array.UDFArrayConcat';

ALTER TABLE idl_template_raw_score_tmp DROP PARTITION(ds <= "{p0}" );
INSERT INTO idl_template_raw_score_tmp PARTITION (ds="{p0}")
SELECT
t3.tmp_id,
t3.signature,
t4.dimension,
t3.category,
EXP(t3.linear_score+t4.intercept)/(1+EXP(t3.linear_score+t4.intercept)) AS score
FROM 
(SELECT 
t1.tmp_id,
t1.signature,
t2.category,
sum(t2.weight) linear_score
FROM
    (SELECT
    tmp_id,
    signature,
    keyword
    FROM
        (SELECT
        tmp_id,
        signature,
        array_concat(word_list,keyword_list) AS word_keyword_list,
        row_number() over (PARTITION BY tmp_id ORDER BY signature desc) AS rn
        FROM idl_msg_template_tmp
        WHERE ds="{p0}"
        ) t0
    LATERAL VIEW OUTER explode(word_keyword_list) mytable1 AS keyword
    WHERE rn=1
    ) t1
LEFT JOIN config_msg_weight_parameter t2
ON t1.keyword=t2.keyword
GROUP BY t1.tmp_id,t1.signature,t2.category
) t3
LEFT JOIN config_msg_intercept t4
ON t3.category=t4.category;