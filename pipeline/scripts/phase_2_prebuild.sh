#!/bin/bash

echo "Exit status $?"
echo "[+] $(date) - Entered STAGE 1 PREBUILD - phase 2 prebuild"

ENV_SH_PATH=$CODEBUILD_SRC_DIR/$ENV_PATH/$ENV_SH
source $ENV_SH_PATH



CF_JSON=$(
    aws cloudformation describe-stacks \
        --stack-name $STACK_NAME  \
        --query "Stacks[0].Outputs" \
        --output json
)

echo $CF_JSON