ALTER TABLE idl_msg_template_score_tmp DROP PARTITION(ds <= "{p0}" );
INSERT INTO idl_msg_template_score_tmp PARTITION (ds="{p0}")
SELECT
t1.tmp_id,
t1.signature,
t1.dimension,
t1.category,
t1.score/t2.sum_score AS probability
FROM 
    (SELECT *
    FROM idl_msg_template_raw_score_tmp
    WHERE ds="{p0}" 
    ) t1
LEFT JOIN 
    (SELECT 
    tmp_id,
    dimension,
    sum(score) sum_score
    FROM idl_msg_template_raw_score_tmp
    WHERE ds="{p0}"
    GROUP BY tmp_id,dimension
    ) t2
ON t1.tmp_id=t2.tmp_id AND t1.dimension=t2.dimension;
