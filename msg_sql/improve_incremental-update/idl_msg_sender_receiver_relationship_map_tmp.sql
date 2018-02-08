ALTER TABLE idl_msg_sender_receiver_relationship_map_tmp DROP PARTITION (ds<="{p0}");
INSERT INTO idl_msg_sender_receiver_relationship_map_tmp PARTITION (ds="{p0}")
SELECT
t3.signature,
t3.mobile_no,
t3.msg_type_map,
t5.msg_industry_map 
FROM
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
        FROM idl_msg_received_join_log
        group by signature,mobile_no,msg_type
        ) t2
    group by signature,mobile_no
    ) t3
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
        FROM idl_msg_received_join_log
        group by signature,mobile_no,msg_industry
        ) t4
    group by signature,mobile_no
    ) t5
ON t3.signature=t5.signature AND t3.mobile_no=t5.mobile_no;