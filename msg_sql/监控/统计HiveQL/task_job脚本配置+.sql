-- adl_msg_sms_phone_ft
-- adl_msg_sms_ft
-- adl_msg_phone_ft
-- adl_msg_type_sms_ft
-- adl_msg_type_phone_ft
-- adl_msg_industry_sms_ft
-- adl_msg_industry_phone_ft

-- adl_msg_sms_phone_ft
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("adl_msg_sms_phone_ft",
     "./task_file/msg_daily/adl_msg_sms_phone_ft.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("adl_msg_sms_phone_ft",
    "adl_msg_sms_phone_ft",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) 
VALUES("adl_msg_sms_phone_ft",
    "idl_msg_received_join_log",
     now());     
     
-- adl_msg_sms_ft
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("adl_msg_sms_ft",
     "./task_file/msg_daily/adl_msg_sms_ft.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("adl_msg_sms_ft",
    "adl_msg_sms_ft",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) 
VALUES("adl_msg_sms_ft",
    "idl_msg_received_join_log",
     now());   
     
-- adl_msg_phone_ft
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("adl_msg_phone_ft",
     "./task_file/msg_daily/adl_msg_phone_ft.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("adl_msg_phone_ft",
    "adl_msg_phone_ft",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) 
VALUES("adl_msg_phone_ft",
    "idl_sms_active_moblie_agg",
     now()); 
     
-- adl_msg_type_sms_ft
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("adl_msg_type_sms_ft",
     "./task_file/msg_daily/adl_msg_type_sms_ft.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("adl_msg_type_sms_ft",
    "adl_msg_type_sms_ft",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) 
VALUES("adl_msg_type_sms_ft",
    "idl_msg_received_join_log",
     now());  
     
-- adl_msg_type_phone_ft
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("adl_msg_type_phone_ft",
     "./task_file/msg_daily/adl_msg_type_phone_ft.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("adl_msg_type_phone_ft",
    "adl_msg_type_phone_ft",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) 
VALUES("adl_msg_type_phone_ft",
    "idl_msg_received_join_log",
     now());  
     
-- adl_msg_industry_sms_ft
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("adl_msg_industry_sms_ft",
     "./task_file/msg_daily/adl_msg_industry_sms_ft.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("adl_msg_industry_sms_ft",
    "adl_msg_industry_sms_ft",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) 
VALUES("adl_msg_industry_sms_ft",
    "idl_msg_received_join_log",
     now());  
     
-- adl_msg_industry_phone_ft
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("adl_msg_industry_phone_ft",
     "./task_file/msg_daily/adl_msg_industry_phone_ft.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("adl_msg_industry_phone_ft",
    "adl_msg_industry_phone_ft",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) 
VALUES("adl_msg_industry_phone_ft",
    "idl_msg_received_join_log",
     now());  
-- --------------------------------------
-- adl_msg_sms_phone_ft
-- adl_msg_sms_ft
-- adl_msg_phone_ft
-- adl_msg_type_sms_ft
-- adl_msg_type_phone_ft
-- adl_msg_industry_sms_ft
-- adl_msg_industry_phone_ft
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "adl_msg_sms_phone_ft",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "adl_msg_sms_ft",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "adl_msg_phone_ft",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "adl_msg_type_sms_ft",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "adl_msg_type_phone_ft",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "adl_msg_industry_sms_ft",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "adl_msg_industry_phone_ft",
     now());

     
 