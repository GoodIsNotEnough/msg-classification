show partitions idl_msg_signature_score_agg;
alter table idl_msg_template_ft add partition(ds='2017-07-18');
show partitions  idl_msg_signature_info_dim;

alter table idl_msg_sender_receiver_relationship_agg add partition(ds='2017-07-18');

drop table tmp_mobile_uid;

CREATE TABLE if not exists tmp_mobile_uid
(
uid             STRING,
mobile_no       STRING
) 
-- comment "短信内容表"
-- PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

INSERT INTO tmp_mobile_uid
SELECT
user_id AS uid,
moblie_no
FROM odl_moblie_sms_user_log
GROUP by user_id,moblie_no;

SELECT count(1)
FROM tmp_mobile_uid;
-- CREATE TABLE if not exists tmp_mobile_uid_dis
-- (
-- uid             STRING,
-- mobile_no       STRING
-- ) 
-- comment "短信内容表"
-- PARTITIONED BY (ds STRING) 
-- ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
-- STORED AS TEXTFILE;

-- INSERT INTO tmp_mobile_uid_dis
-- SELECT
-- DISTINCT user_id AS uid,moblie_no
-- FROM odl_moblie_sms_user_log;
SELECT count(1)
FROM tmp_mobile_uid_dis;

drop table tmp_idl_msg_received_log;
CREATE TABLE if not exists tmp_idl_msg_received_log
(
id              STRING ,
mobile_no       STRING ,
msg_id          STRING ,
status          STRING ,
receive_code    STRING ,
create_time     STRING 
) 
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

INSERT INTO tmp_idl_msg_received_log PARTITION (ds)
SELECT 
t1.id,
t2.uid,
t1.msg_id,
t1.status,
t1.receive_code,
t1.create_time,
t1.ds
FROM idl_msg_received_log t1
LEFT JOIN tmp_mobile_uid t2
ON t1.mobile_no=t2.mobile_no;

ALTER TABLE idl_msg_received_log DROP PARTITION(ds<="2017-07-19");

INSERT INTO idl_msg_received_log PARTITION (ds)
SELECT * 
FROM tmp_idl_msg_received_log;

SELECT *
FROM tmp_idl_msg_received_log
WHERE ds="2017-07-17"
limit 10;




