# coding=utf-8
__author__ = 'kangguosheng'

import os,sys
from list_operate import *
from msg_cont import *
reload(sys)
sys.setdefaultencoding('utf8')

print sys.argv

if len(sys.argv) > 1:
    operate_id=int(sys.argv[1])
    operate_id=int(operate_id)
    operate_info=list_operate(operate_id)
else :
    operate_info=[]

print "operate_info %s" % operate_info

if len(operate_info)==3:
    running_task(operate_info[0], operate_info[1], operate_info[2])
