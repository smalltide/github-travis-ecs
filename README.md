# github-travis-ecs
Use github and travis-ci to build docker image and push to AWS ECR, then use AWS ECS Cluster to run container service.

### Skills
1. GitHub
2. Travis CI
3. Docker
4. AWS
5. AWS ECR
6. AWS ECS
7. AWS Btch
8. AWS CloudWatch
9. AWS Lambda
10. AWS S3

### AWS Environment Config Task List
- [x] AWS EC2 create Key Pairs for EC2 ssh login
- [x] AWS VPC create Security Group
- [x] AWS EC2 create Load Balancer
- [x] AWS IAM Role create ap-ecsInstanceRole (for EC2)
- [x] AWS IAM Role create ap-ecsServiceRole (for ECS)
- [x] AWS IAM Role create ap-ecsEventsRole (for ECS Scheduled)
- [x] AWS IAM Role create ap-batchServiceRole (for Batch)
- [x] AWS IAM Role create ap-lambdaBatchRole (for Lambda)
- [x] AWS ECR create AP Image Repository
### AWS ECS Environment Config Task List
- [x] AWS ECS create AP Cluster
- [x] AWS S3 upload ECS cluster config (for ECS)
- [x] AWS EC2 create 3 instance for ECS cluster (for ECS)
### AWS Batch Environment Config Task List
- [x] AWS Batch create Compute Environment (for Batch)
- [x] AWS Batch create Job Queue (for Batch)
### Local Dev Task List
- [x] Python Image Dcokerfile
- [x] Local Test Build AP Docker Image
- [x] Local Test Run AP Docker Image
- [x] Push AP Image to ECR
- [x] AWS Batch CLI create AP Job Definition
- [x] AWS Batch CLI schedule AP Job into Job Queue
- [x] AWS ECS CLI create AP Task Definition
- [x] AWS ECS CLI run-task to run container
- [x] AWS ECS CLI create-service to run container
- [x] AWS ECS CLI update-service to re-run container
### AWS Lambda Trigger Cronjob
- [x] CloudWatch schedule event config(cron)
- [x] AWS Lambda trigger AP Cron Job
### AWS CloudFormation Build AP Environment 
- [x] AWS CloudFormation create AP Compute Environments and AP Job Queues
- [x] AWS CloudFormation create AWS Lambda to Trigger AP Batch Job
- [x] AWS CloudFormation create AP Job Definitions

### Travis CI Task List
- [ ] Integration Github and Travis CI, use .travis.yml 
- [ ] Push AP to GitHub
- [ ] Travis CI build AP Docker Image
- [ ] Travis CI push AP Docker Image to AWS ECR
### Travis CD Task List (Lambda Trigger Batch)
- [ ] AWS CLI CloudFormation create AP Job Definitions
### Travis CD Task List (ECS)
- [ ] AWS CLI CloudFormation create AP Job Definitions

## AWS Environment Config Task List
- [x] AWS EC2 create Key Pairs for EC2 ssh login
- [x] AWS VPC create Security Group
- [x] AWS EC2 create Load Balancer
- [x] AWS IAM Role create ap-ecsInstanceRole (for EC2)
- [x] AWS IAM Role create ap-ecsServiceRole (for ECS)
- [x] AWS IAM Role create ap-ecsEventsRole (for ECS Scheduled)
- [x] AWS IAM Role create ap-batchServiceRole (for Batch)
- [x] AWS IAM Role create ap-lambdaBatchRole (for Lambda)
- [x] AWS ECR create AP Image Repository

AWS EC2 create Key Pairs for EC2 ssh login
```
  > aws ec2 create-key-pair --key-name aws-ap --query 'KeyMaterial' --output text > ~/.ssh/aws-ap.pem
  > chmod 400 ~/.ssh/aws-ap.pem
```
AWS VPC create Security Group
```
  > aws ec2 create-security-group --group-name ap_sg_ap-northeast-1 --description "security group for AP on ap-northeast-1"
```
AWS EC2 create Load Balancer
```
  > cd env
  > aws elb create-load-balancer --cli-input-json file://ap-load-balancer.json
```
AWS IAM Role create ap-ecsInstanceRole (for EC2)
```
  > cd env
  > aws iam create-role --role-name ap-ecsInstanceRole --description ap-ecsInstanceRole --assume-role-policy-document file://ec2-role.json
  > aws iam attach-role-policy --role-name ap-ecsInstanceRole --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role
  > aws iam attach-role-policy --role-name ap-ecsInstanceRole --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
  > aws iam create-instance-profile --instance-profile-name ap-ecsInstanceRole
  > aws iam add-role-to-instance-profile --role-name ap-ecsInstanceRole --instance-profile-name ap-ecsInstanceRole
```
AWS IAM Role create ap-ecsServiceRole (for ECS)
```
  > cd env
  > aws iam create-role --role-name ap-ecsServiceRole --description ap-ecsServiceRole --assume-role-policy-document file://ecs-role.json
  > aws iam attach-role-policy --role-name ap-ecsServiceRole --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole
```
AWS IAM Role create ap-ecsEventsRole (for ECS Scheduled)
```
  > cd env
  > aws iam create-role --role-name ap-ecsEventsRole --description ap-ecsEventsRole --assume-role-policy-document file://ecs-events-role.json
  > aws iam attach-role-policy --role-name ap-ecsEventsRole --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceEventsRole
```
AWS IAM Role create ap-batchServiceRole (for Batch)
```
  > cd env
  > aws iam create-role --role-name ap-batchServiceRole --description ap-batchServiceRole --assume-role-policy-document file://batch-role.json
  > aws iam attach-role-policy --role-name ap-batchServiceRole --policy-arn arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole
```
AWS IAM Role create ap-lambdaBatchRole (for Lambda)
```
  > cd env
  > aws iam create-role --role-name ap-lambdaBatchRole --description ap-lambdaBatchRole --assume-role-policy-document file://lambda-batch-role.json
  > aws iam attach-role-policy --role-name ap-lambdaBatchRole --policy-arn arn:aws:iam::aws:policy/AWSBatchFullAccess
  > aws iam attach-role-policy --role-name ap-lambdaBatchRole --policy-arn arn:aws:iam::aws:policy/CloudWatchLogsFullAccess
```
AWS ECR create AP Image Repository
```
  > eval "$(aws ecr get-login --no-include-email)"
  > aws ecr create-repository --repository-name ap/ap0001
```

## AWS ECS Environment Config Task List
- [x] AWS ECS create AP Cluster (for ECS)
- [x] AWS S3 upload ECS cluster config (for ECS)
- [x] AWS EC2 create 3 instance for ECS cluster (for ECS)

AWS ECS create AP Cluster (for ECS)
```
  > aws ecs create-cluster --cluster-name ap
```
AWS S3 upload ECS cluster config (for ECS)
```
  > cd env
  > aws s3api create-bucket --bucket ap-cluster --region ap-northeast-1 --create-bucket-configuration LocationConstraint=ap-northeast-1
  > aws s3 cp ecs.config s3://ap-cluster/ecs.config
```
AWS EC2 create 3 instance for ECS cluster (for ECS)
```
  > cd env
  > aws ec2 run-instances --cli-input-json file://ap-ecs-cluster.json --user-data file://copy-ecs-config-from-s3
```

## AWS Batch Environment Config Task List
- [x] AWS Batch create Compute Environment (for Batch)
- [x] AWS Batch create Job Queue (for Batch)

AWS Batch create Compute Environment (for Batch)
```
  > cd env
  > aws batch create-compute-environment --cli-input-json file://ap-compute-environment.json
```
AWS Batch create Job Queue (for Batch)
```
  > cd env
  > aws batch create-job-queue --cli-input-json file://ap-queue.json
```

## Local Dev Task List
- [x] Python Image Dcokerfile
- [x] Local Test Build AP Docker Image
- [x] Local Test Run AP Docker Image
- [x] Push AP Image to ECR
- [x] AWS Batch CLI create AP Job Definition
- [x] AWS Batch CLI schedule AP Job into Job Queue
- [x] AWS ECS CLI create AP Task Definition
- [x] AWS ECS CLI run-task to run container
- [x] AWS ECS CLI create-service to run container
- [x] AWS ECS CLI update-service to re-run container

Local Test Build AP Docker Image
```
  > cd github-travis-ecs
  > docker build -t ap/ap0001 .
```
Local Test Run AP Docker Image
```
  > docker run --rm ap/ap0001
```
Push AP Image to ECR
```
  > eval $(aws ecr get-login --no-include-email --region ap-northeast-1)
  > docker tag ap/ap0001:latest 282921537141.dkr.ecr.ap-northeast-1.amazonaws.com/ap/ap0001:latest
  > docker push 282921537141.dkr.ecr.ap-northeast-1.amazonaws.com/ap/ap0001:latest
```
AWS Batch CLI create AP Job Definition
```
  > cd github-travis-ecs 
  > aws batch register-job-definition --cli-input-json file://definition.json
```
AWS Batch CLI schedule AP Job into Job Queue
```
  > cd github-travis-ecs 
  > aws batch submit-job --cli-input-json file://job.json
```
AWS ECS CLI create AP Task Definition
```
  > cd github-travis-ecs 
  > aws ecs register-task-definition --cli-input-json file://ecs-definition.json
```
AWS ECS CLI run-task to run container
```
  > cd github-travis-ecs 
  > aws ecs run-task --cli-input-json file://ecs-job.json
```
AWS ECS CLI create-service to run container
```
  > cd github-travis-ecs 
  > aws ecs create-service --cli-input-json file://ecs-service.json
```
AWS ECS CLI update-service to re-run container
```
  > cd github-travis-ecs 
  > aws ecs update-service --cluster ap --service ap0001 --task-definition ap0001 --desired-count 1
``` 

## AWS Lambda Trigger Cronjob
- [x] CloudWatch schedule event config(cron)
- [x] AWS Lambda trigger AP Cron Job

CloudWatch schedule event config(cron)
```
  > cd github-travis-ecs 
  > aws events put-rule --cli-input-json file://cron.json
```
AWS Lambda trigger AP Cron Job
```
  > aws lambda add-permission --cli-input-json file://cron-lambda-permission.json
  > aws events put-targets --cli-input-json file://cron-lambda-target.json
```

## AWS CloudFormation Build AP Environment 
- [x] AWS CloudFormation create AP Compute Environments and AP Job Queues
- [x] AWS CloudFormation create AWS Lambda to Trigger AP Batch Job
- [x] AWS CloudFormation create AP Job Definitions

AWS CloudFormation create AP Compute Environments and AP Job Queues
```
  > cd cf
  > aws cloudformation create-stack --stack-name APComputeEnvironment --template-body file://APComputeEnvironment.yaml --capabilities CAPABILITY_IAM
```
AWS CloudFormation create AWS Lambda to Trigger AP Batch Job
```
  > cd cf 
  > aws cloudformation create-stack --stack-name APLambda --template-body file://APLambda.yaml --capabilities CAPABILITY_IAM
```
AWS CloudFormation create AP Job Definitions
```
  > aws cloudformation create-stack --stack-name AP0001 --template-body file://definition.yaml --parameters file://parameters.json --capabilities CAPABILITY_IAM
```
### Travis CI Task List
- [ ] Integration Github and Travis CI, use .travis.yml 
- [ ] Push AP to GitHub
- [ ] Travis CI build AP Docker Image
- [ ] Travis CI push AP Docker Image to AWS ECR