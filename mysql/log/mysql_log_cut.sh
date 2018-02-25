#!/bin/bash
LOGS_PATH=/var/log
SLOW_PATH=/data/logs
LOGS_BAK=/data/logs/logfiles
MountDir=/backup/mysql_master/logs
YESTERDAY=$(date -d 'yesterday' +%Y-%m-%d)
cp ${LOGS_PATH}/mysqld.log ${LOGS_BAK}/mysqld_${YESTERDAY}.log && cat /dev/null > ${LOGS_PATH}/mysqld.log
cp ${SLOW_PATH}/slowquery.log ${LOGS_BAK}/slowquery_${YESTERDAY}.log && cat /dev/null > ${SLOW_PATH}/slowquery.log

cd $LOGS_BAK
count=$(ls -l *.log |wc -l)
if [ $count -ge 10 ]
then
  file1=$(ls -l mysqld_*.log |awk '{print $9}'|awk 'NR==1')
  file2=$(ls -l slowquery_*.log | awk '{print $9}'|awk 'NR==1')
  mv $file1 $MountDir
  mv $file2 $MountDir
fi
