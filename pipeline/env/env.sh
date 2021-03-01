#!/bin/bash

function export_env(){

    echo "[+] $(date) - Exporting Global ENV"
    DATE_STRING=$(date | sed -e 's/ /_/g' | sed -e 's/:/_/g')
    export PHASE_START=$DATE_STRING
    echo "[+] $(date) PHASE_START: $PHASE_START"

    export STACK_NAME="flycatcher-cicd-pipeline"
    export STAGING_STACK_NAME="flycatcher-staging-bucket"

    ##
    ## Cloudformation outputs used to dynamically retrieve Auth0 data
    ##
    export AUTH0_CLIENT_ID_OUTPUT="Auth0ClientIDARN"
    export AUTH0_CLIENT_SECRET_OUTPUT="Auth0ClientSecretARN"
    export AUTH0_DOMAIN_PARAM_OUTPUT="Auth0DomainParam"

    ##
    ## path related
    ##
    export AUTH0_EXPORT_PATH=infra/auth0/export
    export AUTH0_DEPLOY_PATH=infra/auth0/deploy

    export AUTH0_TENANT_PATH=../tenant
    export AUTH0_TENANT_YAML="tenant.yaml"

    export STAGING_BUCKET_NAME_OUTPUT="BucketName"
    export STAGING_BUCKET_EXPORT_PATH="a0export"
}

function get_secret(){
    local value=$(aws secretsmanager get-secret-value --secret-id $1 --query SecretString --output text)
    export $2=$value
}

function get_parameter(){
    local value=$(aws ssm get-parameter --name $1 --query Parameter.Value --output text)
    export $2=$value
}

export_env
