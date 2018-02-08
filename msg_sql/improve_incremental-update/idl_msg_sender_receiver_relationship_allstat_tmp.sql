ALTER TABLE idl_msg_sender_receiver_relationship_allstat_tmp DROP PARTITION (ds<="{p0}");
INSERT INTO idl_msg_sender_receiver_relationship_allstat_tmp PARTITION (ds="{p0}")
SELECT 
signature,
mobile_no,
COUNT(id) AS msg_num,
SUM(CASE WHEN status=1 THEN 1 ELSE 0 END) AS success_num,
SUM(CASE WHEN status=2 THEN 1 ELSE 0 END) AS failure_num
FROM idl_msg_received_join_log
WHERE ds="{p0}"
group by signature,mobile_no;