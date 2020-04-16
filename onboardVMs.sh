#!/bin/bash
for server in `cat server.txt`;
do
    ssh-keyscan -H $server >> ~/.ssh/known_hosts
    sshpass -p "Password1234!" ssh-copy-id -i ~/.ssh/id_rsa.pub myadmin@$server
done
