#!/bin/bash
LOGS_PATH=/data/application/nginx/logs
YESTERDAY=$(date -d 'yesterday' +%Y-%m-%d)
MountDir=/backup/nginx-02/logs
mv ${LOGS_PATH}/access.log ${LOGS_PATH}/logfiles/access_${YESTERDAY}.log
mv ${LOGS_PATH}/error.log ${LOGS_PATH}/logfiles/error_${YESTERDAY}.log

/etc/init.d/nginx reload

cd $LOGS_PATH/logfiles
count=$(ls -l *.log |wc -l)
if [ $count -ge 28 ]
then
  file1=$(ls -l access_*.log |awk '{print $9}'|awk 'NR==1')
  file2=$(ls -l error_*.log | awk '{print $9}'|awk 'NR==1')
  mv $file1 $MountDir
  mv $file2 $MountDir
fi
