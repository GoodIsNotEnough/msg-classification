ALTER TABLE idl_msg_sender_info_agg DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_msg_sender_info_agg DROP PARTITION (ds="{p0}");
INSERT INTO idl_msg_sender_info_agg PARTITION (ds="{p0}")
SELECT
t1.signature,
t1.receiver_num,
t1.msg_num,
t1.success_num,    
t1.failure_num,    
t1.null_num,       
t1.close_num,      
t1.blacklist_num,   
t1.msg_7_num,      
t1.success_7_num,  
t1.failure_7_num,  
t1.null_7_num,     
t1.close_7_num,    
t1.blacklist_7_num, 
t1.msg_30_num,     
t1.success_30_num, 
t1.failure_30_num,
t1.null_30_num,    
t1.close_30_num,   
t1.blacklist_30_num,
t3.msg_type_map,   
t5.msg_industry_map   
FROM
    (SELECT 
    signature,
    COUNT(DISTINCT mobile_no) AS receiver_num,
    COUNT(id) AS msg_num,
    SUM(CASE WHEN status=1 THEN 1 ELSE 0 END) AS success_num,
    SUM(CASE WHEN status=2 THEN 1 ELSE 0 END) AS failure_num,
    SUM(CASE WHEN receive_code=1 THEN 1 ELSE 0 END) AS null_num,
    SUM(CASE WHEN receive_code=2 THEN 1 ELSE 0 END) AS close_num,
    SUM(CASE WHEN receive_code=6 THEN 1 ELSE 0 END) AS blacklist_num,
    SUM(CASE WHEN ds>date_sub("{p0}",7) THEN 1 ELSE 0 END) AS msg_7_num,
    SUM(CASE WHEN ds>date_sub("{p0}",7) AND status=1 THEN 1 ELSE 0 END) AS success_7_num,
    SUM(CASE WHEN ds>date_sub("{p0}",7) AND status=2 THEN 1 ELSE 0 END) AS failure_7_num,
    SUM(CASE WHEN ds>date_sub("{p0}",7) AND receive_code=1 THEN 1 ELSE 0 END) AS null_7_num,
    SUM(CASE WHEN ds>date_sub("{p0}",7) AND receive_code=2 THEN 1 ELSE 0 END) AS close_7_num,
    SUM(CASE WHEN ds>date_sub("{p0}",7) AND receive_code=6 THEN 1 ELSE 0 END) AS blacklist_7_num,
    SUM(CASE WHEN ds>date_sub("{p0}",30) THEN 1 ELSE 0 END) AS msg_30_num,
    SUM(CASE WHEN ds>date_sub("{p0}",30) AND status=1 THEN 1 ELSE 0 END) AS success_30_num,
    SUM(CASE WHEN ds>date_sub("{p0}",30) AND status=2 THEN 1 ELSE 0 END) AS failure_30_num,
    SUM(CASE WHEN ds>date_sub("{p0}",30) AND receive_code=1 THEN 1 ELSE 0 END) AS null_30_num,
    SUM(CASE WHEN ds>date_sub("{p0}",30) AND receive_code=2 THEN 1 ELSE 0 END) AS close_30_num,
    SUM(CASE WHEN ds>date_sub("{p0}",30) AND receive_code=6 THEN 1 ELSE 0 END) AS blacklist_30_num
    FROM idl_msg_received_join_log
    group by signature
    ) t1
LEFT JOIN
    (SELECT
    signature,
    STR_TO_MAP(CONCAT_WS("\073",COLLECT_SET(CONCAT_WS("\072",msg_type,CAST(type_num AS STRING)))),"\073","\072") AS msg_type_map
    FROM
        (SELECT 
        signature,
        msg_type,
        count(1) type_num
        FROM idl_msg_received_join_log
        group by signature,msg_type
        ) t2
    group by signature   
    ) t3
ON t1.signature=t3.signature
LEFT JOIN
    (SELECT
    signature,
    STR_TO_MAP(CONCAT_WS("\073",COLLECT_SET(CONCAT_WS("\072",msg_industry,CAST(msg_industry_num AS STRING)))),"\073","\072") AS msg_industry_map
    FROM
        (SELECT 
        signature,
        msg_industry,
        count(1) msg_industry_num
        FROM idl_msg_received_join_log
        group by signature,msg_industry
        ) t4
    group by signature
    ) t5
ON t1.signature=t5.signature;