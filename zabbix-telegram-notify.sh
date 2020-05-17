#!/bin/bash
LOGDIR='/usr/lib/zabbix/alertscripts/log'
OPWD="$PWD" #/usr/lib/zabbix/alertscripts
cd `dirname $0`
if [[ -f "$1" && -n "$1" ]];then
        source "$1"
else
        logger -s "`basename $0`: Token is not specified"
        cd "$OPWD"
        exit 1
fi
cd "$LOGDIR"
CHATID="$2"
TEXT="${3}
${4}"
TIMEOUT='10'
URL="https://api.telegram.org/bot${KEY}/sendMessage"
MSGLOGFILE="msg`basename -s key "$1"`log-`date +"%d%m%Y"`" 
PRP=`printf '+%.0s' {1..64}`
PRS=`printf '#%.0s' {1..64}`
PRE=`printf '=%.0s' {1..64}`
PRC=`printf '^%.0s' {1..64}`
RESPONSE=`curl -m "$TIMEOUT" -d "chat_id=${CHATID}&disable_web_page_preview=1&text=${TEXT}" ${URL}`

if [[ -w "$LOGDIR" ]];then
        echo -e "${PRC}\n`date +"%d.%m.%Y %H:%M:%S"`\n${TEXT}\n${PRP}\nCHATID:${CHATID}\n${PRE}\n${RESPONSE}\n${PRS}" >> "$MSGLOGFILE"
else
        logger -s "`basename $0`: Log directory $LOGDIR is not writable"
        cd "$OPWD"
        exit 1
fi
cd "$OPWD"
exit 0