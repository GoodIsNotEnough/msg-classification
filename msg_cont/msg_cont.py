#!/usr/bin/python
# -*- coding: utf-8 -*-
import os,re
import sys
reload(sys)
sys.setdefaultencoding('utf-8')
from collections import defaultdict

#顺序:call->gender
#顺序:wechat->mobile_no
#顺序:menbership_no->date

def read_conf_re(conf_file_path):
  d=dict()
  ranked_fields=[]
  with open(conf_file_path, "r") as f:
    for line in f.readlines():
      try:
        line=unicode(line.strip("\n"), "utf-8")
        key,val= line.split(":",1)
        re_val=re.compile(val)
        if key not in d:
          d[key]=[re_val]
          ranked_fields.append(key)
        else:
          d[key].append(re_val)
      except Exception as e:
        print 'string: [%s] message:[%s]' % (line, e)
        continue
  return ranked_fields,d

def read_sig_words(sig_words_path):
  sig_words_fin=open(sig_words_path)
  sig_words=[]
  for line in sig_words_fin:
    line=unicode(line.strip('\n\r'),'utf-8')
    if len(line)>=1:
      sig_words.append(line)
    else:
      print "there may be something wrong with sig_words.txt!!!"
  sig_words_fin.close()
  return sig_words

def read_msg_keywords(msg_keywords_path):
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
        print "There may be something wrong with msg_keywords.txt!!!"
        print 'string: [%s] message:[%s]' % (line, e)
        continue
  return msg_keywords

def find_item(ranked_fields,conf_dict,line):
  #注意：line为unicode编码
  #匹配正则
  d=dict()
  for key,val in conf_dict.items(): 
    for regular_expression in val:
      item=re.search(regular_expression,line)
      if item is not None: 
        d[key]=item.group(1)
        break

  #替换匹配
  for field in ranked_fields:
    if d.has_key(field):
      if field!='signature': #签名不替换
        split_char=unicode("】",'utf-8')
        if split_char in line:
          head,tail= line.split(split_char,1) #按中文字符切分
          tail=tail.replace(d[field],'{'+field+'}',1) #在非签名内容中替换1次
          line=head+split_char+tail
        else:
          line=line.replace(d[field],'{'+field+'}',1)
  signature=d['signature'] if 'signature' in d else ''
  key_val=[key+':'+val for key,val in d.items()]
  map_val='{'+';'.join(key_val)+'}' #转成map格式
  signature=signature.encode('utf-8'); map_text=map_val.encode('utf-8'); template=line.encode('utf-8')
  return (signature,map_text,template)
  #line即为template

def find_words_keywords(sig_words,msg_keywords,line):
  #注意：line为unicode编码
  matched_words=[]
  matched_keywords=[]
  split_char=unicode("】",'utf-8')
  join_char=unicode("|",'utf-8')
  if split_char in line: #去掉签名的内容
    sig,msg= line.split(split_char,1) #按中文字符切分一次
  else:
    sig=""
  for element in sig_words:
    if element in sig:
      matched_words.append(element)
  for regular_expression in msg_keywords:
    matched_results=re.search(regular_expression,line)
    if matched_results is not None:
      matched_keywords.append(msg_keywords[regular_expression])
  line_words=join_char.join(matched_words).encode('utf-8')
  line_keywords=join_char.join(list(set(matched_keywords))).encode('utf-8')
  return (line_words,line_keywords)


def running_task(taskfile,running_file,api):
  if not os.path.exists(taskfile):
    input_file_tag = -1
    print taskfile,'does not exist!!!'
  else:
    input_file_data = open(taskfile, "r")
    input_file_tag = 1

  #conf_re.txt必须和源文件放在一个文件夹中
  conf_re_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "conf_re.txt")
  if not os.path.exists( conf_re_path): 
    conf_re_tag=-1
    print  conf_re_path,'does not exist!!!'
  else:
    ranked_fields,conf_re_dict=read_conf_re( conf_re_path)
    conf_re_tag=1

  #sig_words.txt必须和源文件放在一个文件夹中
  sig_words_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "sig_words.txt")
  if not os.path.exists(sig_words_path): 
    sig_words_tag=-1
    print sig_words_path,'does not exist!!!'
  else:
    sig_words=read_sig_words(sig_words_path)
    sig_words_tag=1

  #msg_keywords.txt必须和源文件放在一个文件夹中 read_msg_keywords(msg_keywords_path):
  msg_keywords_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "msg_keywords.txt")
  if not os.path.exists(msg_keywords_path): 
    msg_keywords_tag=-1
    print msg_keywords_path,'does not exist!!!'
  else:
    msg_keywords=read_msg_keywords(msg_keywords_path)
    msg_keywords_tag=1

  result_num=0
  if input_file_tag==1 and conf_re_tag==1 and sig_words_tag==1 and msg_keywords_tag==1:
    if not os.path.exists(running_file):
      result_data=open(running_file,"w")
      result_data.close()
    while True:
      full_line=input_file_data.readline()
      if not full_line:
        break
      full_line=full_line.strip('\n')
      msg_id,msg=full_line.split(',',1)
      msg=unicode(msg,'utf-8') #短信,必须转成unicode编码
      signature,map_text,template=find_item(ranked_fields,conf_re_dict,msg)
      line_words,line_keywords=find_words_keywords(sig_words,msg_keywords,unicode(template,'utf-8')) #在模板中匹配字词
      msg=msg.encode('utf-8')
      output_text=','.join([msg_id,line_words,line_keywords,signature,map_text,template,msg])+'\n'
      result_data = open(running_file, "a")
      result_data.write(output_text)
      result_data.close()
      result_num+=1
  print "There are %d lines in the resulted running_file !!!" % result_num