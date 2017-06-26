drop table idl_msg_template_ft;

CREATE TABLE if not exists idl_msg_template_ft
(
signature       STRING COMMENT '短信签名',
msg_num         STRING COMMENT '短信数量',
template_num    STRING COMMENT '短信模板数量' ,
proportion      FLOAT COMMENT '占比:模板数量/短信数量' 
) 
comment "短信模板监控表"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

-- 线上
ALTER TABLE idl_msg_template_ft DROP PARTITION(ds="{p0}");
INSERT INTO idl_msg_template_ft PARTITION (ds="{p0}")
SELECT 
signature,
count(1) msg_num,
count(distinct tmp_id) template_num,
count(distinct tmp_id)/count(1) proportion 
FROM idl_msg_template_tmp
WHERE ds="{p0}"
group by signature
order by template_num DESC;

--初始化
ALTER TABLE idl_msg_template_ft DROP PARTITION(ds="2017-06-22");
INSERT INTO idl_msg_template_ft PARTITION (ds="2017-06-22")
SELECT 
signature,
count(1) msg_num,
count(distinct tmp_id) template_num,
count(distinct tmp_id)/count(1) proportion 
FROM idl_msg_template_tmp
WHERE ds="2017-06-22"
group by signature
order by template_num DESC;