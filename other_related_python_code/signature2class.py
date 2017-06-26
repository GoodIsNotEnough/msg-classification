#!/usr/bin/python
# -+- coding: utf-8 -+-
import re,os
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

result_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "result")
try:
    result_fin=open(result_path) #打开文件
except Exception as e:
    print 'string: [something went wrong when opening file] message:[%s]' % (e)

d=dict() #{class_no:[id,...],}
for line in result_fin:
  line=unicode(line,'utf-8')
  split_char=unicode('\t','utf-8') #眼见不见得为实
  line_list=line.split(split_char)
  undis=unicode('undis','utf-8')
  if line_list[0]==undis:
    continue
  key=line_list[0]; value=line_list[1]
  if key not in d:
    d[key]=[value]
  else:
    d[key].append(value)
result_fin.close()

msg_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "280000_templates.txt")
msg_fin=open(msg_path)
r1='【(.+?)】'
r1=re.compile(unicode(r1,'utf8'))
class_dict=dict()
line_no=0
for line in msg_fin:
  line_no+=1
  line_id=unicode(str(line_no),'utf-8')
  line=unicode(line,'utf-8')
  flag=0
  for k in d:
    if line_id in d[k]:
      key=k;flag=1 #找到所在的类别
      break
  if flag==1:
    match_result=re.search(r1,line)
    signature=match_result.group(1) if match_result is not None else "No Match"
    if key not in class_dict:
      class_dict[key]=set()
      class_dict[key].add(signature)
    else:
      class_dict[key].add(signature)
      
msg_fin.close()

output_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "signature2class.txt")
print output_path
outfile = open(output_path, 'w')
for k in range(len(class_dict)):
  key=unicode(str(k),'utf-8')
  class_no=key.encode('utf-8')
  # join_char=unicode("|",'utf-8')
  # signatures=join_char.join(list(class_dict[k])).encode('utf-8')
  for signature in class_dict[key]:
    signature=signature.encode('utf-8')
    outfile.write(class_no+"\t"+signature+'\n')
  
outfile.close()

print "finished!!!!"