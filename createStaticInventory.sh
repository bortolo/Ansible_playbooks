#!/bin/bash
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
