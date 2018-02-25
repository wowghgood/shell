#!/bin/bash
today=$(date +%Y-%m-%d)
now_time=$(date +%d/%b/%Y:%H:%M:%S'+0800')
log_dir=/data/application/tomcat_api/logs/web
log_message=/data/script/tomcat/check/error/log_message.txt
send_message=/data/script/tomcat/check/error/send_message.txt
mail_message=/data/script/tomcat/check/error/mail_message.txt
time_file=/data/script/tomcat/check/error/time.txt

last_time=$(cat ${time_file})
today_log='haomai-api-error.log'
recent_time=`cat ${log_dir}/${today_log} | tail -1 | awk {'print $2'}`
recent_log=`cat ${log_dir}/${today_log} | grep ${recent_time}`

state_code=`cat $send_message | awk {'print $9'}`
time_out=`cat $send_message | awk {'print $10'}`
contact_mail=(guohao@haowan234.com lmd@haowan234.com zhouyizheng@haowan234.com)

echo $recent_time
echo $last_time

if [[ $recent_time = $last_time ]];then
  echo "nothing to do"
  exit 0
else
  echo $recent_log > $log_message
  sleep 1
  /usr/bin/iconv $log_message -f UTF-8 -t GB2312 > $send_message
  sleep 1
  send_time=`cat $send_message | awk {'print $2'}`
  #if [ $recent_time == $send_time ];then
    echo "send"
    cat $send_message > $mail_message
    for i in ${contact_mail[@]}
    do
      mailx -v -s "Tomcat-02_185 JAPI Error Alarm" $i < ${mail_message}
    done
    echo $recent_time > $time_file
    exit 0
  #else
  #  echo "nothing to do"
  #  exit 1
  #fi
fi
