drop table idl_msg_template_tmp;

CREATE TABLE if not exists idl_msg_template_tmp
(
msg_id          STRING COMMENT '短信md5',
tmp_id          STRING COMMENT '模板md5',
word_list       ARRAY<STRING> COMMENT '关键字列表',
keyword_list    ARRAY<STRING> COMMENT '关键词列表',
signature       STRING COMMENT '短信签名',
match_map       MAP<STRING,STRING> COMMENT '短信正则匹配的文本字典',
msg             STRING COMMENT '短信内容'
) 
comment "短信内容表"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE;        

--线上
ALTER TABLE idl_msg_template_tmp DROP PARTITION(ds <= "{p0}" );
INSERT INTO idl_msg_template_tmp PARTITION (ds="{p0}")
SELECT
t2.msg_id,
MD5(t2.msg_template) AS tmp_id,
split(t2.words,'\\|')      AS word_list,
split(t2.keywords,'\\|')   AS keyword_list,
t2.signature,
str_to_map(t2.match_map,"\073","\072") AS match_map,
t2.msg
FROM
    (SELECT  
    t1.msg_id,
    t1.words,
    t1.keywords,
    t1.signature,   
    substr(t1.match_map,2,length(t1.match_map)-2) AS match_map,
    t1.msg_template,
    t1.msg,
    row_number() over (PARTITION BY t1.msg_id ORDER BY t1.signature desc) AS rn
    FROM 
        (SELECT *
        FROM odl_msg_template_log
        WHERE ds LIKE "{p0}%"
        ) t1
    ) t2
WHERE rn=1;

--初始化
ALTER TABLE idl_msg_template_tmp DROP PARTITION(ds <= "2017-06-22" );
INSERT INTO idl_msg_template_tmp PARTITION (ds="2017-06-22")
SELECT
t2.msg_id,
MD5(t2.msg_template) AS tmp_id,
split(t2.words,'\\|')      AS word_list,
split(t2.keywords,'\\|')   AS keyword_list,
t2.signature,
str_to_map(t2.match_map,"\073","\072") AS match_map,
t2.msg
FROM
    (SELECT  
    t1.msg_id,
    t1.words,
    t1.keywords,
    t1.signature,   
    substr(t1.match_map,2,length(t1.match_map)-2) AS match_map,
    t1.msg_template,
    t1.msg,
    row_number() over (PARTITION BY t1.msg_id ORDER BY t1.signature desc) AS rn
    FROM 
        (SELECT *
        FROM odl_msg_template_log
        WHERE ds LIKE "2017-06-22%"
        ) t1
    ) t2
WHERE rn=1;

