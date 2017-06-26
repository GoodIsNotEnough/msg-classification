#!/usr/bin/python
# -*- coding: utf-8 -*-
from sklearn import datasets
from sklearn.linear_model import LogisticRegression
import numpy as np
import pandas as pd
from numpy import *
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

categories=[u'验证码',u'营销',u'消息通知',u'节日问候',u'工资发放',u'物流通知']
# categories=[u'物流快递',u'车险保单',u'生活服务',u'汽车服务',u'淘宝商家',u'旅行',u'淘宝售后',u'会务活动',u'互联网金融',u'APP应用',u'教育',u'医疗',u'公共服务']
weight=np.loadtxt('weight_type.txt',delimiter=',')
row_num,col_num=weight.shape

fin=open('all_columns.txt')
keywords=[]
for e in fin:
  keyword=unicode(e.strip('\n\r'),'utf-8')
  keywords.append(keyword)
fin.close()

print weight.shape,len(keywords)

fout=open('config_msg_weight_parameter.txt','w')
for j in range(col_num):
  category=categories[j]
  for i in range(row_num):
    keyword=keywords[i]
    weight_value=str(weight[i,j])
    line=','.join([keyword,u'类型',category,weight_value]).encode('utf-8')
    fout.write(line+'\n')
fout.close()