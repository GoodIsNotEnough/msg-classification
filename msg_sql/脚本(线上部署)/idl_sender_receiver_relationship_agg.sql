ALTER TABLE idl_sender_receiver_relationship_agg DROP PARTITION(ds<="{p3}" );
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