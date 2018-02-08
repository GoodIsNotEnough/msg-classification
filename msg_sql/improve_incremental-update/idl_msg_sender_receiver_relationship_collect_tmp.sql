ALTER TABLE idl_msg_sender_receiver_relationship_collect_tmp DROP PARTITION (ds<="{p0}");
INSERT INTO idl_msg_sender_receiver_relationship_collect_tmp PARTITION (ds="{p0}")
SELECT
signature,
mobile_no,
collect_set(match_map['call']) call_list,
collect_set(match_map['name']) name_list,
collect_set(match_map['gender']) gender_list,
collect_set(match_map['email']) email_list
FROM idl_msg_received_join_log
WHERE ds="{p0}"
group by signature,mobile_no;