#!/bin/bash
curl -o /dev/null -s -w %{http_code} https://in.api.haomai234.com/xxxxxxx > /data/log/tongyi_huodong
curl -o /dev/null -s -w %{http_code} http://in.admin.haomai234.com/xxxxxxx > /data/log/syncJdNewSku
curl -o /dev/null -s -w %{http_code} https://in.api.haomai234.com/xxxxxxx > /data/log/faFangYongJin
