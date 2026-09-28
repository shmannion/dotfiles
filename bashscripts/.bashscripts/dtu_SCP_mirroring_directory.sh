#!/usr/bin/env bash

set -e

# ----------------------------------------
# configuration
# ----------------------------------------

LOCAL_ROOT="$HOME/Desktop/postdoc"
REMOTE_ROOT="/zhome/cb/c/227890/projects"
REMOTE_USER="shman@login.hpc.dtu.dk"
SSH_KEY="$HOME/.ssh/dtuHPC"

# ----------------------------------------
# determine current directory
# ----------------------------------------

PWD_REAL="$(pwd -P)"

# make sure we're inside the project tree
case "$PWD_REAL" in
    "$LOCAL_ROOT"/*) ;;
    *)
        echo "Error: not inside $LOCAL_ROOT"
        exit 1
        ;;
esac

# ----------------------------------------
# compute relative path
# ----------------------------------------

REL_PATH="${PWD_REAL#$LOCAL_ROOT/}"

# ----------------------------------------
# determine filename
# ----------------------------------------

DIRNAME="$(basename "$PWD_REAL")"
FILENAME="${DIRNAME}.zip"

# ----------------------------------------
# build remote path
# ----------------------------------------

REMOTE_PATH="${REMOTE_ROOT}/${REL_PATH}/${FILENAME}"

# ----------------------------------------
# copy file
# ----------------------------------------

echo "Fetching:"
echo "  $REMOTE_USER:$REMOTE_PATH"
echo "→ $PWD_REAL"

scp -i "$SSH_KEY" \
    "${REMOTE_USER}:${REMOTE_PATH}" \
    .

