set mapreduce.job.reduces=1;
ALTER TABLE adl_msg_sms_phone_ft DROP if exists partition (ds='{p0}');
INSERT INTO adl_msg_sms_phone_ft partition (ds='{p0}')
SELECT 
'{p0}' AS data_date,
t1.msg_num+t2.msg_num AS msg_num,
t3.phone_num
FROM
    (SELECT *
    FROM adl_msg_sms_phone_ft
    WHERE ds='{p2}'
    ) t1
LEFT JOIN
    (SELECT
    count(id) AS msg_num
    FROM idl_msg_received_join_log
    WHERE ds='{p0}'
    ) t2
LEFT JOIN
    (SELECT
    count(1) AS phone_num
    FROM idl_msg_receiver_info_agg
    WHERE ds='{p0}'
    ) t3;