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

#AUTH0_CLIENT_ID_OUTPUT
#AUTH0_CLIENT_SECRET_OUTPUT
#AUTH0_DOMAIN_PARAM_OUTPUT

jq

AUTH0_CLIENT_ID_SM=$(echo $CF_JSON | jq -rc '.[] | select(.OutputKey=="${AUTH0_CLIENT_ID_OUTPUT}") | .OutputValue ')
echo $AUTH0_CLIENT_ID_SM

