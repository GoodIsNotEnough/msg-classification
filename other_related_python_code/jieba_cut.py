# coding: utf-8
import re
import sys
import string
reload(sys)
sys.setdefaultencoding('utf-8')
import jieba

# 如果有一些词语需要合并可以添加个人词典
# jieba.load_userdict('userdict.txt')
# 创建停用词列表
def creadstoplist(stopwordspath):
    stwlist = [line.strip()for line in open(stopwordspath, 'r').readlines()]
    return stwlist

# 对句子进行分词
def seg_sentence(sentence):
    wordList = jieba.cut(sentence.strip())
    #停用词文件由用户自己建立,注意路径必须和源文件放在一起
    stwlist = creadstoplist('stopwords.txt')#这里加载停用词的路径
    outstr = ''
    for word in wordList:
        if word not in stwlist:
            if len(word) >=1 or word in [u'亲',u'折',u'减',u'满']:  # 去掉长度为1的词
                if word != '\t':
                    outstr += word
                    outstr += " "
    return outstr

infile = open(r'F:\MSG\reducer.txt', 'r')
outfile = open(r'F:\MSG\outfile.txt', 'w')
ID=0
null_line=0
word_list=[]
for line in infile:
    ID+=1 #行的编号id
    # outfile.write(line)
    line=unicode(line,'utf-8')
    split_char=unicode("】",'utf-8')
    if split_char in line: #去掉签名的内容
      head,line= line.split(split_char,1) #按中文字符切分一次
    #去掉字符串中的字母+数字+英文标点符号,不考虑英文单词
    # line= filter(lambda ch: ch not in string.lowercase+string.uppercase+string.digits+string.punctuation+" ", line)
    line= filter(lambda ch: ch not in string.digits+string.punctuation+" ", line)
    line_seg = seg_sentence(line)  # 这里的返回值是字符串
    if len(line_seg)<1: #结果的分词列表不能为空
      null_line+=1
    strip_char=unicode(" ",'utf-8')
    split_char=unicode(" ",'utf-8')
    join_char=unicode("|",'utf-8')
    line_seg=line_seg.strip(strip_char).split(split_char)
    word_list.extend(line_seg)
    line_seg=join_char.join(list(set(line_seg))) #去重复词汇
    # line_seg=join_char.join(line_seg)
    line_seg=line_seg.encode('utf-8')
    outfile.write(str(ID)+","+line_seg+'\n')
print null_line

# word_list=list(set(word_list)) #去重复词汇
# for e in word_list:
#     print e

outfile.close()
infile.close()
