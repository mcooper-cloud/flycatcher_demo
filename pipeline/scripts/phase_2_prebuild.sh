#!/bin/bash

echo "Exit status $?"
echo "[+] $(date) - Entered STAGE 1 PREBUILD - phase 2 prebuild"

ENV_SH_PATH=$CODEBUILD_SRC_DIR/$ENV_PATH/$ENV_SH
source $ENV_SH_PATH


get_cf_outputs(){
    export CF_JSON=$(
        aws cloudformation describe-stacks \
            --stack-name ${STACK_NAME}  \
            --query "Stacks[0].Outputs" \
            --output json
    )

    echo "[+] Cloudformation outputs"
    echo ${CF_JSON} | jq -rc '.[]'

    export AUTH0_CLIENT_ID_SM=$(echo ${CF_JSON} | jq --arg VAR ${AUTH0_CLIENT_ID_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')
    export AUTH0_CLIENT_SECRET_SM=$(echo ${CF_JSON} | jq --arg VAR ${AUTH0_CLIENT_SECRET_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')
    export AUTH0_DOMAIN_PARAM=$(echo ${CF_JSON} | jq --arg VAR ${AUTH0_DOMAIN_PARAM_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')

}

get_cf_outputs

get_secret $AUTH0_CLIENT_ID_SM AUTH0_CLIENT_ID
echo "[+] Auth0 Client ID: ${AUTH0_CLIENT_ID}"

get_secret $AUTH0_CLIENT_SECRETE_SM AUTH0_CLIENT_SECRET
echo "[+] Auth0 Client Secret: ******"

get_param $AUTH0_DOMAIN_PARAM AUTH0_DOMAIN
echo "[+] Auth0 Domain: ${AUTH0_DOMAIN}"
