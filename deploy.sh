#!/bin/bash


##############################################################################
##############################################################################
##
## MAGIC NUMBERS
##
##############################################################################
##############################################################################


ARG_NUMBER=1


##############################################################################
##############################################################################
##
## USAGE
##
##############################################################################
##############################################################################


usage(){
    if [ $# -lt $ARG_NUMBER ]; then
        echo "Usage: "
        echo "$0 \ "
        echo "  --env-file [ENV_FILE_PATH] \ "
        exit 1
    fi
}


##############################################################################
##############################################################################
##
## PARSE ARGS
##
##############################################################################
##############################################################################


parse_args(){
    while [[ $# > 1 ]];
    do
        key="$1"

        case $key in
            --env-file)
            ENV_FILE="$2"
            shift # past argument
            ;;
            *)
            # unknown option
            ;;
        esac
        shift
    done
}


prep_logs(){

    ts=$(date +"%Y_%m_%d_%T" | sed -e 's/:/_/g')
    LP="${LOG_PATH}/${STACK_NAME}/${ts}"

    mkdir -p $LP

    VALIDATION_LOG="${LP}/template_validation.txt"
    EVENT_LOG="${LP}/event_log.txt"
    OUTPUT_LOG="${LP}/output_log.txt"

}

##############################################################################
##############################################################################
##
## VALIDATE
##
##############################################################################
##############################################################################

validate_template(){
    echo "[+] $(date) - Validating CloudFormation template ... $CF_TEMPLATE_PATH"
    echo "[+] $(date) - Writing validation log to ${VALIDATION_LOG}"
    aws cloudformation validate-template \
        --template-body 'file://'$CF_TEMPLATE_PATH \
        --region $REGION > $VALIDATION_LOG
}


##############################################################################
##############################################################################
##
## DEPLOY STACK
##
##############################################################################
##############################################################################


deploy_stack(){

    ##
    ## set CAPABILITY_NAMED_IAM to avoid possible
    ## failures if IAM resources need to be created ... this setting
    ## could be considered low security and removed if IAM resources
    ## are not needed (the intention here is to genearlize)
    ##
    ## and setting CAPABILITY_AUTO_EXPAND to support use of nested
    ## cloudformation modules
    ##

    echo "[+] $(date) - Deploying CloudFormation stack ... $STACK_NAME"
    aws cloudformation create-stack \
        --template-body 'file://'$CF_TEMPLATE_PATH \
        --parameter 'file://'$CF_PARAM_PATH \
        --stack-name $STACK_NAME \
        --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
        --region $REGION

}


##############################################################################
##############################################################################
##
## WAIT on STACK CREATE
##
##############################################################################
##############################################################################


wait_stack_create(){
    echo "[+] $(date) - Waiting for stack-create-complete ... $STACK_NAME"    
    aws cloudformation wait stack-create-complete \
        --stack-name $STACK_NAME \
        --region $REGION
}


##############################################################################
##############################################################################
##
## DESCRIBE EVENTS
##
##############################################################################
##############################################################################


describe_events(){
    echo "[+] $(date) - Describing stack events ... $STACK_NAME"
    echo "[+] $(date) - Writing event log to ${EVENT_LOG}"

    aws cloudformation describe-stack-events \
        --stack-name $STACK_NAME \
        --region $REGION > $EVENT_LOG
}

##############################################################################
##############################################################################
##
## GET STACK OUTPUTS
##
##############################################################################
##############################################################################


get_stack_outputs(){
    echo "[+] $(date) - Describing stack outputs ... $STACK_NAME"
    echo "[+] $(date) - Writing output log to ${OUTPUT_LOG}"

    aws cloudformation describe-stacks \
        --stack-name $STACK_NAME  \
        --query "Stacks[0].Outputs" \
        --region $REGION \
        --output json > $OUTPUT_LOG
}


##############################################################################
##############################################################################
##
## MAIN
##
##############################################################################
##############################################################################


main(){

    prep_logs

    if ! validate_template; then
        echo "[-] $(date) - Invalid CloudFormation template ... exiting"
        return 1
    else
        deploy_stack
        if ! wait_stack_create; then
            echo "[-] $(date) - Stack create failed ... "
            describe_events
            ##
            ## this scenario leaves an orphaned failed stack 
            ## either manually teardown, or run the teardown.sh
            ##
            return 1

        else
            echo "[+] $(date) - Stack create complete ... "
            describe_events
            get_stack_outputs
            echo "[+] $(date) - SUCCESS! Stack deployment complete."
            return 0
        fi
    fi
}


usage $@
parse_args $@

source $ENV_FILE
main

