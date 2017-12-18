#!/bin/bash
# this pretty much works
# corrects createdAt, removes one extra digit for updatedAt
# munges other lines.  sig
#EPOCHDATE = "$(date +%s)"
#curl -XGET 'https://api.opsgenie.com/v1/json/alert?apiKey=797a6db1-d3a5-4b58-8479-ec287cb730da&createdAfter=${EPOCHDATE}'
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
#curl -s -XGET "https://api.opsgenie.com/v1/json/alert?apiKey=797a6db1-d3a5-4b58-8479-ec287cb730da&createdAfter=${LASTWEEKEPOCH}" | /usr/local/bin/jsonlint >OpsGenie-${TODAYSDATE}.txt
#curl -s -XGET "https://api.opsgenie.com/v2/alerts?limit=100&apiKey=797a6db1-d3a5-4b58-8479-ec287cb730da&createdAfter=${LASTWEEKEPOCH}" | /usr/local/bin/jsonlint >OpsGenie-${TODAYSDATE}.txt
curl -s -XGET "https://api.opsgenie.com/v2/alerts?limit=100&apiKey=797a6db1-d3a5-4b58-8479-ec287cb730da&query=createdAt>=${LASTWEEKEPOCH}" | /usr/local/bin/jsonlint >OpsGenie-${TODAYSDATE}.txt
ALARMS=`grep -i message OpsGenie-${TODAYSDATE}.txt|cut -f 4 -d "\""|sort | uniq -c | sort -n`
ALARMSCOUNT=`grep -i message OpsGenie-${TODAYSDATE}.txt|wc -l` 
echo "there were $ALARMSCOUNT OpsGenies alarms for the week ending $TODAYSDATE"

grep -i message OpsGenie-${TODAYSDATE}.txt |cut -f 4  -d "\""| sort | uniq -c | sort -n
#grep -i message OpsGenie-${TODAYSDATE}.txt
MESSAGE="there were $ALARMSCOUNT OpsGenies alarms for the week ending $TODAYSDATE"
#curl -XPOST --data-urlencode 'payload={"text": "This is posted to #general and comes from *monkey-bot*.", "channel": "#Marc Richardson ", "link_names": 1, "username": "monkey-bot", "icon_emoji": ":monkey_face:"}' \
    #    curl -XPOST --data "'$MESSAGE'" "https://hooks.slack.com/services/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" # 'payload={"text": "there were $ALARMSCOUNT OpsGenies alarms for the week ending $TODAYSDATE",  "link_names": 1, "username": "monkey-bot", "icon_emoji": ":monkey_face:"}' \
    # sweet!
#echo $ALARMS
	     curl -XPOST --data-urlencode 'payload={"text": "'"there were $ALARMSCOUNT OpsGenies alarms for the week ending $TODAYSDATE"'",  "link_names": 1, "username": "monkey-bot", "icon_emoji": ":monkey_face:"}' https://hooks.slack.com/services/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
	     	     curl -XPOST --data-urlencode 'payload={"text": "'"these were the alarms$ALARMS"'",  "link_names": 1, "username": "monkey-bot", "icon_emoji": ":monkey_face:"}' https://hooks.slack.com/services/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


    #curl -XPOST --data-urlencode 'payload={"text": "This is posted to #general and comes from *monkey-bot*.", "link_names": 1, "username": "monkey-bot", "icon_emoji": ":monkey_face:"}' https://hooks.slack.com/services/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
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
