#!/bin/bash

word_file=./test.txt
for_line=`cat $word_file | awk {'print NR'}`
word_line=`cat $word_file | awk {'print NR'} | wc -l`
word_sum=0
echo $for_column

for i in ${for_line}
do
  j=1
  while [ $j -le `cat $word_file | awk {'print NF'} | sed -n ${i}'p'` ]
  do
    echo `cat $word_file | awk {'print $'$j''} | sed -n ${i}'p'` >> ./stat.txt
    j=$((j+1))
  done
  word_line_num=`sed -n ${i}'p' test.txt | awk {'print NF'}`
  word_sum=$(($word_sum +$word_line_num))
done

echo '文件行数:' ${word_line}
echo '单词个数:' ${word_sum}
echo '文件字节数:' `du -b ${word_file} | awk {'print $1'}`
echo '出现最频繁的单词:' `cat stat.txt | sort -nr | uniq -c | sort -r | head -5`
