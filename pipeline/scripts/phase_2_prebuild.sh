#!/bin/bash

echo "Exit status $?"
echo "[+] $(date) - Entered STAGE 1 PREBUILD - phase 2 prebuild"

ENV_SH_PATH=$CODEBUILD_SRC_DIR/$ENV_PATH/$ENV_SH
source $ENV_SH_PATH


##############################################################################
##############################################################################
##
## get outputs from cloudformation stacks
##
##############################################################################
##############################################################################

function get_stack_outputs(){

#    export CF_JSON=$(
#        aws cloudformation describe-stacks \
#            --stack-name ${STACK_NAME}  \
#            --query "Stacks[0].Outputs" \
#            --output json
#    )


    ##
    ## Pipeline stack outputs
    ## ... this is where we'll get Auth0 variables
    ##
    get_cf_outputs ${STACK_NAME} STACK_JSON

    echo "[+] Cloudformation outputs for ${STACK_NAME}"
    echo ${STACK_JSON} | jq -rc '.[]'

    export AUTH0_CLIENT_ID_SM=$(echo ${STACK_JSON} | jq --arg VAR ${AUTH0_CLIENT_ID_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')
    export AUTH0_CLIENT_SECRET_SM=$(echo ${STACK_JSON} | jq --arg VAR ${AUTH0_CLIENT_SECRET_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')
    export AUTH0_DOMAIN_PARAM=$(echo ${STACK_JSON} | jq --arg VAR ${AUTH0_DOMAIN_PARAM_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')

    ##
    ## staging bucket stack outputs
    ## ... this is where we'll get the bucket name
    ##
    get_cf_outputs ${STAGING_STACK_NAME} STAGING_STACK_JSON

    echo "[+] Cloudformation outputs for ${STAGING_STACK_NAME}"
    echo ${STAGING_STACK_JSON} | jq -rc '.[]'
    export STAGING_BUCKET_NAME=$(echo ${STAGING_STACK_JSON} | jq --arg VAR ${STAGING_BUCKET_NAME_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')

}


##############################################################################
##############################################################################
##
## get Secrets Manager and SSM Parameter Store values
##
##############################################################################
##############################################################################


function get_secrets_params(){
    get_secret $AUTH0_CLIENT_ID_SM AUTH0_CLIENT_ID
    echo "[+] Auth0 Client ID: ${AUTH0_CLIENT_ID}"

    get_secret $AUTH0_CLIENT_SECRET_SM AUTH0_CLIENT_SECRET
    echo "[+] Auth0 Client Secret: ******"

    get_parameter $AUTH0_DOMAIN_PARAM AUTH0_DOMAIN
    echo "[+] Auth0 Domain: ${AUTH0_DOMAIN}"
}


##############################################################################
##############################################################################
##
## export the Auth0 tenant data
##
##############################################################################
##############################################################################


function auth0_export(){

    cd $AUTH0_EXPORT_PATH

    export NODE_PATH=$(npm root -g)
    export OUTPUT_FOLDER="./a0export"
    export BASE_PATH="a0export"

    echo "[+] Node version $(node --version)"
    echo "[+] NPM version $(npm --version)"
    npm start

}

get_stack_outputs
get_secrets_params
auth0_export

ls -lah
