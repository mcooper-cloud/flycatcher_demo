
export_env(){

    export WORKING_DIR=$(pwd)
    export INFRA_PATH='infra/cf'
    export PARAM_PATH='params/cf'
    export REGION='us-east-1'

    export STACK_NAME="flycatcher-staging-bucket"
    export CF_TEMPLATE_PATH=$INFRA_PATH'/s3/bucket.json'
    export CF_PARAM_PATH=$PARAM_PATH'/staging_bucket_params.json'

}

export_env
