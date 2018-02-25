#!/bin/bash
today=$(date +%Y-%m-%d)
now_time=$(date +%Y-%m-%d'T'%H:%M:%S'+08:00')
month_dir=$(date +%Y%m)
log_dir=/data/application/nginx/html/api/runtime/log
today_log=$(date +%d'_error.log')
log_message=/data/script/nginx/api/mail_message.txt
send_message=/data/script/nginx/api/send_message.txt
time_file=/data/script/nginx/api/time.txt
last_time=$(cat /data/script/nginx/api/time.txt)
recent_time=`tac ${log_dir}/${month_dir}/${today_log} | grep ${today} | head -1 | awk {'print $2'}`
recent_log=`sed -n '/'$recent_time'/,$p' ${log_dir}/${month_dir}/${today_log}`
contact_mail=(guohao@haowan234.com ww@haowan234.com lmd@haowan234.com chenyingwei@haowan234.com)

if [ ! -f ${log_dir}/${month_dir}/${today_log} ];then
  echo "exit"
  exit 0
fi

if [ $recent_time == $last_time ];then
  echo "exit"
  exit 0
else
  echo "send"
  echo $recent_log > $log_message
  sleep 1
  /usr/bin/iconv $log_message -f UTF-8 -t GB2312 > $send_message
  sleep 1
  send_time=`cat $send_message | awk {'print $2'}`
  if [ $recent_time == $send_time ];then
    for i in ${contact_mail[@]}
    do
      mailx -v -s "nginx-01_183 API Error Alarm" $i < ${send_message}
    done
    echo $recent_time > $time_file
    exit 0
  else
    exit 1
  fi
fi
