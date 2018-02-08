set mapreduce.job.reduces=1;
ALTER TABLE adl_msg_type_phone_ft DROP if exists partition (ds='{p0}');
INSERT INTO adl_msg_type_phone_ft partition (ds='{p0}')
SELECT 
'{p0}' AS data_date,
msg_type,
count(distinct mobile_no) AS phone_num
FROM
    (SELECT
    mobile_no,
    msg_type,
    sms_num
    FROM idl_msg_receiver_info_agg
    LATERAL VIEW explode(msg_type_map) mytable AS msg_type,sms_num
    WHERE ds='{p0}'
    ) t1
WHERE sms_num IS NOT NULL
group by msg_type;