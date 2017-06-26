INSERT INTO config_load_data_log
(source_path, server_url, table_name, insertdt, data_desc, data_base) 
VALUES 
('/data1/shell/data_tool/resultdata/msg_cont', 'hdfs://172.31.9.255:9000/user/hive/warehouse/leesdata.db', 'odl_msg_template_log',NOW(), '下载短信内容表', 'leesdata');

INSERT INTO config_task_log
(task_type, source_folder, insertdt, result_path, result_folder, code_file) 
VALUES 
('msg_cont', 'msg_cont', NOW(), 'resultdata', 'msg_cont', '/data1/shell/data_tool/task_file/msg_cont/main.py');

--注：task_id来自config_task_log表
INSERT INTO config_api_log
(api_url, parallel_num, task_id, insertdt, updatedt, data_desc) 
VALUES 
('url is not exist', 2, 6, NOW(), NOW(), '短信模板提取');