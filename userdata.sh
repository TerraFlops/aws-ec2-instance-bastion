#!/usr/bin/env bash

echo Creating Authorized SSH Keys File...
cat <<EOF > /home/ubuntu/.ssh/authorized_keys
${authorized_keys}
EOF
cat /home/ubuntu/.ssh/authorized_keys