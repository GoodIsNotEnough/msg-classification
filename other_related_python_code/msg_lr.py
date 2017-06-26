#!/usr/bin/python
# -*- coding: utf-8 -*-
from sklearn import datasets
from sklearn.linear_model import LogisticRegression
import numpy as np
import pandas as pd
from numpy import *

data=pd.read_csv('df_samples.csv')
col_industry=data.iloc[:,1].values
indexes=col_industry!='unknown'
y=col_industry[indexes]
print np.unique(y)

arr=np.loadtxt('U_mxk.txt',delimiter=',')
X=arr[indexes,:]
print len(y),X.shape

lr=LogisticRegression(C=1000.0,random_state=0)
lr.fit(X,y)
print lr.coef_ #输出矩阵:class_num*dimension (6L, 369L)
print lr.intercept_ #输出截距 class_num个元素
coefficients=lr.coef_
intercepts=lr.intercept_

my_fmt=['%.9f']*len(np.unique(y))
print my_fmt
k=369
Sigma=np.load('Sigma.npy') 
print Sigma.shape
Sigk=mat(eye(k)*Sigma[:k])
VT_nxn=np.load('VT.npy')
V_nxk=VT_nxn[:k,:].T #np.shape(V_nxk)
weight_industry=V_nxk*Sigk.I*coefficients.T #n*6
intercepts_industry=intercepts
np.savetxt('weight_industry.txt',weight_industry,fmt=my_fmt,delimiter=',')
np.savetxt('intercepts_industry.txt',intercepts_industry,fmt='%.9f',delimiter=',')


# print  '|'.join(lr.predict([ 1.4,0.2])).encode('utf-8')+'hehe'#输出所属的类别-0
# print  '|'.join(lr.predict([ 4.1,1.3])).encode('utf-8')+'hehe'#输出所属的类别-1
# print  '|'.join(lr.predict([ 5.1,1.8])).encode('utf-8')+'hehe'#输出所属的类别-2
# # print lr.predict([4.1,1.3]) #输出所属的类别-1
# # print lr.predict([5.1,1.8]) #输出所属的类别-2
# print lr.predict_proba([1.4,0.2]) #输出属于每一类的概率sum(lr.predict_proba([1.4,0.2]))=1 
# print lr.predict_proba([4.1,1.3]) #输出属于每一类的概率
# print lr.predict_proba([5.1,1.8]) #输出属于每一类的概率
# # print lr.coef_  #输出矩阵:class_num*dimension
# # print lr.intercept_ #输出截距 class_num个元素
# # print 1/(1+np.exp(-lr.intercept_))

# # 手动计算属于每一类的概率,同print lr.predict_proba([1.4,0.2])一致
# print 1/(1+np.exp(-(np.dot([1.4,0.2],lr.coef_.T)+lr.intercept_)))/sum(1/(1+np.exp(-(np.dot([1.4,0.2],lr.coef_.T)+lr.intercept_))))


# print 1/(1+np.exp(-(np.dot([1.4,0.2],lr.coef_.T)+lr.intercept_)))
# print 1/(1+np.exp(-(np.dot([1.4,0.2],lr.coef_.T[:,0])+lr.intercept_[0])))
# print 1/(1+np.exp(-(np.dot([1.4,0.2],lr.coef_.T[:,1])+lr.intercept_[1])))
# print 1/(1+np.exp(-(np.dot([1.4,0.2],lr.coef_.T[:,2])+lr.intercept_[2])))
# # print 1/(1+np.exp(-(np.dot([1.4,0.2],lr.coef_.T))))/sum(1/(1+np.exp(-(np.dot([1.4,0.2],lr.coef_.T)+lr.intercept_))))
# # print 1/(1+np.exp(-(np.dot([4.1,1.3],lr.coef_.T))))/sum(1/(1+np.exp(-(np.dot([4.1,1.3],lr.coef_.T)+lr.intercept_))))
# # print 1/(1+np.exp(-(np.dot([5.1,1.8],lr.coef_.T))))/sum(1/(1+np.exp(-(np.dot([5.1,1.8],lr.coef_.T)+lr.intercept_))))

# msg_industry=[u'验证码',u'营销',u'消息通知',u'节日问候',u'工资发放',u'物流通知']
# print '|'.join(sorted(msg_industry)).encode('utf-8')
