#!/bin/bash 

# Create a tar archive of the web directory
cd /home/ && tar czvf web_$(date +"%Y%m%d%H%M%S").tar.gz web
# Create a tar archive of the docker directory
cd /home/ && tar czvf docker_$(date +"%Y%m%d%H%M%S").tar.gz docker

# Transfer the tar archive to another VPS
cd /home/ && ls -t /home/*.tar.gz | head -2 | xargs -I {} sshpass -p 123456 scp -o StrictHostKeyChecking=no -P 22 {} root@0.0.0.0:/home/

# Keep only 5 tar archives and delete the rest
cd /home/ && ls -t /home/*.tar.gz | tail -n +4 | xargs -I {} rm {}

sshpass -p 123456 ssh -o StrictHostKeyChecking=no -p 22 root@0.0.0.0 << EOF
cd /home/
ls -t /home/*.tar.gz | tail -n +4 | xargs -I {} rm {}
EOF

