#!/bin/bash
export LANG=en_US.UTF-8
BakDir=/data/mysql_backup
LogFile=/data/mysql_backup/backup.log
MountDir=/backup/mysql_master/data_bak
Date=`date +%Y%m%d`
Begin=`date +"%Y年%m月%d日 %H:%M:%S"`
cd $BakDir
DumpFile=$Date.sql
GZDumpFile=$Date.sql.tgz
mysqldump -uroot -p'h!a#o%w&a(n_'  --all-databases --flush-logs --delete-master-logs  --single-transaction > $DumpFile
tar -czvf $GZDumpFile $DumpFile
rm $DumpFile
 
count=$(ls -l  *.tgz |wc -l)
if [ $count -ge 2 ]
then
  file=$(ls -l *.tgz |awk '{print $9}'|awk 'NR==1')
  mv $file $MountDir
fi
 
Last=`date +"%Y年%m月%d日 %H:%M:%S"`
echo 开始:$Begin 结束:$Last $GZDumpFile succ >> $LogFile
cd $BakDir/daily
rm -f *
