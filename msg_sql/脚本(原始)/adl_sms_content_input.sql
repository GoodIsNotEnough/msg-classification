CREATE TABLE if not exists adl_sms_content_input
(
msg_id      STRING COMMENT '短信md5',
msg         STRING COMMENT '短信内容' 
) 
comment "短信内容表"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

-- 线上
ALTER TABLE adl_sms_content_input DROP PARTITION(ds="{p0}");

FROM
(SELECT 
md5(t1.msg) AS msg_id,
t1.msg      
FROM
    (select
    DISTINCT msg
    FROM odl_sms_log
    WHERE ds="{p0}"
    ) t1
LEFT JOIN  adl_sms_content_input t2
ON md5(t1.msg)=t2.msg_id
WHERE t2.msg_id IS NULL
) AS S1
INSERT INTO adl_sms_content_input PARTITION (ds="{p0}")
SELECT msg_id,msg;

-- 初始化
ALTER TABLE adl_sms_content_input DROP PARTITION(ds='2017-06-22');
INSERT INTO adl_sms_content_input PARTITION (ds='2017-06-22')
SELECT 
md5(msg) AS msg_id,
msg      
FROM
(select 
DISTINCT msg
FROM odl_sms_log
WHERE ds<='2017-06-08'
) t;

