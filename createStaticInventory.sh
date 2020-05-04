#!/bin/bash
# Create a static inventory of IPs from myazure_rm.yml dynamic inventory
# JSON file created by myazure_rm.yml is parsed with jq
# server.txt is created appending all IPs with the tag tag_environment_app and tag_environment_web
# server.txt is used by the script onboardVMs.sh to create the ssh tunnel between ansible server and the other servers

rm -f server.txt
LENGTH=$(ansible-inventory -i myazure_rm.yml --list | jq '.tag_environment_app.hosts | length')
for (( i=0 ; i < $LENGTH ; i++ ));
do
  temp=$(ansible-inventory -i myazure_rm.yml --list | jq .tag_environment_app.hosts[$i])
  temp="${temp%\"}"
  temp="${temp#\"}"
  temp=$(ansible-inventory -i myazure_rm.yml --list | jq ._meta.hostvars.$temp.ansible_host)
  temp="${temp%\"}"
  temp="${temp#\"}"
  echo $temp >> server.txt
done
LENGTH=$(ansible-inventory -i myazure_rm.yml --list | jq '.tag_environment_web.hosts | length')
for (( i=0 ; i < $LENGTH ; i++ ));
do
  temp=$(ansible-inventory -i myazure_rm.yml --list | jq .tag_environment_web.hosts[$i])
  temp="${temp%\"}"
  temp="${temp#\"}"
  temp=$(ansible-inventory -i myazure_rm.yml --list | jq ._meta.hostvars.$temp.ansible_host)
  temp="${temp%\"}"
  temp="${temp#\"}"
  echo $temp >> server.txt
done
