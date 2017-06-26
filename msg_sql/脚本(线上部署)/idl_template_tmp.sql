ALTER TABLE idl_template_tmp DROP PARTITION(ds <= "{p0}" );

INSERT INTO idl_template_tmp PARTITION (ds="{p0}")
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
    FROM idl_template_score_tmp
    WHERE ds = "{p0}" 
    AND dimension='类型'
    ) t0
WHERE rn=1
) t1
LEFT JOIN
    (SELECT
    tmp_id,
    str_to_map(concat_ws("\073",collect_list(concat_ws('\072', category,CAST(probability AS STRING)))),"\073","\072") AS prob_map
    FROM idl_template_score_tmp
    WHERE ds = "{p0}" 
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
    FROM idl_template_score_tmp
    WHERE ds = "{p0}" 
    AND dimension='行业'
    ) s0
WHERE rn=1
) s1
LEFT JOIN
    (SELECT
    tmp_id,
    str_to_map(concat_ws("\073",collect_list(concat_ws('\072', category,CAST(probability AS STRING)))),"\073","\072") AS prob_map
    FROM idl_template_score_tmp
    WHERE ds = "{p0}" 
    AND dimension='行业'
    GROUP BY tmp_id
    ) s2
ON s1.tmp_id=s2.tmp_id
) s012
ON t012.tmp_id=s012.tmp_id;