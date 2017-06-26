#!/usr/bin/python
# -+- coding: utf-8 -+-
import re,os
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

result_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "test_keywords.sql")
try:
    fin=open(result_path) #打开文件
except Exception as e:
    print 'string: [something went wrong when opening file] message:[%s]' % (e)

output_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "output_data")
print output_path
outfile = open(output_path, 'w')
for line in fin:
  line=line.strip('\n\r')
  line=line.encode('utf-8')
  line='('+line+'):'+line
  line=line.encode('utf-8')
  outfile.write(line+'\n')
outfile.close()

print "finished!!!!"