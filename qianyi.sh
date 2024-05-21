#!/bin/bash

# 目标服务器相关信息
target_server_ip="目标服务器IP"
remote_folder="/home/web"
username="root"
password="远程服务器密码"

# 清空目标服务器上的文件夹内容
sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$username@$target_server_ip" "rm -rf $remote_folder/*"

# 本地目录
local_folder="/home/web"

# 将本地目录传输到目标服务器
sshpass -p "$password" scp -r -o StrictHostKeyChecking=no "$local_folder" "$username@$target_server_ip:$remote_folder"
