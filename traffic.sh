#!/bin/sh

echo "### uptime ###" >> /var/log/daylog_`date +\%Y\%m\%d`.log
uptime >> /var/log/daylog_`date +\%Y\%m\%d`.log

echo "### network ###" >> /var/log/daylog_`date +\%Y\%m\%d`.log
RX=`cat /proc/net/dev | sed -n 4p | tr -s [:space:] | cut -d " " -f 3`
TX=`cat /proc/net/dev | sed -n 4p | tr -s [:space:] | cut -d " " -f 11`
RXATX=$(( RX + TX ))
GB=1073741824

COUNT=0
QUOTIENT=0
QUOTIENT_=0
REMAINDER=0

QUOTIENT=$(( RXATX / GB ))
REMAINDER=$(( RXATX % GB * 10 ))
while [ $REMAINDER -ne 0 -a $COUNT -lt 2 ]
do
	QUOTIENT_=$(( QUOTIENT_ * 10 + REMAINDER / GB ))
	REMAINDER=$(( REMAINDER % GB * 10 ))
	COUNT=$(( COUNT + 1 ))
done

echo "${QUOTIENT}.${QUOTIENT_} GB" >> /var/log/daylog_`date +\%Y\%m\%d`.log

#日でわるしょりを入れる
#増えたログを消す処理を入れる
