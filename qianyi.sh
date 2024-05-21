#!/bin/bash

# 清空目标服务器上的文件夹内容
sshpass -p 123456 ssh -o StrictHostKeyChecking=no root@0.0.0.0 rm -rf /home/web

# 将本地目录传输到目标服务器
sshpass -p 123456 scp -r -o StrictHostKeyChecking=no root@0.0.0.0:/home/web
