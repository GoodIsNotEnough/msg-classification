#!/usr/bin/python
# -+- coding: utf-8 -+-
import os
import xlrd
import xlwt
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

source_file_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "splited_keywords.txt")
source_file_fin=open(source_file_path)
output_file_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "output_source_file")
fout=open(output_file_path,'w')

all_line_msg=[]
for line in source_file_fin:
  line=unicode(line.strip('\n\r'),'utf-8')
  line_id,line_msg=line.split(unicode(',',"utf-8"),1)
  if line_msg in all_line_msg:
    pass
  else:
    all_line_msg.append(line_msg)
    fout.write(line.encode('utf-8')+'\n')

source_file_fin.close()
fout.close()

# input_file_path=os.path.join(os.path.split(os.path.realpath(__file__))[0], "input_excel.xls")
# print input_file_path
# output_file_name="selected_excel.xls"
# select_rows(input_file_path,output_file_name)