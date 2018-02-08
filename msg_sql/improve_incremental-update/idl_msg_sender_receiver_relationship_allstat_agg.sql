ALTER TABLE idl_msg_sender_receiver_relationship_allstat_agg DROP PARTITION (ds<="{p3}");
ALTER TABLE idl_msg_sender_receiver_relationship_allstat_agg DROP PARTITION (ds="{p0}");
INSERT INTO idl_msg_sender_receiver_relationship_allstat_agg PARTITION (ds="{p0}")
SELECT
IF(t1.signature IS NOT NULL,t1.signature,t2.signature) AS signature,
IF(t1.mobile_no IS NOT NULL,t1.mobile_no,t2.mobile_no) AS mobile_no,
IF(t1.msg_num IS NOT NULL,t1.msg_num,0)+IF(t2.msg_num IS NOT NULL,t2.msg_num,0) AS msg_num,
IF(t1.success_num IS NOT NULL,t1.success_num,0)+IF(t2.success_num IS NOT NULL,t2.success_num,0) AS success_num,
IF(t1.failure_num IS NOT NULL,t1.failure_num,0)+IF(t2.failure_num IS NOT NULL,t2.failure_num,0) AS failure_num
FROM
    (SELECT *
    FROM idl_msg_sender_receiver_relationship_allstat_agg
    WHERE ds="{p2}"
    ) t1
FULL OUTER JOIN
    (SELECT *
    FROM idl_msg_sender_receiver_relationship_allstat_tmp
    WHERE ds="{p0}"
    ) t2
ON t1.signature=t2.signature AND t1.mobile_no=t2.mobile_no;