drop table if exists adl_msg_sms_phone_ft;
-- 日期 截止当前的短信数 截止当前的手机号码数 分区   
CREATE TABLE if not exists adl_msg_sms_phone_ft
(
data_date        STRING COMMENT 'date',
msg_num          INT COMMENT 'total msg number',
phone_num        INT COMMENT 'total phone number'
) 
comment "statistics of total msg_num and phone_num untill today"
PARTITIONED BY (ds STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

drop table if exists adl_msg_sms_ft;
-- 日期 新增短信数 分区
CREATE TABLE if not exists adl_msg_sms_ft
(
data_date        STRING COMMENT 'date',
msg_num    INT COMMENT 'added msg number'
) 
comment "statistics of added msg_num today"
PARTITIONED BY (ds STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

drop table if exists adl_msg_phone_ft;
-- 日期 截止当前的手机号码数  有更新的手机号码数 新增手机号码数 分区
CREATE TABLE if not exists adl_msg_phone_ft
(
data_date        STRING COMMENT 'date',
phone_num        INT COMMENT 'total phone_num',
updated_phone_num       INT COMMENT 'updated phone_num',
added_phone_num         INT COMMENT 'added phone_num'
) 
comment "statistics of total phone_num, updated and added phone_num"
PARTITIONED BY (ds STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

drop table if exists adl_msg_type_sms_ft;
-- 日期 类型 截止当前的短信数 分区
CREATE TABLE if not exists adl_msg_type_sms_ft
(
data_date        STRING COMMENT 'date',
msg_type         STRING COMMENT 'type',
msg_num          INT COMMENT 'total msg_num for type'
) 
comment "statistics of total msg_num for type"
PARTITIONED BY (ds STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

drop table if exists adl_msg_type_phone_ft;
-- 日期 类型 截止当前的手机号码数 分区
CREATE TABLE if not exists adl_msg_type_phone_ft
(
data_date        STRING COMMENT 'date',
msg_type         STRING COMMENT 'type',
phone_num        INT COMMENT 'total phone_num for type'
) 
comment "statistics of total phone_num for type"
PARTITIONED BY (ds STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

drop table if exists adl_msg_industry_sms_ft;
-- 日期 行业 截止当前的短信数 分区
CREATE TABLE if not exists adl_msg_industry_sms_ft
(
data_date        STRING COMMENT 'date',
msg_industry     STRING COMMENT 'industry',
msg_num          INT COMMENT 'total msg_num for industry'
) 
comment "statistics of total msg_num for industry"
PARTITIONED BY (ds STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

drop table if exists adl_msg_industry_phone_ft;
-- 日期 行业 截止当前的手机号码数 分区
CREATE TABLE if not exists adl_msg_industry_phone_ft
(
data_date        STRING COMMENT 'date',
msg_industry     STRING COMMENT 'industry',
phone_num        INT COMMENT 'total phone_num for industry'
) 
comment "statistics of total phone_num for industry"
PARTITIONED BY (ds STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;





