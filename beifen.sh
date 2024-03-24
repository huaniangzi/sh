#!/bin/bash

# Create a tar archive of the web directory
cd /home/ && tar czvf home_$(date +"%Y%m%d%H%M%S").tar.gz *

# Transfer the tar archive to another VPS
cd /home/ && tar_file=$(ls -t *.tar.gz | head -1) && \
sshpass -p 123456 scp -o StrictHostKeyChecking=no -P 22 "$tar_file" root@0.0.0.0:/home/

# Keep only 4 tar archives on the remote server and delete the rest
sshpass -p 123456 ssh -o StrictHostKeyChecking=no -p 22 root@0.0.0.0 << EOF
cd /home/
ls -t *.tar.gz | tail -n +5 | xargs -I {} rm {}
EOF

# Delete all locally created tar archives
rm /home/*.tar.gz
