ALTER TABLE idl_msg_receiver_info_agg DROP PARTITION (ds<="{p3}");
ALTER TABLE idl_msg_receiver_info_agg DROP PARTITION (ds="{p0}");
INSERT INTO idl_msg_receiver_info_agg PARTITION (ds="{p0}")
SELECT
t1.mobile_no,
t1.recent_status,
t1.msg_num,
SIZE(t2.signature_list) AS signature_num,
t2.signature_list,
t2.call_list,
t2.name_list,
t2.gender_list,
t2.email_list,
t3.msg_type_map,
t3.msg_industry_map  
FROM  
    (SELECT *
    FROM idl_msg_receiver_info_stat_agg 
    WHERE ds="{p0}"
    ) t1
LEFT JOIN
    (SELECT *
    FROM idl_msg_receiver_info_collect_agg 
    WHERE ds="{p0}"
    ) t2
ON t1.mobile_no=t2.mobile_no
LEFT JOIN 
    (SELECT *
    FROM idl_msg_receiver_info_type_industry_agg 
    WHERE ds="{p0}"
    ) t3
ON t1.mobile_no=t3.mobile_no;