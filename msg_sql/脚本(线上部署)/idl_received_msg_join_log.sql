ALTER TABLE idl_received_msg_join_log DROP PARTITION(ds = "{p0}");
FROM
(SELECT 
st2.id,
st2.mobile_no,
st2.msg_id,
st2.status,
st2.receive_code,
st2.create_time,
st1.signature,
st1.match_map,
st1.msg_type,
st1.msg_industry
FROM
    (SELECT
    t1.msg_id,
    t1.signature,
    t1.match_map,
    t2.tmp_type AS msg_type,
    t3.sig_industry AS msg_industry
    FROM
        (SELECT *
        FROM idl_msg_template_dim
        WHERE ds="{p0}"
        ) t1
    LEFT JOIN 
        (SELECT *
        FROM idl_template_dim
        WHERE ds="{p0}"
        ) t2
    ON t1.tmp_id=t2.tmp_id
    LEFT JOIN 
        (SELECT *
        FROM idl_signature_dim
        WHERE ds="{p0}"
        ) t3
    ON t1.signature=t3.signature
    )  st1  
LEFT JOIN 
  (SELECT
    s1.id,
    s1.mobile_no,
    s1.msg_id,
    s1.status,
    s1.receive_code,
    s1.create_time
   FROM
     (SELECT *
      FROM idl_received_msg_log
      WHERE ds>="{p3}"
      ) s1
   LEFT JOIN idl_received_msg_join_log s2 
   ON s1.id=s2.id
   WHERE s2.id IS NULL
   ) st2
ON st1.msg_id=st2.msg_id
WHERE st2.msg_id IS NOT NULL
) AS t
INSERT INTO idl_received_msg_join_log PARTITION (ds="{p0}")
SELECT 
id,
mobile_no,
msg_id,
status,
receive_code,
create_time,
signature,
match_map,
msg_type,
msg_industry;