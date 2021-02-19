
export_env(){

    export WORKING_DIR=$(pwd)
    export INFRA_PATH='infra/cf'
    export PARAM_PATH='params/cf'
    export REGION='us-east-1'

    export STACK_NAME="flycatcher-cicd-pipeline"
    export CF_TEMPLATE_PATH=$INFRA_PATH'/pipeline/pipeline.json'
    export CF_PARAM_PATH=$PARAM_PATH'/cloud_pipeline_params.json'

}

export_env
