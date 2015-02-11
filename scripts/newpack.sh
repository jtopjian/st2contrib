#!/usr/bin/env bash

PACKPATH=/opt/stackstorm/packs

if [ "${1}" == "" ]; then
  echo "Usage: newpack.sh <packname>"
  exit 1
fi

if [ -e "${PACKPATH}/${1}" ]; then
  echo "Pack already exists."
  exit 1
fi

mkdir ${PACKPATH}/${1}
cd "${PACKPATH}/${1}"
mkdir actions rules sensors etc

cat > pack.yaml <<EOF
---
name: ${1}
description: Add a description
keywords:
  - ${1}
version: 0.1
author: Your name
email: Your email
EOF

touch config.yaml

cat > actions/hello.yaml <<EOF
---
name: hello
runner_type: run-local
description: Demo action
enabled: true
entry_point: hello.sh
parameters: {}
EOF

cat > actions/hello.sh <<EOF
#!/usr/bin/env bash
echo "Hello from ${1}!"
EOF

echo ""
echo "Pack ${1} created."
echo ""
echo "To load your new pack, don't forget to run"
echo "st2 run packs.load"
