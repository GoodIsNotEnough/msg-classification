#!/usr/bin/python
# -+- coding: utf-8 -+-
import re,os
from find_items import *
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

fin_path=r'F:\MSG\one_case.txt' #待处理的文件路径：
conf_file_path=r'F:\MSG\conf_re.txt' #正则表达式配置文件路径

conf_dict=dict()
ranked_fields=[]
with open(conf_file_path, "r") as f:
    for line in f.readlines():
        try:
            line=unicode(line.strip("\n"), "utf-8")
            key,val= line.split(":",1)
            if key not in conf_dict:
                conf_dict[key]=[val]
                ranked_fields.append(key)
            else:
                conf_dict[key].append(val)
        except Exception as e:
            print 'string: [%s] message:[%s]' % (line, e)
            continue

# print len(conf_dict)
# for key,val in conf_dict.items():
#     print key.decode('utf-8')

fin=open(fin_path) #打开文件
for line in fin: 
    line=unicode(line,'utf-8') 
    d=dict()
    for key,val in conf_dict.items(): 
        for str in val:
            regular_expression=re.compile(str)
            item=re.search(regular_expression,line)
            if item is not None: 
                d[key]=item.group(1)
                print "[matched_re]",;print key+':'+str,;print item.group(1)
                break
                
    print line,
    # tuple_list=sorted(d.iteritems(), key=lambda d:d[0], reverse = True ) 
    for key in ranked_fields:
        if key in d and key!='signature': #签名不替换
            val=d[key]
            split_char=unicode("】",'utf-8')
            if split_char in line:
                head,tail= line.split(split_char,1)
                tail=tail.replace(val,'{'+key+'}',1)
                line=head+split_char+tail
            else:
                line=line.replace(val,'{'+key+'}',1)
    print line