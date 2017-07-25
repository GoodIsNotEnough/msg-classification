ALTER TABLE adl_msg_industry_sms_ft DROP  if exists partition (ds='{p0}');
INSERT INTO adl_msg_industry_sms_ft partition (ds='{p0}')
SELECT 
'{p0}' AS data_date,
msg_industry AS msg_industry,
count(id) AS msg_num
FROM idl_msg_received_join_log
WHERE ds<='{p0}'
group by msg_industry;