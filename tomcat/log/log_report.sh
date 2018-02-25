#!/bin/bash
source ~/.bash_profile
log_dir=/data/application/tomcat_api/logs
yesterday=`date -d "1 day ago" +%Y-%m-%d`
contact_mail=(guohao0719@126.com zhouyizheng@haowan234.com miaodi@haowan234.com)

statement=`/usr/bin/cat $log_dir/localhost_access_log${yesterday}.txt | awk '{if($9!~"200") print}' > japi_statement.txt && /usr/bin/cat japi_statement.txt | grep "?" | awk -F'?' '{print $(NF-1)}' | awk {'print $7'} | sort >> japi_mail.txt && /usr/bin/cat japi_statement.txt | grep -v "?" | awk {'print $8'} | sort >> japi_mail.txt && /usr/bin/cat -v japi_mail.txt | tr -d '^M' > njapi_mail.txt && /usr/bin/cat njapi_mail.txt | sort | uniq -c | sort -nr | sed 's/^[ ]*//g' | sed 's/ /,/g' > ${yesterday}_japi_statement.csv && rm -fr *japi_mail.txt`

if [ -f "${yesterday}_japi_statement.csv" ]
then
  for i in ${contact_mail[@]}
  do
    mailx -v -s "JAPI statement" -a ${yesterday}_japi_statement.csv $i < /data/script/tomcat/statement/japi_stm.txt
  done
  /usr/bin/rm -fr ${yesterday}_japi_statement.csv
else
  echo "Report statement failure!" >> /data/script/tomcat/statement/statement.log
fi
