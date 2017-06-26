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