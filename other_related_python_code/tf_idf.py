#!/usr/bin/python
# -+- coding: utf-8 -+-
import re,os
import sys,math
import string
reload(sys)
sys.setdefaultencoding('utf-8')
'''
TF:在某类签名中的重要程度
IDF:对应所有签名而言的独特性,若是计算在所有类中的独特性,可能就没有区分度了
(因为字可能都在大多数类中均出现，这样计算的IDF数值都差不多大)
'''
result_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "ordered_signature2class.txt")
try:
    result_fin=open(result_path) #打开文件
except Exception as e:
    print 'string: [something went wrong when opening file] message:[%s]' % (e)

removed_chars=string.lowercase+string.uppercase+string.digits+string.punctuation
removed_chars=unicode(removed_chars,'utf-8')

word_set=set()
d=dict() #class_no:[**,**,...]
all_signatures=[] #所有签名列表
for line in result_fin:
  line=unicode(line,'utf-8')
  class_no,line=line.split(unicode(',','utf-8'),1)
  signatures=line.split(unicode('|','utf-8'))
  all_signatures.extend(signatures) #
  if class_no not in d:
    d[class_no]=signatures #该类包含的签名
  for word in line:
    if word not in removed_chars:
      word_set.add(word) #所有的字

result_fin.close()
print 'there are %s words in signatures!!!' % len(word_set)
all_signatures=set(all_signatures) #去重

word2idf=dict() #计算每个字的IDF
for word in word_set:
  occurence=0
  for e in all_signatures:
    if word in e:
      occurence+=1
  word2idf[word]=math.log(len(all_signatures)*1.00/(occurence+1))

output_tfidf = os.path.join(os.path.split(os.path.realpath(__file__))[0], "tfidf_result.txt")
fout = open(output_tfidf, 'w')

for i in range(26):
  key=unicode(str(i),'utf-8')
  tfidf_dict=dict()
  length=len(d[key])#类别i中签名的个数
  for word in word_set: #循环每个字
    frequency=0
    for e in d[key]: #循环每个签名
      if word in e:
        frequency+=1
    if frequency>=1:
      tf=float(frequency)/float(length)
      tf_idf=tf*word2idf[word]
      tfidf_dict[word]=tf_idf
  result_dict=sorted(tfidf_dict.iteritems(), key=lambda d:d[1], reverse = True ) #d[0]为key,d[1]为value,返回一个元组列表
  for j in range(50):
    word,tfidf=result_dict[j]
    output_line=key+'\t'+word+'\t'+str(tfidf).encode('utf-8')
    fout.write(output_line+'\n')

fout.close()
print "finished!!!!"