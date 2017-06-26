ALTER TABLE idl_msg_template_ft DROP PARTITION(ds="{p0}");
INSERT INTO idl_msg_template_ft PARTITION (ds="{p0}")
SELECT 
signature,
count(1) msg_num,
count(distinct tmp_id) template_num,
count(distinct tmp_id)/count(1) proportion 
FROM idl_msg_template_tmp
WHERE ds="{p0}"
group by signature
order by template_num DESC;