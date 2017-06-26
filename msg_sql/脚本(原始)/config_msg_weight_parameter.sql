load data local inpath '/data1/shell/data_tool/tmp/config_msg_weight_parameter.csv' 
overwrite into table config_msg_weight_parameter;

drop table config_msg_weight_parameter;
CREATE TABLE config_msg_weight_parameter
(keyword STRING COMMENT '关键词/字',
category STRING COMMENT '类别',
weight   FLOAT COMMENT '权重系数'
)
comment "V_nxk*Sigma_kxk.I*weight"
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

