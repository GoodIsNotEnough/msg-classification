#!/usr/bin/user_gender
#-*-coding:utf-8-*-
import numpy as np
import pandas as pd
import pprint,random
import pickle
from sklearn import preprocessing
import datetime
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

# data=pd.read_csv('all_matrix_file.csv')
# print data.shape #(86619, 1031)
# row_num,col_num=data.shape
# sample_num=50000
# sample_list=range(row_num)
# indexes=sorted(random.sample(sample_list, sample_num)) #升序排列
# print len(indexes)
# df_sample=data.ix[indexes]
# print df_sample.shape #(50000, 1031)
# svd_samples=df_sample.ix[:,2:]
# svd_samples.to_csv('svd_samples.csv',index=False)
# df_sample.to_csv('df_samples.csv',index=False)
# print "finished!!!"

data=pd.read_csv('svd_samples.csv')
print data.shape
print data.columns
