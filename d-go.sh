#!/usr/bin/env bash
# echo ' ✅ ./shells/*.sh have been "chmod +x ified"'
find ./shells -name "*.sh" -exec chmod +x {} \;
# find ./shells -name "*.sh" -exec echo '  - ' {} \;
./shells/docker-$1.sh d:$1 $2