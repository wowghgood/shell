#!/bin/bash
today=$(date +%Y-%m-%d)
log_dir=/data/log
log_file=(tongyi_huodong syncJdNewSku faFangYongJin)
sync_mail=/data/script/sync/sync_mail.txt
contact_mail=(guohao0719@126.com wangwei@haowan234.com miaodi@haowan234.com)

for i in ${log_file[@]}
do
  if [ `cat ${log_dir}/${i}` = 200 ]
  then
    echo "["$today"]"$i" sync success! http_code="`cat ${log_dir}/${i}` >> /data/script/sync/sync.log
    echo "[success] " $i " {http_code}="`cat ${log_dir}/${i}` > $sync_mail

    for j in ${contact_mail[@]}
    do
      mailx -v -s "日单位同步任务执行成功-" $j < $sync_mail
    done
    /usr/bin/rm -fr ${log_dir}/${i}

  else
    echo "["$today"]"$i" sync failed! http_code"`cat ${log_dir}/${i}` >> /data/script/sync/sync.log
    echo "[failed] " $i " {http_code}="`cat ${log_dir}/${i}` > $sync_mail

    for j in ${contact_mail[@]}
    do
      mailx -v -s "日单位同步任务执行失败-" $j < $sync_mail
    done
    /usr/bin/rm -fr ${log_dir}/${i}    

  fi
done

/usr/bin/rm -fr $sync_mail
