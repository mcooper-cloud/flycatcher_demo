
export_env(){

    ##########################################################################
    ##########################################################################
    ##
    ## customize these lines
    ##
    ##########################################################################
    ##########################################################################


    export STACK_NAME="flycatcher-cicd-pipeline"
    export REGION='us-east-1'


    ##########################################################################
    ##########################################################################
    ##
    ## DO NOT customize these lines
    ##
    ##########################################################################
    ##########################################################################


    export WORKING_DIR=$(pwd)
    export INFRA_PATH='infra/cf'
    export PARAM_PATH='infra/cf/params'
    export CF_TEMPLATE_PATH=$INFRA_PATH'/pipeline/pipeline.json'
    export CF_PARAM_PATH=$PARAM_PATH'/cloud_pipeline_params.json'

}

export_env
