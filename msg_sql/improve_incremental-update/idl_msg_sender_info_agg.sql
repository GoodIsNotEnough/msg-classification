ALTER TABLE idl_msg_sender_info_agg DROP PARTITION (ds<="{p3}");
ALTER TABLE idl_msg_sender_info_agg DROP PARTITION (ds="{p0}");
INSERT INTO idl_msg_sender_info_agg PARTITION (ds="{p0}")
SELECT
t2.signature,
IF(t1.msg_7_num IS NULL,0,t1.msg_7_num)             AS msg_7_num,
IF(t1.success_7_num IS NULL,0,t1.success_7_num)     AS success_7_num,   
IF(t1.failure_7_num IS NULL,0,t1.failure_7_num)     AS failure_7_num,   
IF(t1.null_7_num IS NULL,0,t1.null_7_num)           AS null_7_num,   
IF(t1.close_7_num IS NULL,0,t1.close_7_num)         AS close_7_num, 
IF(t1.blacklist_7_num IS NULL,0,t1.blacklist_7_num) AS blacklist_7_num,          
IF(t1.msg_30_num IS NULL,0,t1.msg_30_num)           AS msg_30_num,  
IF(t1.success_30_num IS NULL,0,t1.success_30_num)   AS success_30_num,  
IF(t1.failure_30_num IS NULL,0,t1.failure_30_num)   AS failure_30_num,  
IF(t1.null_30_num IS NULL,0,t1.null_30_num)         AS null_30_num,  
IF(t1.close_30_num IS NULL,0,t1.close_30_num)       AS close_30_num,  
IF(t1.blacklist_30_num IS NULL,0,t1.blacklist_30_num) AS blacklist_30_num,
t2.msg_type_map,   
t2.msg_industry_map   
FROM
    (SELECT *
    FROM idl_msg_sender_info_type_industry_agg
    WHERE ds="{p0}"
    ) t2
LEFT JOIN
    (SELECT *
    FROM idl_msg_sender_info_stat_tmp
    WHERE ds="{p0}"
    ) t1
ON t2.signature=t1.signature;