#!/bin/bash

echo "Exit status $?"
echo "[+] $(date) - Entered STAGE 1 PREBUILD - phase 2 prebuild"

ENV_SH_PATH=$CODEBUILD_SRC_DIR/$ENV_PATH/$ENV_SH
source $ENV_SH_PATH

CF_JSON=$(
    aws cloudformation describe-stacks \
        --stack-name ${STACK_NAME}  \
        --query "Stacks[0].Outputs" \
        --output json
)

AUTH0_CLIENT_ID_SM=$(echo ${JSON_DATA} | jq --arg VAR ${AUTH0_CLIENT_ID_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')
echo $AUTH0_CLIENT_ID_SM

AUTH0_CLIENT_SECRET_SM=$(echo ${JSON_DATA} | jq --arg VAR ${AUTH0_CLIENT_SECRET_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')
echo $AUTH0_CLIENT_SECRET_SM

AUTH0_DOMAIN_PARAM=$(echo ${JSON_DATA} | jq --arg VAR ${AUTH0_DOMAIN_PARAM_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')
echo $AUTH0_DOMAIN_PARAM
