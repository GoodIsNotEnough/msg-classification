INSERT INTO datacenter.jobs (
	jdid,
	import_hdfs,
	hadoop_host,
	STATUS,
	created
)
VALUES
	(
		35,
		'/user/hive/warehouse/leesdata.db/adl_msg_industry_phone_ft/ds={p0}/',
		'hdfs://172.31.6.206:8020',
		0,
		NOW()
	);