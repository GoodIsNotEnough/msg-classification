#!/usr/bin/python
# -*- coding: utf-8 -*-
import re
import sys
reload(sys)
sys.setdefaultencoding('utf-8')
from collections import defaultdict
#在'utf8'模式下，汉字的正则也可以添加[]？*+

#顺序:call->gender
#顺序:wechat->mobile_no
#顺序:menbership_no->date
#顺序:QQ->wechat

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
                print "There may be something wrong with conf_re REs!!!"
                print 'string: [%s] message:[%s]' % (line, e)
                continue
    return ranked_fields,d

def read_conf_type(conf_file_path):
    d=dict()
    with open(conf_file_path, "r") as f:
        for line in f.readlines():
            try:
                line=unicode(line.strip("\n"), "utf-8")
                key,val= line.split(":",1)
                re_val=re.compile(val)
                if key not in d:
                    d[key]=[re_val]
                else:
                    d[key].append(re_val)
            except Exception as e:
                print "There may be something wrong with conf_type REs!!!"
                print 'string: [%s] message:[%s]' % (line, e)
                continue
    return d

def read_conf_industry(conf_file_path):
    d=dict()
    with open(conf_file_path, "r") as f:
        for line in f.readlines():
            try:
                line=unicode(line.strip("\n"), "utf-8")
                key,val= line.split(":",1)
                re_val=re.compile(val)
                if key not in d:
                    d[key]=[re_val]
                else:
                    d[key].append(re_val)
            except Exception as e:
                print "There may be something wrong with conf_industry REs!!!"
                print 'string: [%s] message:[%s]' % (line, e)
                continue
    return d

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
    map_val='{'+';'.join(key_val)+'}'
    signature=signature.encode('utf-8'); map_val=map_val.encode('utf-8'); line=line.encode('utf-8')
    return line 
    # return ','.join([signature,map_val,line])

def find_msg_type(conf_dict,line):
    #注意：line为unicode编码
    #匹配正则
    match_content=[]
    frequencies = defaultdict(int) #传入int()函数来初始化
    for key,val in conf_dict.items(): 
        for regular_expression in val:
            item=re.search(regular_expression,line)
            if item is not None: 
                frequencies[key]+=1
                match_content.append(item.group(1))

    if len(frequencies)>=1:
        d=sorted(frequencies.iteritems(), key=lambda d:d[1], reverse = True ) #d[0]为key,d[1]为value,返回一个元组列表
        msg_type=d[0][0].encode('utf-8')
    else:
        msg_type="notification"
    return msg_type #if len(frequencies)==0 else msg_type+"\t"+"|".join(match_content)

def find_msg_industry(conf_dict,line):
    #注意：line为unicode编码
    #匹配正则
    r1='【(.+?)】' #匹配签名
    r1=re.compile(unicode(r1,'utf8'))
    result=re.search(r1,line)
    signature=result.group(1) if result is not None else ""

    match_content=[]
    frequencies = defaultdict(int) #传入int()函数来初始化
    for key,val in conf_dict.items(): 
        for regular_expression in val:
            if key=="logistics":
                item=re.search(regular_expression,signature)
            else:
                item=re.search(regular_expression,line)
            if item is not None:
                if key=="logistics":
                    frequencies[key]+=100
                else:
                    frequencies[key]+=1
                match_content.append(item.group(1))

    if len(frequencies)>=1:
        d=sorted(frequencies.iteritems(), key=lambda d:d[1], reverse = True ) #d[0]为key,d[1]为value,返回一个元组列表
        msg_industry=d[0][0].encode('utf-8')+str(d[0][1]) if d[0][1]>=2 else "unknown"
    else:
        msg_industry="unknown"
    if u'钱' in signature or u'贷' in signature:
        msg_industry="financial"
    if u'酒店' in signature or u'宾馆' in signature or u'客栈' in signature or u'公寓' in signature:
        msg_industry="travel"
    return msg_industry+"|".join(match_content) #if len(frequencies)==0 else msg_type+"\t"+"|".join(match_content)