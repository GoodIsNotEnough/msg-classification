drop table idl_msg_receiver_info_agg;

CREATE TABLE if not exists idl_msg_receiver_info_agg
(
mobile_no       STRING COMMENT '收信人手机号',
recent_status   STRING COMMENT '最近号码状态 1:空号 2:关机停机 6:黑名单 0:其他',
msg_num         INT    COMMENT '被发送的短信数量',
signature_num   INT    COMMENT '发信人签名数量',
signature_list  ARRAY<STRING> COMMENT '签名列表',
call_list       ARRAY<STRING> COMMENT '称呼列表',
name_list       ARRAY<STRING> COMMENT '名字列表',
gender_list     ARRAY<STRING> COMMENT '性别列表',
email_list      ARRAY<STRING> COMMENT 'email列表',
msg_type_map    MAP<STRING,STRING> COMMENT '类别',
msg_industry_map    MAP<STRING,STRING> COMMENT '行业'
) 
comment "收信人统计表"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE;

ALTER TABLE idl_msg_receiver_info_agg DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_msg_receiver_info_agg DROP PARTITION (ds="{p0}");
INSERT INTO idl_msg_receiver_info_agg PARTITION (ds="{p0}")
SELECT
t1.mobile_no,
t3.receive_code AS recent_status,
t1.msg_num,
t1.signature_num,
t1.signature_list,
t1.call_list,
t1.name_list,
t1.gender_list,
t1.email_list,
t5.msg_type_map,
t7.msg_industry_map  
FROM 
    (SELECT
    mobile_no,
    COUNT(id) msg_num,
    COUNT(DISTINCT signature) signature_num,
    collect_set(signature) signature_list,
    collect_set(match_map['call']) call_list,
    collect_set(match_map['name']) name_list,
    collect_set(match_map['gender']) gender_list,
    collect_set(match_map['email']) email_list
    FROM idl_msg_received_join_log
    group by mobile_no
    ) t1
LEFT JOIN 
    (SELECT 
    mobile_no,
    receive_code
    FROM
        (SELECT 
        mobile_no,
        receive_code,
        row_number() over (PARTITION BY mobile_no ORDER BY create_time desc) AS rn
        FROM idl_msg_received_join_log
        ) t2
    WHERE rn=1
    ) t3
ON t1.mobile_no=t3.mobile_no
LEFT JOIN
    (SELECT
    mobile_no,
    STR_TO_MAP(CONCAT_WS("\073",COLLECT_SET(CONCAT_WS("\072",msg_type,CAST(type_num AS STRING)))),"\073","\072") AS msg_type_map
    FROM
        (SELECT 
        mobile_no,
        msg_type,
        count(1) type_num
        FROM idl_msg_received_join_log
        group by mobile_no,msg_type
        ) t4
    group by mobile_no
    ) t5
ON t1.mobile_no=t5.mobile_no
LEFT JOIN
    (SELECT
    mobile_no,
    STR_TO_MAP(CONCAT_WS("\073",COLLECT_SET(CONCAT_WS("\072",msg_industry,CAST(msg_industry_num AS STRING)))),"\073","\072") AS msg_industry_map
    FROM
        (SELECT 
        mobile_no,
        msg_industry,
        count(1) msg_industry_num
        FROM idl_msg_received_join_log
        group by mobile_no,msg_industry
        ) t6
    group by mobile_no
    ) t7
ON t1.mobile_no=t7.mobile_no;