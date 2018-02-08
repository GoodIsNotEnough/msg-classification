ALTER TABLE idl_msg_receiver_info_stat_tmp DROP PARTITION(ds<="{p0}" );
INSERT INTO idl_msg_receiver_info_stat_tmp PARTITION (ds="{p0}")
SELECT 
mobile_no,
receive_code AS recent_status,
msg_num
FROM
    (SELECT 
    mobile_no,
    receive_code,
    count(1)over (PARTITION BY mobile_no) AS msg_num,
    row_number() over (PARTITION BY mobile_no ORDER BY create_time desc) AS rn
    FROM idl_msg_received_join_log
    WHERE ds="{p0}"
    ) t1
WHERE rn=1;