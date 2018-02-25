#!/bin/bash
CodeDir=/data/application/nginx/html
BakDir=/data/code_backup
MountDir=/backup/nginx-01/code
TODAY=$(date -d 'today' +%Y-%m-%d)

cd $CodeDir
count=$(ls -l | grep dr | wc -l)
for ((i=1;i<=$count;i++));
do
  CodeName=`ls -l | grep dr | awk {'print $9'} | awk 'NR=='$i`
  tar -czvf ${BakDir}/${CodeName}_${TODAY}.tar.gz ${CodeName}
  cp ${BakDir}/${CodeName}_${TODAY}.tar.gz ${MountDir}
done

cd $BakDir
LastWeek=$(date +%Y-%m-%d --date '7 days ago')
BakCount=$(ls -l *.tar.gz | grep ${LastWeek}.tar.gz | wc -l)
if [ $BakCount -ge $count ]
then
    rm *_${LastWeek}.tar.gz
fi

