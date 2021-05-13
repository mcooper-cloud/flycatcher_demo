#!/bin/bash

function export_env(){

    echo "[+] $(date) - Exporting Global ENV"
    DATE_STRING=$(date | sed -e 's/ /_/g' | sed -e 's/:/_/g')
    export PHASE_START=$DATE_STRING
    echo "[+] $(date) PHASE_START: $PHASE_START"

    export CONFIG_PATH="config/config.conf"

    ##
    ## config will run first, and the Jinja values below will
    ## change and be written to place.  Directly modifying this
    ## file should be avoided.
    ##

    export PIPELINE_STACK_NAME="{{ PipelineStackName }}"
    export STAGING_STACK_NAME="{{ StagingStackName }}"
    export APP_STACK_NAME="{{ AppStackName }}"

    ##
    ## env paths
    ##
    export PIPELINE_ENV_PATH={{ PipelineEnvPath }}
    export STAGING_ENV_PATH={{ StagingEnvPath }}
    export APP_ENV_PATH={{ AppEnvPath }}

    ##
    ## Auth0 paths
    ##
    export AUTH0_EXPORT_PATH={{ Auth0ExportPath }}
    export AUTH0_DEPLOY_PATH={{ Auth0MGMTPath }}
    export AUTH0_TENANT_PATH={{ Auth0TenantPath }}
    export AUTH0_TENANT_YAML={{ Auth0TenantYAML }}

    ##
    ## application paths
    ##
    export WEB_APP_PATH={{ WebAppBuildPath }}
    export WEB_API_PATH={{ WebAPIBuildPath }}

    ##
    ## general stack output variable names
    ##
    export PROJECT_NAME_OUTPUT="ProjectName"
    export ENVIRONMENT_OUTPUT="EnvironmentName"
    export SYSTEM_NUMBER_OUTPUT="SystemNumber"

    ##
    ## Cloudformation outputs used to dynamically retrieve Auth0 
    ## data from cloud secrets management and parameter storage
    ##
    export AUTH0_CLIENT_ID_OUTPUT="Auth0MGMTClientIDARN"
    export AUTH0_CLIENT_SECRET_OUTPUT="Auth0MGMTClientSecretARN"
    export AUTH0_DOMAIN_PARAM_OUTPUT="Auth0DomainParam"
    export AUTH0_MGMT_API_ENDPOINT_OUTPUT="Auth0MgmtAPIEndpointParam"

    export STAGING_BUCKET_NAME_OUTPUT="BucketName"
    export STAGING_BUCKET_EXPORT_PATH="a0export"

}

##############################################################################
##############################################################################
##
## generic get outputs from cloudformation stacks
##
##############################################################################
##############################################################################


function get_cf_outputs(){
    CF_JSON=$(
        aws cloudformation describe-stacks \
            --stack-name $1  \
            --query "Stacks[0].Outputs" \
            --output json
    )
}


##############################################################################
##############################################################################
##
## get outputs from cloudformation stacks
##
##############################################################################
##############################################################################


function get_stack_outputs(){

    ##
    ## Pipeline stack outputs
    ## ... this is where we'll get Auth0 variables
    ##
    get_cf_outputs $PIPELINE_STACK_NAME

    echo "[+] Cloudformation outputs for ${STACK_NAME}"
    echo ${CF_JSON} | jq -rc '.[]'

    export AUTH0_CLIENT_ID_SM=$(echo ${CF_JSON} | jq --arg VAR ${AUTH0_CLIENT_ID_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')
    export AUTH0_CLIENT_SECRET_SM=$(echo ${CF_JSON} | jq --arg VAR ${AUTH0_CLIENT_SECRET_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')
    export AUTH0_DOMAIN_PARAM=$(echo ${CF_JSON} | jq --arg VAR ${AUTH0_DOMAIN_PARAM_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')
    export AUTH0_MGMT_API_ENDPOINT_PARAM=$(echo ${CF_JSON} | jq --arg VAR ${AUTH0_MGMT_API_ENDPOINT_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')

    export PROJECT_NAME=$(echo ${CF_JSON} | jq --arg VAR ${PROJECT_NAME_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')
    export ENVIRONMENT=$(echo ${CF_JSON} | jq --arg VAR ${ENVIRONMENT_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')
    export SYSTEM_NUMBER=$(echo ${CF_JSON} | jq --arg VAR ${SYSTEM_NUMBER_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')

    ##
    ## staging bucket stack outputs
    ## ... this is where we'll get the bucket name
    ##
    get_cf_outputs $STAGING_STACK_NAME

    echo "[+] Cloudformation outputs for ${STAGING_STACK_NAME}"
    export STAGING_BUCKET_NAME=$(echo ${CF_JSON} | jq --arg VAR ${STAGING_BUCKET_NAME_OUTPUT} -rc '.[] | select(.OutputKey==$VAR) | .OutputValue')

}


##############################################################################
##############################################################################
##
## generic get secrets from AWS Secrets Manager
##
##############################################################################
##############################################################################


function get_secret(){
    local value=$(aws secretsmanager get-secret-value --secret-id $1 --query SecretString --output text)
    export $2=$value
}


##############################################################################
##############################################################################
##
## generic get parameter from AWS SSM Parameter Store
##
##############################################################################
##############################################################################


function get_parameter(){
    local value=$(aws ssm get-parameter --name $1 --query Parameter.Value --output text)
    export $2=$value
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
    echo "[+] Auth0 Client Secret: ********$(echo ${AUTH0_CLIENT_SECRET} | grep -o '....$')"

    get_parameter $AUTH0_DOMAIN_PARAM AUTH0_DOMAIN
    echo "[+] Auth0 Domain: ${AUTH0_DOMAIN}"

    get_parameter $AUTH0_MGMT_API_ENDPOINT_PARAM AUTH0_MGMT_API_ENDPOINT
    echo "[+] Auth0 Management API Endpoint: ${AUTH0_MGMT_API_ENDPOINT}"

    export AUTH0_SUBDOMAIN=$(echo ${AUTH0_DOMAIN} | cut -d'.' -f1)
    echo "[+] Auth0 Subdomain: ${AUTH0_SUBDOMAIN}"
}


##############################################################################
##############################################################################
##
## sync local directory w/ S3 path
##
##############################################################################
##############################################################################


function s3_sync(){

    LOCAL_DIR=$1
    BUCKET=$2
    S3_PATH=$3

    aws s3 sync ${LOCAL_DIR} s3://${BUCKET}/${S3_PATH}

}

export_env
