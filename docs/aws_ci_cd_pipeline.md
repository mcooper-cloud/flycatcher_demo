# CI/CD Pipeline using AWS Developer Tools

This demo utilizes AWS CodePipeline and AWS CodeBuild to build a demo application based on configuration stored in a Github repository.  This requires a few key components to work (well):

1. A couple IAM roles that provide necessary permissions for AWS CodePipeline and AWS CodeBuild to interact with different AWS services
2. A CodePipeline configuration; in this case consisting of a source stage that will listen for changes to a particular branch within a particular Github repo
3. A CodeBuild project that will be triggered by the CodePipeline when a change is made to the Github repo
4. AWS Secrets Manager values for the purpose of storing all the different sensitive secrets and keys that we may need
5. An AWS CodeStar Connection that provides OAuth authentication between your AWS account and your Github repo

To deploy the CI/CD pipeline:

1. customize `env/cf/cloud_pipeline_env.sh`
2. customize `params/cf/cloud_pipeline_params.json`

Then run the command:

    ./deploy.sh --env-file env/cf/cloud_pipeline_bucket_env.sh

This will result in a new Cloudformation stack with the given name that you configured in the STACK_NAME environment variable.
