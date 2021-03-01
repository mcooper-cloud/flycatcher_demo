#!/bin/bash

echo "Exit status $?"
echo "[+] $(date) - Entered STAGE 1 PREBUILD - phase 1 install"

ENV_SH_PATH=$CODEBUILD_SRC_DIR/$ENV_PATH/$ENV_SH
source $ENV_SH_PATH

npm i -g auth0-deploy-cli
