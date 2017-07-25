CREATE PROCEDURE `proc_adl_msg_industry_phone_ft`(IN `curdate` date)
BEGIN

		INSERT INTO email_service.config_email_info (conf_id,email_content,send_status,send_num,create_date,update_date)
		SELECT 25 AS conf_id, 
		 group_concat(CONCAT_WS('__&__', info.data_date,info.msg_industry,info.phone_num) SEPARATOR "__$__") AS email_content, 
		 0 AS send_status, 
		 0 AS send_num,
		 now() AS create_date,
		 now() AS update_date
		FROM
		  (SELECT data_date,
		          msg_industry,
		          FORMAT(ifnull(phone_num,0),0) AS phone_num
		   FROM adl_msg_industry_phone_ft
		   WHERE data_date = curdate
		   ORDER BY data_date DESC) info;

END;

CREATE PROCEDURE `proc_adl_msg_sms_ft`(IN `curdate` date)
BEGIN

		INSERT INTO email_service.config_email_info (conf_id,email_content,send_status,send_num,create_date,update_date)
		SELECT 26 AS conf_id, 
		 group_concat(CONCAT_WS('__&__', info.data_date,info.msg_num) SEPARATOR "__$__") AS email_content, 
		 0 AS send_status, 
		 0 AS send_num,
		 now() AS create_date,
		 now() AS update_date
		FROM
		  (SELECT data_date,
		          FORMAT(ifnull(msg_num,0),0) AS msg_num
		   FROM adl_msg_sms_ft
		   WHERE data_date BETWEEN DATE_ADD(curdate,INTERVAL -7 DAY) AND curdate
		   ORDER BY data_date DESC) info;

END;

CREATE PROCEDURE `proc_adl_msg_phone_ft`(IN `curdate` date)
BEGIN

		INSERT INTO email_service.config_email_info (conf_id,email_content,send_status,send_num,create_date,update_date)
		SELECT 27 AS conf_id, 
		 group_concat(CONCAT_WS('__&__', info.data_date,info.phone_num,info.updated_phone_num,info.added_phone_num) SEPARATOR "__$__") AS email_content, 
		 0 AS send_status, 
		 0 AS send_num,
		 now() AS create_date,
		 now() AS update_date
		FROM
		  (SELECT data_date,
		          FORMAT(ifnull(phone_num,0),0) AS phone_num,
				  FORMAT(ifnull(updated_phone_num,0),0) AS updated_phone_num,
				  FORMAT(ifnull(added_phone_num,0),0) AS added_phone_num
		   FROM adl_msg_phone_ft
		   WHERE data_date BETWEEN DATE_ADD(curdate,INTERVAL -7 DAY) AND curdate
		   ORDER BY data_date DESC) info;

END;

CREATE PROCEDURE `proc_adl_msg_type_sms_ft`(IN `curdate` date)
BEGIN

		INSERT INTO email_service.config_email_info (conf_id,email_content,send_status,send_num,create_date,update_date)
		SELECT 28 AS conf_id, 
		 group_concat(CONCAT_WS('__&__', info.data_date,info.msg_type,info.msg_num) SEPARATOR "__$__") AS email_content, 
		 0 AS send_status, 
		 0 AS send_num,
		 now() AS create_date,
		 now() AS update_date
		FROM
		  (SELECT data_date,
		          msg_type,
				  FORMAT(ifnull(msg_num,0),0) AS msg_num
		   FROM adl_msg_type_sms_ft
		   WHERE data_date = curdate
		   ORDER BY data_date DESC) info;

END;

CREATE PROCEDURE `proc_adl_msg_type_phone_ft`(IN `curdate` date)
BEGIN

		INSERT INTO email_service.config_email_info (conf_id,email_content,send_status,send_num,create_date,update_date)
		SELECT 29 AS conf_id, 
		 group_concat(CONCAT_WS('__&__', info.data_date,info.msg_type,info.phone_num) SEPARATOR "__$__") AS email_content, 
		 0 AS send_status, 
		 0 AS send_num,
		 now() AS create_date,
		 now() AS update_date
		FROM
		  (SELECT data_date,
		          msg_type,
				  FORMAT(ifnull(phone_num,0),0) AS phone_num
		   FROM adl_msg_type_phone_ft
		   WHERE data_date = curdate
		   ORDER BY data_date DESC) info;

END;

CREATE PROCEDURE `proc_adl_msg_industry_sms_ft`(IN `curdate` date)
BEGIN

		INSERT INTO email_service.config_email_info (conf_id,email_content,send_status,send_num,create_date,update_date)
		SELECT 30 AS conf_id, 
		 group_concat(CONCAT_WS('__&__', info.data_date,info.msg_industry,info.msg_num) SEPARATOR "__$__") AS email_content, 
		 0 AS send_status, 
		 0 AS send_num,
		 now() AS create_date,
		 now() AS update_date
		FROM
		  (SELECT data_date,
		          msg_industry,
				  FORMAT(ifnull(msg_num,0),0) AS msg_num
		   FROM adl_msg_industry_sms_ft
		   WHERE data_date = curdate
		   ORDER BY data_date DESC) info;

END;

CREATE PROCEDURE `proc_adl_msg_sms_phone_ft`(IN `curdate` date)
BEGIN

		INSERT INTO email_service.config_email_info (conf_id,email_content,send_status,send_num,create_date,update_date)
		SELECT 31 AS conf_id, 
		 group_concat(CONCAT_WS('__&__', info.data_date,info.msg_num,nfo.phone_num) SEPARATOR "__$__") AS email_content, 
		 0 AS send_status, 
		 0 AS send_num,
		 now() AS create_date,
		 now() AS update_date
		FROM
		  (SELECT data_date,
				  FORMAT(ifnull(msg_num,0),0) AS msg_num,
				  FORMAT(ifnull(phone_num,0),0) AS phone_num
		   FROM adl_msg_sms_phone_ft
		   WHERE data_date BETWEEN DATE_ADD(curdate,INTERVAL -7 DAY) AND curdate
		   ORDER BY data_date DESC) info;

END;
