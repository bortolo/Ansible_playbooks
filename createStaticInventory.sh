#!/bin/bash
ansible-inventory -i myazure_rm.yml --list >> inventory.json

LENGTH=jq . tag_environment_app.hosts inventory.json
ID=0
echo $LENGTH
for (( i=0 ; i < $LENGTH , i++ ));
do
  ID=jq . tag_environment_app.hosts[$i] inventory.json
  echo jq . _meta.hostvars.$ID.ansible_host inventory.json
done
