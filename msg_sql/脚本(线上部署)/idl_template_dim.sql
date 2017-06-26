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