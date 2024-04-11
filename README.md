# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)


# CI/CD for Org Development Model

This is a sample sfdx project that showcases how to use Github Actions for CI/CD in an org development model (no packages, no scratch orgs).

Check out the `pr-develop-branch.yml` file under `.github/workflows` for a detailed explanation of the operations that are being automated.

## High level flow

**1-** We have a master branch that represents the metadata we are tracking.

**2-** At the beginning of a development sprint, we create a develop branch off of main, in the remote repository.  

**3-** Developers clone the repository (which is an sfdx project) to their local computer and authorize the project against their own sandbox (this is a one time step). This is an important and often overlooked feature of sfdx: you can authorize any sfdx project against any org, even if the project was created from a different org. 

**4-** Developers checkout the remote develop branch, and create a feature branch that corresponds to the bug or user story they are working on. 

**5-** Developers push their branch to the remote repository, and continue to push commits as they progress through the development process.

**6-** Once ready, the developer opens a pull request from the feature branch against the develop branch.

**7-** The pull request triggers a CI/CD job with Github Actions that will do the following:

Do a check-only deployment of only the new metadata or the existing metadata that has changed. This deployment will be against the qa/integration org. 

If the deployment passes, run the tests specified by the developer (explained below). 

Scan the apex code for any vulnerabilities or code smells. Log any issues directly in github.

**8-** If the CI/CD job completes successfully, then the feature branch can be merged into develop.

**9-** The feature branch is merged into develop, and this triggers an actual deployment of the metadata into the qa/integration org, and again runs the tests specified by the developer.

**10-** At the end of the sprint, the develop branch is merged into master, and this triggers a production deployment. 


## Deploying delta changes

We are `sfdx-git-delta` to only deploy the metadata that has been changed (or created) by the developer. 

If you want to deploy the entire branch, simply use the `deploy` command against the `force-app` directory.

## Specify which tests to run

We allow the developer to specify which tests to run by using a special syntax in the pull request body

`Apex::[Class1,Class2,Class3...]::Apex`

Read `pr-develop-branch.yml` for a detailed description of how this works.

## Static code analysis

We are using the `sfdx scanner` to scan the code in the delta directory. 

We decided not to fail the entire job just because there are warnings. Instead, the warnings are logged directly in the PR for your team to review. We think this is better than failing the job because it allows your team to review the code and have a conversation about it. If the same warning keeps showing up every now and then, then it might be worth to configure the job to fail.