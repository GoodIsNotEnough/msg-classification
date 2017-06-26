#!/usr/bin/python
# -+- coding: utf-8 -+-
import re,os
import xlrd
import xlwt
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

def read_label_file(label_file_path):
  d=dict()
  with open(label_file_path, "r") as f:
    for line in f.readlines():
      try:
        line=unicode(line.strip("\n\r"), "utf-8")
        key,val= line.split(unicode('：','utf-8'),1)
        if key not in d:
          d[key]=[val]
        else:
          d[key].append(val)
      except Exception as e:
        print "There may be something wrong with %s!!!" % label_file_path
        print 'string: [%s] message:[%s]' % (line, e)
  return d

def find_type(conf_dict,words_keywords_list):
  #注意：line为unicode编码
  #匹配正则
  find_type=""
  for keyword in words_keywords_list:
    for key in conf_dict:
      if keyword in conf_dict[key]:
        find_type=key;break
  return find_type


result_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "result")
result_fin=open(result_path) #打开文件
class_ids=dict() #{class_no:[id,...],} 每个类有哪些id
for line in result_fin:
  line=unicode(line,'utf-8')
  split_char=unicode('\t','utf-8') #眼见不见得为实
  line_list=line.split(split_char)
  undis=unicode('undis','utf-8')
  if line_list[0]==undis:
    continue
  key=line_list[0]; value=line_list[1]
  if key not in class_ids:
    class_ids[key]=[value]
  else:
    class_ids[key].append(value)
result_fin.close()

qualitative_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "qualitative.xlsx")
data = xlrd.open_workbook(qualitative_path) 
table = data.sheets()[0]
nrows = table.nrows # 50
ncols = table.ncols # 3
class_info=dict() #{class_no:(type,industry)}
for i in range(nrows):
  i_row=table.row_values(i) # 获取第i行 
  i_row[0]=int(i_row[0]) # float to int
  for index,cell in enumerate(i_row):
    if type(cell).__name__!="unicode":
      i_row[index]=unicode(str(cell),"utf-8")
  class_info[i_row[0]]=(i_row[1],i_row[2]) #定性的标签

type_industry_labels_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "type_industry_labels.txt")
fout = open(type_industry_labels_path  , 'w')

add_type_label_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "add_type_label.txt")
type_dict=read_label_file(add_type_label_path)
add_industry_label_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "add_industry_label.txt")
industry_dict=read_label_file(add_industry_label_path)

source_file_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "source_file")
source_file_fin=open(source_file_path)

for line in source_file_fin:
  line=unicode(line.strip('\n\r'),'utf-8')
  id_no,words_keywords=line.split(unicode(',','utf-8'),1)
  class_exist=0
  for key in class_ids:
    if id_no in class_ids[key]: #判断是否存在分类
      class_no=key;class_exist=1 # 找到类别
      break
  if class_exist: 
    msg_type=class_info[class_no][0]
    msg_industry=class_info[class_no][1]
  else:
    msg_type=u'unknown'
    msg_industry=u'unknown'
  words_keywords_list=words_keywords.split(unicode('|','utf-8')) #分词
  find_msg_type=find_type(type_dict,words_keywords_list) #依据传入的字典,匹配类型
  if find_msg_type!="": #匹配到，不为空
    msg_type=find_msg_type #更新msg_type
  find_msg_industry=find_type(industry_dict,words_keywords_list) #依据传入的字典,匹配行业
  if find_msg_industry!="":
    msg_industry=find_msg_industry
  new_line=unicode(',','utf-8').join([id_no,msg_type,msg_industry,words_keywords])
  if msg_type!=u'unknown' or msg_industry!=u'unknown':
    fout.write(new_line.encode('utf-8')+'\n')

source_file_fin.close()
fout.close()
print "finished!!!!"