ALTER TABLE idl_receiver_info_agg DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_receiver_info_agg DROP PARTITION (ds="{p0}");
INSERT INTO idl_receiver_info_agg PARTITION (ds="{p0}")
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
    FROM idl_received_msg_join_log
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
        FROM idl_received_msg_join_log
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
        FROM idl_received_msg_join_log
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
        FROM idl_received_msg_join_log
        group by mobile_no,msg_industry
        ) t6
    group by mobile_no
    ) t7
ON t1.mobile_no=t7.mobile_no;