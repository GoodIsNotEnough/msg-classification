ALTER TABLE idl_msg_receiver_info_type_industry_agg DROP PARTITION(ds<="{p3}");
ALTER TABLE idl_msg_receiver_info_type_industry_agg DROP PARTITION(ds="{p0}");
INSERT INTO idl_msg_receiver_info_type_industry_agg PARTITION (ds="{p0}")
SELECT
s2.mobile_no,
s2.msg_type_map,
t2.msg_industry_map
FROM 
    (SELECT
    mobile_no,
    STR_TO_MAP(CONCAT_WS("\073",COLLECT_SET(CONCAT_WS("\072",msg_type,CAST(type_num AS STRING)))),"\073","\072") AS msg_type_map
    FROM
        (SELECT
        mobile_no,
        msg_type,
        SUM(type_num) AS type_num
        FROM
            (SELECT 
            mobile_no,
            msg_type,
            CAST(type_num AS INT) AS type_num
            FROM idl_msg_receiver_info_type_industry_agg
            LATERAL VIEW explode(msg_type_map) mytable AS msg_type,type_num
            WHERE ds="{p2}" AND type_num IS NOT NULL
            UNION ALL
            SELECT 
            mobile_no,
            msg_type,
            CAST(type_num AS INT) AS type_num
            FROM idl_msg_receiver_info_type_industry_tmp
            LATERAL VIEW explode(msg_type_map) mytable AS msg_type,type_num
            WHERE  ds="{p0}" AND type_num IS NOT NULL
            ) s0
        group by mobile_no,msg_type
        ) s1
    group by mobile_no
    ) s2
LEFT JOIN
    (SELECT 
    mobile_no,
    STR_TO_MAP(CONCAT_WS("\073",COLLECT_SET(CONCAT_WS("\072",msg_industry,CAST(industry_num AS STRING)))),"\073","\072") AS msg_industry_map
    FROM
       (SELECT
        mobile_no,
        msg_industry,
        SUM(industry_num) AS industry_num
        FROM
            (SELECT 
            mobile_no,
            msg_industry,
            CAST(industry_num AS INT) AS industry_num
            FROM idl_msg_receiver_info_type_industry_agg
            LATERAL VIEW explode(msg_industry_map) mytable AS msg_industry,industry_num
            WHERE ds="{p2}" AND industry_num IS NOT NULL
            UNION ALL
            SELECT 
            mobile_no,
            msg_industry,
            CAST(industry_num AS INT) AS industry_num
            FROM idl_msg_receiver_info_type_industry_tmp
            LATERAL VIEW explode(msg_industry_map) mytable AS msg_industry,industry_num
            WHERE ds="{p0}" AND industry_num IS NOT NULL
            ) t0
        group by mobile_no,msg_industry
        ) t1
    group by mobile_no
    ) t2
ON s2.mobile_no=t2.mobile_no;