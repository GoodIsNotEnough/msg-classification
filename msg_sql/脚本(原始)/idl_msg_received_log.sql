drop table idl_msg_received_log;

CREATE TABLE if not exists idl_msg_received_log
(
id              STRING COMMENT '短信id',
mobile_no       STRING COMMENT '手机号',
msg_id          STRING COMMENT '短信内容id',
status          STRING COMMENT '状态 :1,成功 2,失败',
receive_code    STRING COMMENT '抵达状态-1:接收中 0:已到达 1:空号 2:关机停机 3:发送频率过高 4:签名无效 5:黑词 6:黑名单 7:短信内容有误 99:其他 ',
create_time     STRING COMMENT '短信创建时间'
) 
comment "短信内容表"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

-- 线上
ALTER TABLE idl_msg_received_log DROP PARTITION (ds="{p0}");

FROM
  (SELECT t1.id,
          t1.mobile_no,
          t1.msg_id,
          t1.status,
          t1.receive_code,
          t1.create_time
   FROM
     (SELECT MD5(concat_ws("#",task_id,phone_no)) AS id,
             phone_no AS mobile_no,
             MD5(msg) AS msg_id,
             status,
             receive_code,
             create_time
      FROM odl_sms_log
      WHERE ds="{p0}"
      ) t1
   LEFT JOIN idl_msg_received_log t2 
   ON t1.id=t2.id
   WHERE t2.id IS NULL
   ) AS s
INSERT INTO idl_msg_received_log PARTITION (ds="{p0}")
SELECT id,
       mobile_no,
       msg_id,
       status,
       receive_code,
       create_time;

-- 初始化
ALTER TABLE idl_msg_received_log DROP PARTITION(ds="2017-07-02");
INSERT INTO idl_msg_received_log PARTITION (ds="2017-07-02")
SELECT
id,
mobile_no,
msg_id,
status,
receive_code,
create_time
FROM
    (SELECT
    id,
    mobile_no,
    msg_id,
    status,
    receive_code,
    create_time,
    row_number() over (PARTITION BY id ORDER BY create_time desc) AS rn
    FROM
        (SELECT 
        MD5(concat_ws("#",task_id,phone_no)) AS id,
        phone_no AS mobile_no,  
        MD5(msg) AS msg_id,        
        status, 
        receive_code, 
        create_time
        FROM odl_sms_log
        WHERE ds<="2017-07-02"
        ) t1
    ) t2
WHERE rn=1;



