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
fout_path=r'F:\MSG\selected.txt' #输出文件路径
fout=open(fout_path,'w') 

sample_list=range(1,2475587)
seleted_list=random.sample(sample_list, 500000)
print len(set(seleted_list))
# print seleted_list

fin=open(fin_path)
id_no=0
for line in fin:
  id_no+=1
  if id_no in seleted_list:
    fout.write(line)

fout.close()
fin.close()

print "DONE!!"
