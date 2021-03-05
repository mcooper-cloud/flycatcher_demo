#!/bin/bash

echo "Exit status $?"
echo "[+] $(date) - Entered STAGE 1 PREBUILD - phase 3 build"

ENV_SH_PATH=$CODEBUILD_SRC_DIR/$ENV_PATH/$ENV_SH
source $ENV_SH_PATH


##############################################################################
##############################################################################
##
## deploy the Auth0 tenant
##
##############################################################################
##############################################################################


function auth0_deploy(){

    cd $AUTH0_DEPLOY_PATH

    export NODE_PATH=$(npm root -g)

    export INPUT_FOLDER="${AUTH0_TENANT_PATH}/${AUTH0_TENANT_YAML}"
    export BASE_PATH="a0deploy"

    echo "[+] Node version $(node --version)"
    echo "[+] NPM version $(npm --version)"
    npm start

}

get_stack_outputs
get_secrets_params

auth0_deploy
