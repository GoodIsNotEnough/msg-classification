#!/usr/bin/python
# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
import os,sys
from pandas import Series,DataFrame
import datetime
reload(sys)
sys.setdefaultencoding('utf-8')
starttime = datetime.datetime.now()    
######################################################        
type_industry_labels_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "type_industry_labels.txt")
fin=open(type_industry_labels_path)

row_num=86619 #1-102158
default_columns=[u'类型',u'行业'] #
col_num=len(default_columns)
df=DataFrame(np.zeros((row_num,col_num)),columns=default_columns)

for row,line in enumerate(fin): #row：0,1,2,3,...
  # print "line %d is processing, %s has beed used. Please wait ..." % (row,(datetime.datetime.now() - starttime))
  line=unicode(line.strip('\n\r'),'utf-8')
  id_no,msg_type,msg_industry,words_keywords=line.split(unicode(',','utf-8'),3)
  words_keywords_list=words_keywords.split(unicode('|','utf-8'))
  df.ix[row,u'类型']=msg_type
  df.ix[row,u'行业']=msg_industry
  for element in words_keywords_list:
    df.ix[row,element]=1 #自动添加列

df.fillna(0,inplace=True) #默认不为NAN,而是为0

columns_path=os.path.join(os.path.split(os.path.realpath(__file__))[0], "all_columns.txt")
columns_fout=open(columns_path,'w')
for column_name in df.columns: #将列名写到文件
    columns_fout.write(column_name+'\n')
columns_fout.close()

matrix_file_path=type_industry_labels_path=os.path.join(os.path.split(os.path.realpath(__file__))[0], "all_matrix_file.csv")
df.to_csv(matrix_file_path,index=False) #将表格写到文件
fin.close()
print df.columns
print df.shape #输出表格的行列数

#####################################################
endtime = datetime.datetime.now()
print (endtime - starttime),"time used!!!" #0:00:00.280797