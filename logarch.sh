#!/bin/bash
LOGDIR='/usr/lib/zabbix/alertscripts/log'
ARCH='logs.tgz'
TODAY=`date +%d%m%Y`
OPWD="$PWD" #/usr/lib/zabbix/alertscripts

[[ ! -w "$LOGDIR" ]] && logger -s "`basename $0`: Directory $LOGDIR is not writable." && exit 1
cd "$LOGDIR"
tar -cvf "$ARCH" *.log-* && find . -name "*.log-*" -mtime 1 -exec rm {} \;
cd "$OPWD"