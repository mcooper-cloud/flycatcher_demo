
export_env(){

    ##########################################################################
    ##########################################################################
    ##
    ## customize these lines
    ##
    ##########################################################################
    ##########################################################################


    export STACK_NAME="{{ StagingStackName }}"
    export REGION='{{ Region }}'


    ##########################################################################
    ##########################################################################
    ##
    ## DO NOT customize these lines
    ##
    ##########################################################################
    ##########################################################################


    export WORKING_DIR=$(pwd)
    export INFRA_PATH='infra/aws'
    export PARAM_PATH='infra/aws/params'
    export CF_TEMPLATE_PATH=$INFRA_PATH'/s3/bucket.json'
    export CF_PARAM_PATH=$PARAM_PATH'/staging_params.json'
    export LOG_PATH=$WORKING_DIR'/logs/'

}

export_env
