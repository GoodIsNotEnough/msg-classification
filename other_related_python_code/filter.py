#!/usr/bin/python
# -+- coding: utf-8 -+-
import re
from find_items import *
import sys
reload(sys)
sys.setdefaultencoding('utf-8')
#将包含有特定关键词的行保留下来，存储到文件
# fin_path=r'F:\MSG\data_2017-04-19_950174.csv' #输入文件路径
fin_path=r'F:\MSG\data_2017_04_26_30_800000.csv' #输入文件路径
fin=open(fin_path)
fout_path=r'F:\MSG\filter_text.txt' #输出文件路径
fout=open(fout_path,'w') 
# select=['运单','快递','运单','快速','速递']
# select=['先生','女士','小姐','陛下','娘子']
#select=['工资','绩效'] #自定义关键字列表
# select=['天天','快捷'] 
select=['航班'] 
for line in fin:
  for keyword in select:
    if keyword in line: #判断是否为子串
      fout.write(line)
      break
fout.close()
fin.close()
print "DONE!!"
