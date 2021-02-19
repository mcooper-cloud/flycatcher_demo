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

A note on DevOps and automation ... there is a bit of "chicken or the egg" dilemma at play here, and it plays out as such:

1. This demonstration will utilize automation as much as possible to ensure that deployments are testable, standardized and repeatable
    a. to accomplish this we will utilize pipeline tools to the greatest extent possible
    b. however, given that we are not assuming these tools already exist, we'll need to use local development tools (I.E. the local commandline) to deploy these pipeline tools.
    c. and the catch-22 to statement (b.) is that working from a developer's laptop can introduce human error,  non-repeatable processes and general instability.

Now, if you're working with a large enterprise, or in an established devlopment environment, there may be pipeline tools in place that can offload this task from the developer.  If that is the case, then it is recommended that you utilize those tools, rather than working from your laptop.  

Regardless, this demonstration is making the assumption that the developer is working from a pritine environment, and has none of those tools available.  For that reason, the first 2 stages will be accomplished from the developer's laptop.  After that, pipeline tools take over.

Additionally, this demonstration will also highlight any manual steps that need to be taken (with the explicit goal of reducing these to zero)

    Step 1: (implied) Clone this repo
    Step 2: (from the developer's laptop) [Deploy an S3 Staging Bucket](docs/s3_staging.md)
    Step 3 (AWS): (from the developer's laptop) [Deploy a CI/CD pipeline using AWS Developer Tools](docs/aws_ci_cd_pipeline.md)
    Step 4 (AWS): (manual process) [Update the CodeStar Connection Status](https://docs.aws.amazon.com/dtconsole/latest/userguide/connections-update.html)


# Requirements

1. AWS Account: [Sign Up for AWS](https://portal.aws.amazon.com/billing/signup#/start)
2. AWS CLI: [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
3. Auth0 Account: [Sign Up for Auth0](https://auth0.com/signup)
