BEGIN

    INSERT INTO email_service.config_email_info (conf_id,email_content,send_status,send_num,create_date,update_date)
    SELECT 19 AS conf_id, # 邮件内容字符串拼接，以__&__作为一条数据不同字段的分隔符，以__$__作为不同数据之间的分隔符
     group_concat(CONCAT_WS('__&__', info.data_date, info.email_num, info.mobile_num) SEPARATOR "__$__") AS email_content, # 邮件发送状态
     0 AS send_status, # 邮件发送次数
     0 AS send_num,
     now() AS create_date,
     now() AS update_date
    FROM
      (SELECT cast(data_date AS char(20)) AS data_date,
              FORMAT(ifnull(email_num,0),0) AS email_num,
              FORMAT(ifnull(mobile_num,0),0) AS mobile_num
        FROM adl_email_summ_ft
        WHERE data_date BETWEEN DATE_ADD(curdate,INTERVAL -7 DAY) AND curdate
        ORDER BY data_date DESC
      ) info;

END
