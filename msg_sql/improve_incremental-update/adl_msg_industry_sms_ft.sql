set mapreduce.job.reduces=1;
ALTER TABLE adl_msg_industry_sms_ft DROP  if exists partition (ds='{p0}');
INSERT INTO adl_msg_industry_sms_ft partition (ds='{p0}')
SELECT 
'{p0}' AS data_date,
t1.msg_industry,
t1.msg_num+IF(t2.msg_num IS NOT NULL,t2.msg_num,0) AS msg_num
FROM
    (SELECT 
    msg_industry,
    msg_num
    FROM adl_msg_industry_sms_ft
    WHERE ds='{p2}'
    ) t1
LEFT JOIN
    (SELECT 
    msg_industry AS msg_industry,
    count(id) AS msg_num
    FROM idl_msg_received_join_log
    WHERE ds='{p0}'
    group by msg_industry
    ) t2 
ON t1.msg_industry=t2.msg_industry;