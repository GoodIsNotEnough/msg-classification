ALTER TABLE idl_received_msg_log DROP PARTITION (ds="{p0}");

FROM
  (SELECT t1.id,
          t1.mobile_no,
          t1.msg_id,
          t1.status,
          t1.receive_code,
          t1.create_time
   FROM
     (SELECT id,
             phone_no AS mobile_no,
             MD5(msg) AS msg_id,
             status,
             receive_code,
             create_time
      FROM odl_sms_log
      WHERE ds="{p0}"
      ) t1
   LEFT JOIN idl_received_msg_log t2 
   ON t1.id=t2.id
   WHERE t2.id IS NULL
   ) AS s
INSERT INTO idl_received_msg_log PARTITION (ds="{p0}")
SELECT id,
       mobile_no,
       msg_id,
       status,
       receive_code,
       create_time;