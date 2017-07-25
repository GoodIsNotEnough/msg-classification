ALTER TABLE adl_msg_sms_phone_ft DROP if exists partition (ds='{p0}');
INSERT INTO adl_msg_sms_phone_ft partition (ds='{p0}')
SELECT 
'{p0}' AS data_date,
count(id) AS msg_num,
count(distinct mobile_no) AS phone_num
FROM idl_msg_received_join_log
WHERE ds<='{p0}';