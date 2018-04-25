#!/usr/bin/env python
#_*_coding:utf-8_*_
import os

file_dir = 'test.txt'
word_num = 0
file_line = 0
word_dict = {}

f = file(file_dir,'rb')
for i in f.readlines():
  a = i.strip('\n').split()
  for j in range(len(a)):
    if word_dict.has_key(a[j]) == True:
      word_dict[a[j]] = word_dict[a[j]]+1
    else:
      word_dict[a[j]] = 1
  word_num += len(a)
  file_line += 1
f.close()

dict_sort = sorted(word_dict.items(), key=lambda d:d[1], reverse = True)[:5]

print '文件行数:' , file_line
print '单词个数：' , word_num
print '文件字节数：', os.path.getsize(file_dir)
print '出现最频繁的单词：', dict_sort
