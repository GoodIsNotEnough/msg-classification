#!/usr/bin/python
# -+- coding: utf-8 -+-
import re,random
import os,sys
import jieba
import string
reload(sys)
sys.setdefaultencoding('utf-8')

r1='【(.*?)】'
r1=re.compile(unicode(r1,'utf8'))
line='【asdf】尊敬的刘忠女士您好！我是婚钻定制中心的管理员，很高兴为您服务，非常荣幸认识两位，有任何钻石方面的疑问，欢迎随时咨询我哟，祝两位生活快乐哟【浪漫密码】'
line=unicode(line,'utf-8')
result=re.search(r1,line)
print "content:",result.group(1) if result is not None else "No Match"
print len(result.group(1))

# 获取当前文件__file__的路径

# 获取当前文件__file__的路径

print "os.path.realpath(__file__)=%s" % os.path.realpath(__file__)
# 获取当前文件__file__的所在目录

print "os.path.dirname(os.path.realpath(__file__))=%s" % os.path.dirname(os.path.realpath(__file__))
# 获取当前文件__file__的所在目录

print "os.path.split(os.path.realpath(__file__))=%s" % os.path.split(os.path.realpath(__file__))[0]

print os.getcwd()
