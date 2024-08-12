# Terraform and AWS Using GitHub Actions

This project utilizes Terraform to provision AWS infrastructure all via GitHub Actions (CI/CD). You can supply inputs in order to configure the AWS services that will be created.

## Project Structure

### Terraform Modules
The `modules` directory contains terraform modules for the AWS services (e.g., AWS S3 and AWS ECR).

### Pipelines
The `.github/workflows` directory contains the configuration for the pipeline(s)

### Root directory
The root directory of this project contains files that create the the infrastructure using the `modules`.

## Assumptions
The following assumptions suffice for this project to run smoothly:
1. Remote State
    
    You have created a terraform state bucket outside of this project, and that you have supplied the bucket info in the file `./backend.tfvars.ghactions`. For example, I have created a bucket in AWS S3 for that purpose and passed in the values:
    ```
    bucket="ileri-tf-state"
    key="tfstate"
    region="eu-central-1"
    ```

2. GitHub Repository Secrets
    In order for the project to authenticate with your GitHub repository as well as AWS, you must have created and stored a GitHub Token as well as AWS Access keys in GitHub Repository secrets. These values are set as environment variables in `.github/workflows/**.yaml`:
    ```
    GITHUB_TOKEN: ${{ secrets.GH_TOKEN }}
    AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
    AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    ```

## Running the project
1. Fork this repository.
2. Set the relevant secrets (as mentioned above) in the GitHub repository settings.
3. Supply some input and trigger the pipeline under the `Actions` tab in GitHub
