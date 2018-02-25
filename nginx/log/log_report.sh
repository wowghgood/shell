#!/bin/bash
source ~/.bash_profile
address=192.168.1.183
month_dir=$(date -d "1 day ago" +%Y%m)
log_dir=/data/application/nginx/html/api/runtime/log
yesterday=`date -d "1 day ago" +%d`
contact_mail=(guohao0719@126.com wangwei@haowan234.com miaodi@haowan234.com chenyingwei@haowan234.com)

statement=`/usr/bin/cat $log_dir/$month_dir/${yesterday}_error.log | grep -v "error" | grep $address | awk {'print $7'} | grep "?" | awk -F'?' '{print $(NF-1)}' | sort >> api_mail.txt && /usr/bin/cat $log_dir/$month_dir/${yesterday}_error.log | grep -v "error" | grep $address | awk {'print $7'} | grep -v "?" | sort >> api_mail.txt && /usr/bin/cat -v api_mail.txt | tr -d '^M' > napi_mail.txt && /usr/bin/cat napi_mail.txt | sort | uniq -c | sort -nr | sed 's/^[ ]*//g' | sed 's/ /,/g' > ${yesterday}_api_statement.csv && rm -fr *api_mail.txt`

$statement
if [ -f "${yesterday}_api_statement.csv" ]
then
  for i in ${contact_mail[@]}
  do
    mailx -v -s "API statement" -a ${yesterday}_api_statement.csv $i < /data/script/nginx/api/api_stm.txt
  done
  /usr/bin/rm -fr ${yesterday}_api_statement.csv
else
  echo "Report statement failure!" >> /data/script/nginx/api/statement.log 
fi
