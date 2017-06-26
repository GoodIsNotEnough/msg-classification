#!/usr/bin/python
#coding:utf8

import sys,MySQLdb
reload(sys)
sys.setdefaultencoding('utf-8')

main_base = {
    'host':'172.31.6.180',
    'username': 'dc',
    'password': 'mCdlUmm3thna5ttup',
    'database': 'data_tool'
}

def list_operate(operate_id):
    host = main_base["host"]
    user = main_base["username"]
    passwd = main_base["password"]
    db = main_base["database"]
    try:
        conn = MySQLdb.connect(host=host, user=user, passwd=passwd, db=db, port=3306,charset='utf8')
        cur = conn.cursor()
        print "conn_database for %s" % str(operate_id)
    except Exception as e:
        print "conn_database for %s info: %s" % (str(operate_id),e)
    sql_code="SELECT task_file,running_file,apl_url FROM running_operate_log WHERE operate_id = %s;"
    try:
        cur.execute(sql_code,(operate_id,))
        operate_info=cur.fetchone()
        if operate_info:
            print "list operate for %s" % str(operate_id)
            operate_info=list(operate_info)
        else:
            print "list operate error for %s" % str(operate_id)
            operate_info=[]
    except Exception as e:
        print "list operate for %s info %s" % (str(operate_id),e)
        operate_info = []

    return operate_info
