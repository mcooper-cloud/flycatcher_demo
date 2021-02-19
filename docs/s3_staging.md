# S3 Staging Bucket

This resource is provisioned for the purpose of general storage such as build & application logs, source code staging, application output and many other uses.

To deploy the S3 staging bucket:

1. customize `env/cf/s3_staging_bucket_env.sh`
2. customize `params/cf/s3_staging_bucket_params.json`

Then run the command:

    ./deploy.sh --env-file env/cf/s3_staging_bucket_env.sh

This will result in a new Cloudformation stack with the given name that you configured in the STACK_NAME environment variable.

