-- 配置task信息
-- adl_sms_content_input
-- idl_received_msg_log
-- split_adl_sms_content_input
-- idl_msg_template_tmp
-- idl_msg_template_dim
-- idl_msg_template_ft
-- idl_template_raw_score_tmp +
-- idl_template_score_tmp +
-- idl_template_tmp
-- idl_template_dim
-- idl_signature_score_agg +
-- idl_signature_dim +
-- idl_received_msg_join_log
-- idl_sender_info_agg
-- idl_receiver_info_agg
-- idl_sender_receiver_relationship_agg

-- adl_sms_content_input
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("adl_sms_content_input",
      "./task_file/msg_daily/adl_sms_content_input.sql",
      now(),
      now(),
      "hive_f",
      "daily",
      "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("adl_sms_content_input",
     "adl_sms_content_input",
     0,
     now());
     
-- odl表默认是有的，不需要配置
-- INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
-- VALUES("adl_sms_content_input",
     -- "odl_sms_log",
     -- now());
     
-- idl_received_msg_log
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_received_msg_log",
      "./task_file/msg_daily/idl_received_msg_log.sql",
      now(),
      now(),
      "hive_f",
      "daily",
      "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_received_msg_log",
     "idl_received_msg_log",
     0,
     now());
-- odl表默认是有的，不需要配置
-- INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
-- VALUES("idl_received_msg_log",
     -- "odl_sms_log",
     -- now());
     
-- split_adl_sms_content_input     
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("split_adl_sms_content_input",
      "./task_file/msg_daily/split_adl_sms_content_input.sh",
      now(),
      now(),
      "shell_f",
      "daily",
      "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("split_adl_sms_content_input",
     "split_adl_sms_content_input",
     0,
     now()); 
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("split_adl_sms_content_input",
     "adl_sms_content_input",
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

-- idl_template_raw_score_tmp +
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_template_raw_score_tmp",
      "./task_file/msg_daily/idl_template_raw_score_tmp.sql",
      now(),
      now(),
      "hive_f",
      "daily",
      "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_template_raw_score_tmp",
     "idl_template_raw_score_tmp",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_template_raw_score_tmp",
     "idl_msg_template_tmp",
     now());  

-- idl_template_score_tmp +
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_template_score_tmp",
      "./task_file/msg_daily/idl_template_score_tmp.sql",
      now(),
      now(),
      "hive_f",
      "daily",
      "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_template_score_tmp",
     "idl_template_score_tmp",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) 
VALUES("idl_template_score_tmp",
     "idl_template_raw_score_tmp",
     now());       

-- idl_template_tmp
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_template_tmp",
      "./task_file/msg_daily/idl_template_tmp.sql",
      now(),
      now(),
      "hive_f",
      "daily",
      "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_template_tmp",
     "idl_template_tmp",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) --修改
VALUES("idl_template_tmp",
     "idl_template_score_tmp",
     now());  

-- idl_template_dim
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_template_dim",
      "./task_file/msg_daily/idl_template_dim.sql",
      now(),
      now(),
      "hive_f",
      "daily",
      "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_template_dim",
     "idl_template_dim",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_template_dim",
     "idl_template_tmp",
     now());  

-- idl_signature_score_agg +
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_signature_score_agg",
      "./task_file/msg_daily/idl_signature_score_agg.sql",
      now(),
      now(),
      "hive_f",
      "daily",
      "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_signature_score_agg",
     "idl_signature_score_agg",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_signature_score_agg",
     "idl_template_dim",
     now());  

-- idl_signature_dim +
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_signature_dim",
      "./task_file/msg_daily/idl_signature_dim.sql",
      now(),
      now(),
      "hive_f",
      "daily",
      "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_signature_dim",
     "idl_signature_dim",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_signature_dim",
     "idl_signature_score_agg",
     now());  
  
-- idl_received_msg_join_log
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_received_msg_join_log",
      "./task_file/msg_daily/idl_received_msg_join_log.sql",
      now(),
      now(),
      "hive_f",
      "daily",
      "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_received_msg_join_log",
     "idl_received_msg_join_log",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_received_msg_join_log",
     "idl_msg_template_dim",
     now());  
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_received_msg_join_log",
     "idl_template_dim",
     now());  
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_received_msg_join_log",
     "idl_signature_dim",
     now());  
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_received_msg_join_log",
     "idl_received_msg_log",
     now());  
     
-- idl_sender_info_agg
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_sender_info_agg",
      "./task_file/msg_daily/idl_sender_info_agg.sql",
      now(),
      now(),
      "hive_f",
      "daily",
      "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_sender_info_agg",
     "idl_sender_info_agg",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_sender_info_agg",
     "idl_received_msg_join_log",
     now());  

-- idl_receiver_info_agg
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_receiver_info_agg",
      "./task_file/msg_daily/idl_receiver_info_agg.sql",
      now(),
      now(),
      "hive_f",
      "daily",
      "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_receiver_info_agg",
     "idl_receiver_info_agg",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_receiver_info_agg",
     "idl_received_msg_join_log",
     now());  

-- idl_sender_receiver_relationship_agg
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_sender_receiver_relationship_agg",
      "./task_file/msg_daily/idl_sender_receiver_relationship_agg.sql",
      now(),
      now(),
      "hive_f",
      "daily",
      "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_sender_receiver_relationship_agg",
     "idl_sender_receiver_relationship_agg",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_sender_receiver_relationship_agg",
     "idl_received_msg_join_log",
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
     "adl_sms_content_input",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
     "idl_received_msg_log",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
     "split_adl_sms_content_input",
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
-- idl_template_raw_score_tmp +
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
     "idl_template_raw_score_tmp",
     now());
-- idl_template_score_tmp +
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
     "idl_template_score_tmp",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
     "idl_template_tmp",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
     "idl_template_dim",
     now());  
-- idl_signature_score_agg +
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
     "idl_signature_score_agg",
     now());  
-- idl_signature_dim +   
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
     "idl_signature_dim",
     now());    
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
     "idl_received_msg_join_log",
     now());       
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
     "idl_sender_info_agg",
     now());    
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
     "idl_receiver_info_agg",
     now());   
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
     "idl_sender_receiver_relationship_agg",
     now());      