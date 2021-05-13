
export_env(){

    ##########################################################################
    ##########################################################################
    ##
    ## customize these lines
    ##
    ##########################################################################
    ##########################################################################


    export STACK_NAME="{{ PipelineStackName }}"
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
    export CF_TEMPLATE_PATH=$INFRA_PATH'/pipeline/pipeline.json'
    export CF_PARAM_PATH=$PARAM_PATH'/pipeline_params.json'
    export LOG_PATH=$WORKING_DIR'/logs/'

}

export_env
