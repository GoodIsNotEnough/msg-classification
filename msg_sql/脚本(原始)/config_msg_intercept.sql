load data local inpath '/data1/shell/data_tool/tmp/config_msg_intercept.csv' 
overwrite into table config_msg_intercept;

drop table config_msg_intercept;
CREATE TABLE config_msg_intercept
(dimension STRING COMMENT '维度:类型,行业',
category STRING COMMENT '类别',
intercept FLOAT COMMENT '截距'
)
comment "每个类别的截距"
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

