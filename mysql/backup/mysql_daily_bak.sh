#!/bin/bash
export LANG=en_US.UTF-8
BakDir=/data/mysql_backup/daily
BinDir=/data
LogFile=/data/mysql_backup/backup.log
BinFile=/data/mysql-bin.index
mysqladmin -uroot -p'h!a#o%w&a(n_' flush-logs
Counter=`wc -l $BinFile |awk '{print $1}'`
NextNum=0

for file in  `cat $BinFile`
do
        base=`basename $file`
        NextNum=`expr $NextNum + 1`
        if [ $NextNum -eq $Counter ]
        then
                echo $base skip!  >> $LogFile
        else
                dest=$BakDir/$base
                if(test -e $dest)
                then
                        echo  $base exist! >> $LogFile
                else
                        cp $BinDir/$base $BakDir
                        echo $base copying >> $LogFile
                fi
        fi
done
echo `date +"%Y年%m月%d日 %H:%M:%S"`  Bakup succ! >> $LogFile
