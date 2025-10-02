#!/bin/bash

echo "Enabling sstate mirror"
mkdir ~/.egfautoconf
cat > ~/.egfautoconf/auto.conf << EOF
SSTATE_MIRRORS = "file://.* file://$1/PATH"
BB_SIGNATURE_HANDLER = "OEBasicHash"
BB_HASHSERVE = ""
EOF

exec /bin/bash