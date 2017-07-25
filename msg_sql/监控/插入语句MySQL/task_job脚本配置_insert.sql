-- adl_msg_sms_phone_ft_output
-- adl_msg_sms_ft_output
-- adl_msg_phone_ft_output
-- adl_msg_type_sms_ft_output
-- adl_msg_type_phone_ft_output
-- adl_msg_industry_sms_ft_output
-- adl_msg_industry_phone_ft_output

-- adl_msg_sms_phone_ft_output
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("adl_msg_sms_phone_ft_output",
     "./task_file/msg_daily/adl_msg_sms_phone_ft_output.sql",
      now(),
      now(),
     "adl_report",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("adl_msg_sms_phone_ft_output",
    "adl_msg_sms_phone_ft_output",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) 
VALUES("adl_msg_sms_phone_ft_output",
    "adl_msg_sms_phone_ft",
     now());     
     
-- adl_msg_sms_ft_output
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("adl_msg_sms_ft_output",
     "./task_file/msg_daily/adl_msg_sms_ft_output.sql",
      now(),
      now(),
     "adl_report",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("adl_msg_sms_ft_output",
    "adl_msg_sms_ft_output",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) 
VALUES("adl_msg_sms_ft_output",
    "adl_msg_sms_ft",
     now());   
     
-- adl_msg_phone_ft_output
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("adl_msg_phone_ft_output",
     "./task_file/msg_daily/adl_msg_phone_ft_output.sql",
      now(),
      now(),
     "adl_report",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("adl_msg_phone_ft_output",
    "adl_msg_phone_ft_output",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) 
VALUES("adl_msg_phone_ft_output",
    "adl_msg_phone_ft",
     now()); 
     
-- adl_msg_type_sms_ft_output
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("adl_msg_type_sms_ft_output",
     "./task_file/msg_daily/adl_msg_type_sms_ft_output.sql",
      now(),
      now(),
     "adl_report",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("adl_msg_type_sms_ft_output",
    "adl_msg_type_sms_ft_output",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) 
VALUES("adl_msg_type_sms_ft_output",
    "adl_msg_type_sms_ft",
     now());  
     
-- adl_msg_type_phone_ft_output
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("adl_msg_type_phone_ft_output",
     "./task_file/msg_daily/adl_msg_type_phone_ft_output.sql",
      now(),
      now(),
     "adl_report",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("adl_msg_type_phone_ft_output",
    "adl_msg_type_phone_ft_output",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) 
VALUES("adl_msg_type_phone_ft_output",
    "adl_msg_type_phone_ft",
     now());  
     
-- adl_msg_industry_sms_ft_output
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("adl_msg_industry_sms_ft_output",
     "./task_file/msg_daily/adl_msg_industry_sms_ft_output.sql",
      now(),
      now(),
     "adl_report",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("adl_msg_industry_sms_ft_output",
    "adl_msg_industry_sms_ft_output",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) 
VALUES("adl_msg_industry_sms_ft_output",
    "adl_msg_industry_sms_ft",
     now());  
     
-- adl_msg_industry_phone_ft_output
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("adl_msg_industry_phone_ft_output",
     "./task_file/msg_daily/adl_msg_industry_phone_ft_output.sql",
      now(),
      now(),
     "adl_report",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("adl_msg_industry_phone_ft_output",
    "adl_msg_industry_phone_ft_output",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt) 
VALUES("adl_msg_industry_phone_ft_output",
    "adl_msg_industry_phone_ft",
     now());  
-- --------------------------------------
-- adl_msg_sms_phone_ft_output
-- adl_msg_sms_ft_output
-- adl_msg_phone_ft_output
-- adl_msg_type_sms_ft_output
-- adl_msg_type_phone_ft_output
-- adl_msg_industry_sms_ft_output
-- adl_msg_industry_phone_ft_output
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "adl_msg_sms_phone_ft_output",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "adl_msg_sms_ft_output",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "adl_msg_phone_ft_output",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "adl_msg_type_sms_ft_output",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "adl_msg_type_phone_ft_output",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "adl_msg_industry_sms_ft_output",
     now());
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("msg_daily",
    "adl_msg_industry_phone_ft_output",
     now());

     
 