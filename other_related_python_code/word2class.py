#!/usr/bin/python
# -+- coding: utf-8 -+-
import re,os
import sys,math
import string
reload(sys)
sys.setdefaultencoding('utf-8')

result_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "ordered_signature2class.txt")
try:
    result_fin=open(result_path) #打开文件
except Exception as e:
    print 'string: [something went wrong when opening file] message:[%s]' % (e)

sig_words_path=os.path.join(os.path.split(os.path.realpath(__file__))[0], "sig_words.txt")
sig_words_fin=open(sig_words_path)

output_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "word2class.txt")
output_fout=open(output_path,'w')

sig_words=[]
for line in sig_words_fin:
  line=unicode(line.strip('\n\r'),'utf-8')
  if len(line)==1:
    sig_words.append(line)
  else:
    print "there may be something wrong with sig_words.txt!!!"

for line in result_fin:
  words=[]
  line=unicode(line,'utf-8')
  class_no,line=line.split(unicode(',','utf-8'),1)
  for word in sig_words:
    if word in line:
      words.append(word)
  output_fout.write(class_no+','+'|'.join(words).encode('utf-8')+'\n')

result_fin.close()
output_fout.close()
print "finished!!!!"