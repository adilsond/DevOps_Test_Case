#!/bin/bash

#Set max days

days=30

#Use API and curl to get all indices
LogstashArray=(`curl -XGET 'elasticsearch:9200/_cat/indices?v&pretty' 2>/dev/null |awk '{print$3}'  |grep logstash-20`)
MonitoringArray=(`curl -XGET 'elasticsearch:9200/_cat/indices?v&pretty' 2>/dev/null |awk '{print$3}'  |grep .monitoring`)

#How many logstash indices, how many system indices
LogstashLen=${#LogstashArray[@]}
MonitoringLen=${#MonitoringArray[@]}


#Get all system and logstash arrays and remove any index older than n days.

for ((i=0; i<${LogstashLen}; i++))
do
  index=${LogstashArray[i]}
  date=${index:(-10)}
  date=$(echo $date| sed "s/\./-/g")
  date_epoch=$(date -d  "$date" '+%s')
  today_epoch=$(date +%s)
  age=$((($today_epoch - $date_epoch) / 60 / 60 / 24))
  if [ $age -gt $days ];
   then
   echo "Logstash index $index is $age days old. Deleting..."
   address=elasticsearch:9200/$index?pretty
   curl -XDELETE $address 2>/dev/null
   elif [ $age -le $days ];
   then
   echo "Logstash index $index is $age days old. Keeping";
   fi
done

for ((i=0; i<${MonitoringLen}; i++))
do
  index=${MonitoringArray[i]}
  date=${index:(-10)}
  date=$(echo $date| sed "s/\./-/g")
  date_epoch=$(date -d  "$date" '+%s')
  today_epoch=$(date +%s)
  age=$((($today_epoch - $date_epoch) / 60 / 60 / 24))
  if [ $age -gt $days ];
   then
   echo "System index $index is $age days old. Deleting...";
   address=elasticsearch:9200/$index?pretty
   curl -XDELETE $address 2>/dev/null
   elif [ $age -le $days ];
   then
   echo "Systam index $index is $age days old. Keeping";
   fi
done
