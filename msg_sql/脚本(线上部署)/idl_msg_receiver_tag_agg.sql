ALTER TABLE idl_msg_receiver_tag_agg DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_msg_receiver_tag_agg DROP PARTITION (ds="{p0}");
INSERT INTO idl_msg_receiver_tag_agg PARTITION (ds="{p0}")
SELECT
mobile_no,
mobile_status,
collect_set(tag) AS msg_tag
FROM
    (SELECT
    mobile_no,
    mobile_status,
    CASE  WHEN attribute0="互联网金融" THEN "有资金需求"
          WHEN attribute0="汽车服务"   OR attribute0="车险保单" THEN "有汽车"
          WHEN attribute0="生活服务"   THEN "喜好消费卡"
          WHEN attribute0="教育"       THEN "有孩子"
          WHEN attribute0="旅行"       THEN "喜欢旅游"
          ELSE NULL
          END AS tag
    FROM
        (SELECT
        mobile_no,
        CASE WHEN recent_status='1' THEN '无效'
             WHEN recent_status='2' THEN '无效'
             WHEN recent_status='6' THEN '无效'
             ELSE '有效'
             END AS mobile_status,
        msg_industry_map
        FROM idl_msg_receiver_info_agg
        WHERE ds="{p0}"
        ) t1
    LATERAL VIEW OUTER explode(msg_industry_map) mytable AS attribute0,value0
    ) t2
group by mobile_no,mobile_status;