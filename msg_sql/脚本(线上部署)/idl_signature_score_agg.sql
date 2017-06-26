ALTER TABLE idl_signature_score_agg DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_signature_score_agg DROP PARTITION(ds = "{p0}" );

INSERT INTO idl_signature_score_agg PARTITION (ds="{p0}")
SELECT
signature,
tmp_industry AS sig_industry,
count(tmp_id) AS tmp_num,     
avg(industry_prob) AS ave_prob
FROM idl_template_dim
WHERE ds = "{p0}"
GROUP BY signature,tmp_industry