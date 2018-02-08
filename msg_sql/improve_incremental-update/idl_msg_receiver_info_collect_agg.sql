add jar hdfs://172.31.6.206:8020/user/dc/func/hive-third-functions-2.1.1-shaded.jar;
create temporary function array_concat as 'cc.shanruifeng.functions.array.UDFArrayConcat';
create temporary function array_distinct as 'cc.shanruifeng.functions.array.UDFArrayDistinct';

ALTER TABLE idl_msg_receiver_info_collect_agg DROP PARTITION(ds<="{p3}");
ALTER TABLE idl_msg_receiver_info_collect_agg DROP PARTITION (ds="{p0}");
INSERT INTO idl_msg_receiver_info_collect_agg PARTITION (ds="{p0}")
SELECT
IF(t1.mobile_no IS NOT NULL,t1.mobile_no,t2.mobile_no) AS mobile_no,
CASE  WHEN t1.signature_list IS NULL THEN t2.signature_list
      WHEN t2.signature_list IS NULL THEN t1.signature_list
      WHEN t1.signature_list IS NOT NULL AND t2.signature_list IS NOT NULL 
      THEN array_distinct(array_concat(t1.signature_list,t2.signature_list))
END AS signature_list,
CASE  WHEN t1.call_list IS NULL THEN t2.call_list
      WHEN t2.call_list IS NULL THEN t1.call_list
      WHEN t1.call_list IS NOT NULL AND t2.call_list IS NOT NULL 
      THEN array_distinct(array_concat(t1.call_list,t2.call_list))
END AS call_list,
CASE  WHEN t1.name_list IS NULL THEN t2.name_list
      WHEN t2.name_list IS NULL THEN t1.name_list
      WHEN t1.name_list IS NOT NULL AND t2.name_list IS NOT NULL 
      THEN array_distinct(array_concat(t1.name_list,t2.name_list))
END AS name_list,
CASE  WHEN t1.gender_list IS NULL THEN t2.gender_list
      WHEN t2.gender_list IS NULL THEN t1.gender_list
      WHEN t1.gender_list IS NOT NULL AND t2.gender_list IS NOT NULL 
      THEN array_distinct(array_concat(t1.gender_list,t2.gender_list))
END AS gender_list,
CASE  WHEN t1.email_list IS NULL THEN t2.email_list
      WHEN t2.email_list IS NULL THEN t1.email_list
      WHEN t1.email_list IS NOT NULL AND t2.email_list IS NOT NULL 
      THEN array_distinct(array_concat(t1.email_list,t2.email_list))
END AS email_list
FROM
    (SELECT *
    FROM idl_msg_receiver_info_collect_agg
    WHERE ds="{p2}"
    ) t1
FULL OUTER JOIN
    (SELECT *
    FROM idl_msg_receiver_info_collect_tmp
    WHERE ds="{p0}"
    ) t2
ON t1.mobile_no=t2.mobile_no;