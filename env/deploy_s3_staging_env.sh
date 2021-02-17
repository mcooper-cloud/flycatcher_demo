
export_env(){

    export WORKING_DIR=$(pwd)
    export INFRA_PATH='infra/cf'
    export PARAM_PATH='params/cf'

    export STACK_NAME="flycatcher_staging_bucket"
    export CF_TEMPLATE_PATH=$INFRA_PATH'/s3/bucket.json'
    export CF_PARAMS_PATH=$PARAM_PATH'/staging_bucket_params.json'

}

export_env
