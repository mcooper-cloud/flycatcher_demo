# Flycatcher Demo

This repository contains a simple cloud deployment demo that walks through the orchestration of application development using various cloud resources and methods. YMMV

# Basic Principles

1. Keep variables (parameters) out of source code to the greatest extent possible
2. Everything as code
3. Scalable, Secure, Resilient, Durable, Frugal
4. Points for readability and style
5. n+1 > n

# Field Map

As a matter of best (better) practice, this demo includes some arbitrary fields that are included to help categorize and track the resources as they are created:

- **EnvironmentName**: category that can be used to match whatever evnironments your entprise utilizes (I.E. dev/test/prod, etc)

- **ProjectName**: an arbitrary name of the effort (helps when performing filtered API based searches for resources)

- **SystemNumber**: a common method for tracking chargeback and financial accounting

- **Domain**: this will be used to help in naming resources using standard URL/I naming convention

- **Prefix**: in conjunction with Domain, used for name formatting

# Components

Some resources included in this demo may not be necessary for all use cases.

## S3 Staging Bucket

This resource is provisioned for the purpose of general storage such as build & application logs, source code staging, application output and many other uses.

To deploy the S3 staging bucket:

1. customize `env/cf/s3_staging_bucket_env.sh`
2. customize `params/cf/s3_staging_bucket_params.json`

Then run the command:

    ./deploy.sh --env-file env/cf/s3_staging_bucket_env.sh

This will result in a new Cloudformation stack with the given name that you configured in the STACK_NAME environment variable.

# Requirements

1. AWS Account: [Sign Up for AWS](https://portal.aws.amazon.com/billing/signup#/start)
2. AWS CLI: [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
3. Auth0 Account: [Sign Up for Auth0](https://auth0.com/signup)
