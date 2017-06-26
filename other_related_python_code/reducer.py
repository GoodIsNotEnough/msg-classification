#!/usr/bin/python
# -+- coding: utf-8 -+-
import re,random
from find_items import *
import sys
reload(sys)
sys.setdefaultencoding('utf-8')
#对文件中的每个签名，保留save_num条随机的记录

fin_path=r'F:\MSG\templates.csv' #输入文件路径
fin=open(fin_path)
fout_path=r'F:\MSG\reducer.txt' #输出文件路径
fout=open(fout_path,'w') 

regular_expression=re.compile(ur'【(.+?)】') #匹配签名的正则表示
save_num=50 #保留的行数

stat_d=dict() #统计各签名的短信条数
for line in fin:
  line=unicode(line,'utf-8')
  signature=re.search(regular_expression,line) #若不存在匹配，则返回None
  if signature is not None:
    key=signature.group(1)
    stat_d[key]=stat_d.get(key,0)+1    
fin.close()

ran_d=dict() #随机数字典
for key,val in stat_d.items():
  sample_list=range(1,val+1)
  select_num=min([save_num,val])
  ran_d[key]=random.sample(sample_list, select_num)

fin=open(fin_path)
d=dict()
for line in fin:
  line=unicode(line,'utf-8')
  signature=re.search(regular_expression,line) #若不存在匹配，则返回None
  if signature is not None:
    key=signature.group(1)
    d[key]=d.get(key,0)+1    
    if d[key] in ran_d[key]:
      fout.write(line)

fout.close()
fin.close()

print "签名的数量:",len(d) #2204
print "DONE!!"
