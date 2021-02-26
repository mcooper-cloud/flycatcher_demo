#!/bin/bash

export_env(){

    echo "[+] $(date) - Exporting Global ENV"
    DATE_STRING=$(date | sed -e 's/ /_/g' | sed -e 's/:/_/g')
    export PHASE_START=$DATE_STRING
    echo "[+] $(date) PHASE_START: $PHASE_START"

    export STACK_NAME="flycatcher-cicd-pipeline"

    ##
    ## Cloudformation outputs used to dynamically retrieve Auth0 data
    ##
    export AUTH0_CLIENT_ID_OUTPUT="Auth0ClientIDARN"
    export AUTH0_CLIENT_SECRET_OUTPUT="Auth0ClientSecretARN"
    export AUTH0_DOMAIN_PARAM_OUTPUT="Auth0DomainParam"

}

function get_secret(){
    local __returnvar=$2
    local value=$(aws secretsmanager get-secret-value --secret-id $1 --query SecretString --output text)
    eval $__returnvar="'$value'"
}

function get_parameter(){
    local __returnvar=$2
    local value=$(aws ssm get-parameter --name $1 --query Parameter.Value --output text)
    eval $__returnvar="${value}"
}

export_env
