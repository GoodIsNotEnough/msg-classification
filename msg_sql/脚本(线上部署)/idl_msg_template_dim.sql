ALTER TABLE idl_msg_template_dim DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_msg_template_dim DROP PARTITION(ds = "{p0}" );

INSERT INTO idl_msg_template_dim PARTITION (ds="{p0}")
SELECT
msg_id,
tmp_id,
word_list,
keyword_list,
signature,
match_map,
msg
FROM idl_msg_template_tmp
WHERE ds = "{p0}"
UNION ALL
SELECT
t0.msg_id,
t0.tmp_id,
t0.word_list,
t0.keyword_list,
t0.signature,
t0.match_map,
t0.msg
FROM 
    (SELECT * 
    FROM idl_msg_template_dim
    WHERE ds = "{p2}"
    ) t0
LEFT JOIN 
    (SELECT * 
    FROM idl_msg_template_tmp
    WHERE ds = "{p0}"
    ) t1
ON t0.msg_id= t1.msg_id
WHERE t1.msg_id IS NULL;