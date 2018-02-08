ALTER TABLE idl_msg_sender_receiver_relationship_stat_tmp DROP PARTITION (ds<="{p0}");
INSERT INTO idl_msg_sender_receiver_relationship_stat_tmp PARTITION (ds="{p0}")
SELECT 
signature,
mobile_no,
SUM(CASE WHEN ds>date_sub("{p0}",7) THEN 1 ELSE 0 END) AS msg_7_num,
SUM(CASE WHEN ds>date_sub("{p0}",7) AND status=1 THEN 1 ELSE 0 END) AS success_7_num,
SUM(CASE WHEN ds>date_sub("{p0}",7) AND status=2 THEN 1 ELSE 0 END) AS failure_7_num,
count(1) AS msg_30_num,
SUM(CASE WHEN status=1 THEN 1 ELSE 0 END) AS success_30_num,
SUM(CASE WHEN status=2 THEN 1 ELSE 0 END) AS failure_30_num
FROM idl_msg_received_join_log
WHERE ds>date_sub("{p0}",30)
group by signature,mobile_no;