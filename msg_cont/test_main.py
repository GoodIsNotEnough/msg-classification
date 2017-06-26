# coding=utf-8
__author__ = 'kangguosheng'

import os,sys
from list_operate import *
from msg_cont import *
reload(sys)
sys.setdefaultencoding('utf8')
taskfile=os.path.join(os.getcwd(), "taskfile.txt")
runningfile=os.path.join(os.getcwd(), "output.csv")
api='not exist'
running_task(taskfile, runningfile, api)
