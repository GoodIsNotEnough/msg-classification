ALTER TABLE adl_msg_industry_phone_ft DROP  if exists partition (ds='{p0}');
INSERT INTO adl_msg_industry_phone_ft partition (ds='{p0}')
SELECT 
'{p0}' AS data_date,
msg_industry as msg_industry,
count(distinct mobile_no) AS phone_num
FROM idl_msg_received_join_log
WHERE ds<='{p0}'
group by msg_industry;