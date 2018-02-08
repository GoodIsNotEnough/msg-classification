set mapreduce.job.reduces=1;
ALTER TABLE adl_msg_sms_ft DROP if exists partition (ds='{p0}');
INSERT INTO adl_msg_sms_ft partition (ds='{p0}')
SELECT 
'{p0}' AS data_date,
count(id) AS added_msg_num
FROM idl_msg_received_join_log
WHERE ds='{p0}';