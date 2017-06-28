-- 配置task信息
ALTER TABLE adl_sms_content_input RENAME TO adl_msg_content_input;
ALTER TABLE idl_received_msg_log RENAME TO idl_msg_received_log;
-- ALTER TABLE split_adl_sms_content_input RENAME TO split_adl_msg_content_input;
-- ALTER TABLE idl_msg_template_tmp RENAME TO idl_msg_template_tmp;
-- ALTER TABLE idl_msg_template_dim RENAME TO idl_msg_template_dim;
-- ALTER TABLE idl_msg_template_ft RENAME TO idl_msg_template_ft;
ALTER TABLE idl_template_raw_score_tmp RENAME TO idl_msg_template_raw_score_tmp;
ALTER TABLE idl_template_score_tmp RENAME TO idl_msg_template_score_tmp;
ALTER TABLE idl_template_tmp  RENAME TO idl_msg_template_info_tmp;
ALTER TABLE idl_template_dim  RENAME TO idl_msg_template_info_dim;
ALTER TABLE idl_signature_score_agg  RENAME TO idl_msg_signature_score_agg;
ALTER TABLE idl_signature_dim RENAME TO idl_msg_signature_info_dim;
ALTER TABLE idl_received_msg_join_log RENAME TO idl_msg_received_join_log;
ALTER TABLE idl_sender_info_agg RENAME TO idl_msg_sender_info_agg;
ALTER TABLE idl_receiver_info_agg RENAME TO idl_msg_receiver_info_agg;
ALTER TABLE idl_sender_receiver_relationship_agg RENAME TO idl_msg_sender_receiver_relationship_agg;

-- adl_msg_content_input
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("adl_msg_content_input",
     "./task_file/msg_daily/adl_msg_content_input.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("adl_msg_content_input",
    "adl_msg_content_input",
     0,
     now());
     
-- odl表默认是有的，不需要配置
-- INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
-- VALUES("adl_msg_content_input",
     -- "odl_sms_log",
     -- now());
     
-- idl_msg_received_log
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_msg_received_log",
     "./task_file/msg_daily/idl_msg_received_log.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_msg_received_log",
    "idl_msg_received_log",
     0,
     now());
-- odl表默认是有的，不需要配置
-- INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
-- VALUES("idl_msg_received_log",
     -- "odl_sms_log",
     -- now());
     
-- split_adl_msg_content_input     
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("split_adl_msg_content_input",
     "./task_file/msg_daily/split_adl_msg_content_input.sh",
      now(),
      now(),
     "shell_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("split_adl_msg_content_input",
    "split_adl_msg_content_input",
     0,
     now()); 
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("split_adl_msg_content_input",
    "adl_msg_content_input",
     now());

-- idl_msg_template_tmp
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_msg_template_tmp",
     "./task_file/msg_daily/idl_msg_template_tmp.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_msg_template_tmp",
    "idl_msg_template_tmp",
     0,
     now());
-- odl表默认是有的,不需要配置 
-- INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
-- VALUES("idl_msg_template_tmp",
     -- "odl_msg_template_log",
     -- now());  
     
-- idl_msg_template_dim
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_msg_template_dim",
     "./task_file/msg_daily/idl_msg_template_dim.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_msg_template_dim",
    "idl_msg_template_dim",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_msg_template_dim",
    "idl_msg_template_tmp",
     now());  
     
-- idl_msg_template_ft
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_msg_template_ft",
     "./task_file/msg_daily/idl_msg_template_ft.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_msg_template_ft",
    "idl_msg_template_ft",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_msg_template_ft",
    "idl_msg_template_tmp",
     now());  

-- idl_msg_template_raw_score_tmp +
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_msg_template_raw_score_tmp",
     "./task_file/msg_daily/idl_msg_template_raw_score_tmp.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_msg_template_raw_score_tmp",
    "idl_msg_template_raw_score_tmp",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_msg_template_raw_score_tmp",
    "idl_msg_template_tmp",
     now());  

-- idl_msg_template_score_tmp +
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_msg_template_score_tmp",
     "./task_file/msg_daily/idl_msg_template_score_tmp.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_msg_template_score_tmp",
    "idl_msg_template_score_tmp",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) 
VALUES("idl_msg_template_score_tmp",
    "idl_msg_template_raw_score_tmp",
     now());       

-- idl_msg_template_info_tmp
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_msg_template_info_tmp",
     "./task_file/msg_daily/idl_msg_template_info_tmp.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_msg_template_info_tmp",
    "idl_msg_template_info_tmp",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) -- 修改
VALUES("idl_msg_template_info_tmp",
    "idl_msg_template_score_tmp",
     now());  

-- idl_msg_template_info_dim
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_msg_template_info_dim",
     "./task_file/msg_daily/idl_msg_template_info_dim.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_msg_template_info_dim",
    "idl_msg_template_info_dim",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_msg_template_info_dim",
    "idl_msg_template_info_tmp",
     now());  

-- idl_msg_signature_score_agg +
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_msg_signature_score_agg",
     "./task_file/msg_daily/idl_msg_signature_score_agg.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_msg_signature_score_agg",
    "idl_msg_signature_score_agg",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_msg_signature_score_agg",
    "idl_msg_template_info_dim",
     now());  

-- idl_msg_signature_info_dim +
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_msg_signature_info_dim",
     "./task_file/msg_daily/idl_msg_signature_info_dim.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_msg_signature_info_dim",
    "idl_msg_signature_info_dim",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_msg_signature_info_dim",
    "idl_msg_signature_score_agg",
     now());  
  
-- idl_msg_received_join_log
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_msg_received_join_log",
     "./task_file/msg_daily/idl_msg_received_join_log.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_msg_received_join_log",
    "idl_msg_received_join_log",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_msg_received_join_log",
    "idl_msg_template_dim",
     now());  
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_msg_received_join_log",
    "idl_msg_template_info_dim",
     now());  
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_msg_received_join_log",
    "idl_msg_signature_info_dim",
     now());  
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_msg_received_join_log",
    "idl_msg_received_log",
     now());  
     
-- idl_msg_sender_info_agg
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_msg_sender_info_agg",
     "./task_file/msg_daily/idl_msg_sender_info_agg.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_msg_sender_info_agg",
    "idl_msg_sender_info_agg",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_msg_sender_info_agg",
    "idl_msg_received_join_log",
     now());  

-- idl_msg_receiver_info_agg
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_msg_receiver_info_agg",
     "./task_file/msg_daily/idl_msg_receiver_info_agg.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_msg_receiver_info_agg",
    "idl_msg_receiver_info_agg",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_msg_receiver_info_agg",
    "idl_msg_received_join_log",
     now());  

-- idl_msg_sender_receiver_relationship_agg
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_msg_sender_receiver_relationship_agg",
     "./task_file/msg_daily/idl_msg_sender_receiver_relationship_agg.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_msg_sender_receiver_relationship_agg",
    "idl_msg_sender_receiver_relationship_agg",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_msg_sender_receiver_relationship_agg",
    "idl_msg_received_join_log",
     now());  
     
-- 配置job信息
INSERT INTO plan_job_config (job_name,job_type,PARAMETER,par_end,PARALLEL,begin_time,insertdt,updatedt,job_status,is_debug)
VALUES ("msg_daily",
     "daily",
     "2016-01-01",
     "2016-04-09",
      2,
     "00:00:00",
      now(),
      now(),
      0,
      1);

INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "adl_msg_content_input",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "idl_msg_received_log",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "split_adl_msg_content_input",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "idl_msg_template_tmp",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "idl_msg_template_dim",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "idl_msg_template_ft",
     now());
-- idl_msg_template_raw_score_tmp +
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "idl_msg_template_raw_score_tmp",
     now());
-- idl_msg_template_score_tmp +
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "idl_msg_template_score_tmp",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "idl_msg_template_info_tmp",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "idl_msg_template_info_dim",
     now());  
-- idl_msg_signature_score_agg +
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "idl_msg_signature_score_agg",
     now());  
-- idl_msg_signature_info_dim +   
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "idl_msg_signature_info_dim",
     now());    
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "idl_msg_received_join_log",
     now());       
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "idl_msg_sender_info_agg",
     now());    
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "idl_msg_receiver_info_agg",
     now());   
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "idl_msg_sender_receiver_relationship_agg",
     now());      