#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$REMOTE_CMD rm $OASIS_NODE_DIR/service_disable 2>/dev/null || true
$REMOTE_CMD systemctl --user daemon-reload 
$REMOTE_CMD loginctl enable-linger
$REMOTE_CMD systemctl --user start oasis_$OASIS_NODE_NAME.service


