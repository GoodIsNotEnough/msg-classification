drop table odl_msg_template_log;

CREATE TABLE if not exists odl_msg_template_log
(
msg_id          STRING COMMENT '短信md5',
words           STRING COMMENT '关键字',
keywords        STRING COMMENT '关键词',
signature       STRING COMMENT '短信签名',
match_map       STRING COMMENT '短信正则匹配的文本',
msg_template    STRING COMMENT '短信模板',
msg             STRING COMMENT '短信内容'
) 
comment "短信模板内容表"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE;