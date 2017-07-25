ALTER TABLE adl_msg_phone_ft DROP if exists partition (ds='{p0}');
INSERT INTO adl_msg_phone_ft partition (ds='{p0}')
select 
'{p0}' as data_date,
count(uid) as phone_num,
sum(case when updatedt='{p0}'  then 1 else 0 end) as updated_phone_num,
sum(case when insertdt='{p0}'  then 1 else 0 end) as added_phone_num
FROM idl_sms_active_moblie_agg
WHERE ds='{p0}';
