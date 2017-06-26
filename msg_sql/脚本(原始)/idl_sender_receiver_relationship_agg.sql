drop table idl_sender_receiver_relationship_agg;

CREATE TABLE if not exists idl_sender_receiver_relationship_agg
(
signature          STRING COMMENT '短信签名',
mobile_no          STRING COMMENT '接收方手机号',
msg_num            INT    COMMENT '发送短信数量',
success_num        INT    COMMENT '发送成功的短信数量',
failure_num        INT    COMMENT '发送失败的短信数量',
msg_7_num          INT    COMMENT '发送短信数量',
success_7_num      INT    COMMENT '发送成功的短信数量',
failure_7_num      INT    COMMENT '发送失败的短信数量',
msg_30_num         INT    COMMENT '发送短信数量',
success_30_num     INT    COMMENT '发送成功的短信数量',
failure_30_num     INT    COMMENT '发送失败的短信数量',
call_list          ARRAY<STRING> COMMENT '称呼列表',
name_list          ARRAY<STRING> COMMENT '名字列表',
gender_list        ARRAY<STRING> COMMENT '性别列表',
email_list         ARRAY<STRING> COMMENT 'email列表',
msg_type_map       MAP<STRING,STRING> COMMENT '类别',
msg_industry_map       MAP<STRING,STRING> COMMENT '行业'
) 
comment "签名发送短信统计表"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE;

-- 线上
ALTER TABLE idl_sender_receiver_relationship_agg DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_sender_receiver_relationship_agg DROP PARTITION (ds="{p0}");
INSERT INTO idl_sender_receiver_relationship_agg PARTITION (ds="{p0}")
SELECT
t1.signature,
t1.mobile_no,
t1.msg_num,
t1.success_num,
t1.failure_num,
t1.msg_7_num,       
t1.success_7_num,   
t1.failure_7_num,   
t1.msg_30_num,      
t1.success_30_num,
t1.failure_30_num,  
t1.call_list,
t1.name_list,
t1.gender_list,
t1.email_list,
t3.msg_type_map,
t5.msg_industry_map 
FROM
(SELECT 
signature,
mobile_no,
COUNT(id) AS msg_num,
SUM(CASE WHEN status=1 THEN 1 ELSE 0 END) AS success_num,
SUM(CASE WHEN status=2 THEN 1 ELSE 0 END) AS failure_num,
SUM(CASE WHEN ds>date_sub("{p0}",7) THEN 1 ELSE 0 END) AS msg_7_num,
SUM(CASE WHEN ds>date_sub("{p0}",7) AND status=1 THEN 1 ELSE 0 END) AS success_7_num,
SUM(CASE WHEN ds>date_sub("{p0}",7) AND status=2 THEN 1 ELSE 0 END) AS failure_7_num,
SUM(CASE WHEN ds>date_sub("{p0}",30) THEN 1 ELSE 0 END) AS msg_30_num,
SUM(CASE WHEN ds>date_sub("{p0}",30) AND status=1 THEN 1 ELSE 0 END) AS success_30_num,
SUM(CASE WHEN ds>date_sub("{p0}",30) AND status=2 THEN 1 ELSE 0 END) AS failure_30_num,
collect_set(match_map['call']) call_list,
collect_set(match_map['name']) name_list,
collect_set(match_map['gender']) gender_list,
collect_set(match_map['email']) email_list
FROM idl_received_msg_join_log
group by signature,mobile_no
) t1
LEFT JOIN
    (SELECT
    signature,
    mobile_no,
    STR_TO_MAP(CONCAT_WS("\073",COLLECT_SET(CONCAT_WS("\072",msg_type,CAST(type_num AS STRING)))),"\073","\072") AS msg_type_map
    FROM
        (SELECT 
        signature,
        mobile_no,
        msg_type,
        count(1) type_num
        FROM idl_received_msg_join_log
        group by signature,mobile_no,msg_type
        ) t2
    group by signature,mobile_no
    ) t3
ON t1.signature=t3.signature AND t1.mobile_no=t3.mobile_no
LEFT JOIN
    (SELECT
    signature,
    mobile_no,
    STR_TO_MAP(CONCAT_WS("\073",COLLECT_SET(CONCAT_WS("\072",msg_industry,CAST(msg_industry_num AS STRING)))),"\073","\072") AS msg_industry_map
    FROM
        (SELECT 
        signature,
        mobile_no,
        msg_industry,
        count(1) msg_industry_num
        FROM idl_received_msg_join_log
        group by signature,mobile_no,msg_industry
        ) t4
    group by signature,mobile_no
    ) t5
ON t1.signature=t5.signature AND t1.mobile_no=t5.mobile_no;








