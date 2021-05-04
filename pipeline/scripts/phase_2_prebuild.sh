#!/bin/bash

echo "Exit status $?"
echo "[+] $(date) - Entered STAGE 1 PREBUILD - phase 2 prebuild"

ENV_SH_PATH=$CODEBUILD_SRC_DIR/$ENV_PATH/$ENV_SH
source $ENV_SH_PATH


##############################################################################
##############################################################################
##
## export the Auth0 tenant data and store in S3 staging bucket
##
##############################################################################
##############################################################################


function auth0_export(){

    cd $AUTH0_EXPORT_PATH

    export NODE_PATH=$(npm root -g)
    export OUTPUT_FOLDER="./a0export"
    export BASE_PATH="a0export"

    ts=$(date +"%Y_%m_%d_%T" | sed -e 's/:/_/g')
    ZIP_PACKAGE_NAME="${ts}_a0export.zip"

    echo "[+] Node version $(node --version)"
    echo "[+] NPM version $(npm --version)"
    npm start

    zip -r $ZIP_PACKAGE_NAME $OUTPUT_FOLDER 

    aws s3api put-object \
        --bucket $STAGING_BUCKET_NAME \
        --key $STAGING_BUCKET_EXPORT_PATH/$ZIP_PACKAGE_NAME \
        --body $ZIP_PACKAGE_NAME

}

main(){
    get_stack_outputs
    get_secrets_params
    auth0_export

    ls -lah
}

#main