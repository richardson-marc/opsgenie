#!/bin/bash
# this pretty much works
# corrects createdAt, removes one extra digit for updatedAt
# munges other lines.  sig
#EPOCHDATE = "$(date +%s)"
EPOCHDATE="$(date +%s)"
WEEKOFSECONDS=604800
LASTWEEKEPOCH=`expr $EPOCHDATE - $WEEKOFSECONDS`
#echo $EPOCHDATE
TODAYSDATE="$(date +%Y-%m-%d)"
#echo $TODAYSDATE

echo "epoch date is $EPOCHDATE"
echo "week of seconds is $WEEKOFSECONDS"
echo "last week epoch is $LASTWEEKEPOCH"

# sweet!
curl -s -XGET "https://api.opsgenie.com/v2/alerts?limit=100&apiKey=OPSGENIEKEY&query=createdAt>=${LASTWEEKEPOCH}" | /usr/local/bin/jsonlint >OpsGenie-${TODAYSDATE}.txt
ALARMS=`grep -i message OpsGenie-${TODAYSDATE}.txt|cut -f 4 -d "\""|sort | uniq -c | sort -n`
ALARMSCOUNT=`grep -i message OpsGenie-${TODAYSDATE}.txt|wc -l` 
echo "there were $ALARMSCOUNT OpsGenies alarms for the week ending $TODAYSDATE"

grep -i message OpsGenie-${TODAYSDATE}.txt |cut -f 4  -d "\""| sort | uniq -c | sort -n
#grep -i message OpsGenie-${TODAYSDATE}.txt
MESSAGE="there were $ALARMSCOUNT OpsGenies alarms for the week ending $TODAYSDATE"
    # sweet!
#echo $ALARMS
	     curl -XPOST --data-urlencode 'payload={"text": "'"there were $ALARMSCOUNT OpsGenies alarms for the week ending $TODAYSDATE"'",  "link_names": 1, "username": "monkey-bot", "icon_emoji": ":monkey_face:"}' https://hooks.slack.com/services/T0299LT7G/B66ESQ7H9/SLACKKEY
	     	     curl -XPOST --data-urlencode 'payload={"text": "'"these were the alarms$ALARMS"'",  "link_names": 1, "username": "monkey-bot", "icon_emoji": ":monkey_face:"}' https://hooks.slack.com/services/T0299LT7G/B66ESQ7H9/SLACKKEY


exit


while read line; do
#    [[ $line =~ createdAt ]] || continue
    # do something with $line or $BASH_REMATCH, perhaps put it in an array.
#if [[$line =~ createdAt]]; then
    sed 's/.\{10\}$//'
    #    fi
    
#    sed "s/.\{10\}/date -r $1/" 5-23-alerts
    
#    if $1 =~ ^[0-9]{,10}$ && $1 -ne 0; then
#    if [[ $1 =~ ^(2000000000|[0-9]{1,3})$ ]]; then
#	echo " a digit"
#	echo "0 <= $1 <= 1000 (1)"
#	fi
#    sed -n "s/.*\[0-9]+\.*/\1/p"
#done < $TODAYSDATE-alerts
done
