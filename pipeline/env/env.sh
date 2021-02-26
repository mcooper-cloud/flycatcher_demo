#!/bin/bash

export_env(){

    echo "[+] $(date) - Exporting Global ENV"
    DATE_STRING=$(date | sed -e 's/ /_/g' | sed -e 's/:/_/g')
    export PHASE_START=$DATE_STRING
    echo "[+] $(date) PHASE_START: $PHASE_START"

#    export AUTH0_CLIENT_ID_NAME="Auth0ClientID"
#    export AUTH0_CLIENT_SECRET_NAME="Auth0ClientSecret"


    export STACK_NAME="flycatcher-cicd-pipeline"
    
    ##
    ## Cloudformation outputs used to dynamically retrieve Auth0 data
    ##
    export AUTH0_CLIENT_ID_OUTPUT="Auth0ClientIDARN"
    export AUTH0_CLIENT_SECRET_OUTPUT="Auth0ClientSecretARN"
    export AUTH0_DOMAIN_PARAM_OUTPUT="Auth0DomainParam"

}

export_env
