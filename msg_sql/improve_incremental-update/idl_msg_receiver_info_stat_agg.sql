ALTER TABLE idl_msg_receiver_info_stat_agg DROP PARTITION (ds<="{p3}");
ALTER TABLE idl_msg_receiver_info_stat_agg DROP PARTITION(ds="{p0}" );
INSERT INTO idl_msg_receiver_info_stat_agg PARTITION (ds="{p0}")
SELECT 
IF(t1.mobile_no IS NOT NULL,t1.mobile_no,t2.mobile_no) AS mobile_no,
IF(t2.recent_status IS NOT NULL,t2.recent_status,t1.recent_status) AS recent_status,
IF(t1.msg_num IS NOT NULL,t1.msg_num,0)+IF(t2.msg_num IS NOT NULL,t2.msg_num,0) AS msg_num
FROM
    (SELECT *
    FROM idl_msg_receiver_info_stat_agg
    WHERE ds="{p2}"
    ) t1
FULL OUTER JOIN
    (SELECT *
    FROM idl_msg_receiver_info_stat_tmp
    WHERE ds="{p0}"
    ) t2
ON t1.mobile_no=t2.mobile_no;