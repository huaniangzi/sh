#!/bin/bash 

# Create a tar archive of the home directory
cd / && tar czvf /home/home_$(date +"%Y%m%d%H%M%S").tar.gz home

# Transfer the tar archive to another VPS
latest_backup=$(ls -t /home_* | head -1)
sshpass -p 123456 scp -o StrictHostKeyChecking=no -P 22 "$latest_backup" root@0.0.0.0:/home/

# Keep only 3 latest backups on remote server
sshpass -p 123456 ssh -o StrictHostKeyChecking=no -p 22 root@0.0.0.0 << EOF
cd /home/
ls -t /home_*.tar.gz | tail -n +4 | xargs -I {} rm {}
EOF

# Delete all other backups except the latest one
rm /home_*.tar.gz
