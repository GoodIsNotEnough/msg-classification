#!/usr/bin/python
# -+- coding: utf-8 -+-
import re,os
from find_items import *
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

sig_words_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "sig_words.txt")
msg_keywords_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "msg_keywords.txt")
msg_samples_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "280000_templates.txt")
splited_words_path=os.path.join(os.path.split(os.path.realpath(__file__))[0], "splited_words.txt")
splited_keywords_path=os.path.join(os.path.split(os.path.realpath(__file__))[0], "splited_keywords.txt")
splited_words_keywords_path=os.path.join(os.path.split(os.path.realpath(__file__))[0], "splited_words_keywords.txt")


sig_words_fin=open(sig_words_path)
sig_words=[]
for line in sig_words_fin:
  line=unicode(line.strip('\n\r'),'utf-8')
  if len(line)>=1:
    sig_words.append(line)
  else:
    print "there may be something wrong with sig_words.txt!!!"
    print line

print "there are %d words for signatures!!!" % len(sig_words)
sig_words_fin.close()

msg_keywords=dict()
with open(msg_keywords_path, "r") as f:
  for line in f.readlines():
    try:
      line=unicode(line.strip("\n\r"), "utf-8")
      key,val= line.split(unicode('：','utf-8'),1)
      re_key=re.compile(key) #规则作为键,关键词作为值
      if re_key not in msg_keywords:
        msg_keywords[re_key]=val
    except Exception as e:
      print "There may be something wrong with conf_type REs!!!"
      print 'string: [%s] message:[%s]' % (line, e)
      continue
print "there are %d REs for keywords!!!"%len(msg_keywords)

msg_samples_fin=open(msg_samples_path)
splited_words_fout = open(splited_words_path, 'w')
splited_keywords_fout = open(splited_keywords_path, 'w')
splited_words_keywords_fout = open(splited_words_keywords_path, 'w')

ID=0
for line in msg_samples_fin:
  ID+=1 #行的编号id
  matched_words=[]
  matched_keywords=[]
  line=unicode(line,'utf-8')
  split_char=unicode("】",'utf-8')
  join_char=unicode("|",'utf-8')
  if split_char in line: #去掉签名的内容
    sig,msg= line.split(split_char,1) #按中文字符切分一次
  for element in sig_words:
    if element in sig:
      matched_words.append(element)
  for regular_expression in msg_keywords:
    matched_results=re.search(regular_expression,line) #在整个短信中查找关键词,包括签名
    if matched_results is not None:
      matched_keywords.append(msg_keywords[regular_expression])
  line_words=join_char.join(matched_words).encode('utf-8')
  line_keywords=join_char.join(list(set(matched_keywords))).encode('utf-8')
  splited_words_fout.write(str(ID)+","+line_words+'\n')
  splited_keywords_fout.write(str(ID)+","+line_keywords+'\n')
  if line_words!="" and line_keywords!="":
    splited_words_keywords_fout.write(str(ID)+","+line_words+'|'+line_keywords+'\n')
  elif line_words=="" and line_keywords!="":
    splited_words_keywords_fout.write(str(ID)+","+line_keywords+'\n')
  elif line_words!="" and line_keywords=="":
    splited_words_keywords_fout.write(str(ID)+","+line_words+'\n')
  else:
    splited_words_keywords_fout.write(str(ID)+","+""+'\n')

splited_words_fout.close()
splited_keywords_fout.close()
print "finished!!!!"