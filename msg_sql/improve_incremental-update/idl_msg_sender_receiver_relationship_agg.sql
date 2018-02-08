ALTER TABLE idl_msg_sender_receiver_relationship_agg DROP PARTITION (ds<="{p3}");
ALTER TABLE idl_msg_sender_receiver_relationship_agg DROP PARTITION (ds="{p0}");
INSERT INTO idl_msg_sender_receiver_relationship_agg PARTITION (ds="{p0}")
SELECT
t1.signature,
t1.mobile_no,
t1.msg_num,
t1.success_num,
t1.failure_num,
IF(t2.msg_7_num IS NULL,0,t2.msg_7_num) AS msg_7_num,
IF(t2.success_7_num IS NULL,0,t2.success_7_num) AS success_7_num,
IF(t2.failure_7_num IS NULL,0,t2.failure_7_num) AS failure_7_num,
IF(t2.msg_30_num IS NULL,0,t2.msg_30_num) AS msg_30_num,
IF(t2.success_30_num IS NULL,0,t2.success_30_num) AS success_30_num,
IF(t2.failure_30_num IS NULL,0,t2.failure_30_num) AS failure_30_num,
t3.call_list,
t3.name_list,
t3.gender_list,
t3.email_list,
t4.msg_type_map,
t4.msg_industry_map 
FROM 
    (SELECT * 
    FROM idl_msg_sender_receiver_relationship_allstat_agg
    WHERE ds="{p0}"
    ) t1
LEFT JOIN
    (SELECT * 
    FROM idl_msg_sender_receiver_relationship_stat_tmp 
    WHERE ds="{p0}"
    ) t2
ON t1.signature=t2.signature AND t1.mobile_no=t2.mobile_no
LEFT JOIN
    (SELECT * 
    FROM idl_msg_sender_receiver_relationship_collect_agg 
    WHERE ds="{p0}"
    ) t3
ON t1.signature=t3.signature AND t1.mobile_no=t3.mobile_no
LEFT JOIN 
    (SELECT *
    FROM idl_msg_sender_receiver_relationship_map_agg 
    WHERE ds="{p0}"
    ) t4
ON t1.signature=t4.signature AND t1.mobile_no=t4.mobile_no;