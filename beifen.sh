#!/bin/bash

# Create a tar archive of the web directory
cd /home/ && tar czvf home_$(date +"%Y%m%d%H%M%S").tar.gz *

# Transfer the tar archive to another VPS
cd /home/ && ls -t /*.tar.gz | head -1 | xargs -I {} sshpass -p 123456 scp -o StrictHostKeyChecking=no -P 22 {} root@0.0.0.0:/home/

# Keep only 5 tar archives and delete the rest
cd /home/ && ls -t /*.tar.gz | tail -n +4 | xargs -I {} rm {}
