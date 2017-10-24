# github-travis-ecs
Use github and travis-ci to build docker image and push to AWS ECR, then use AWS ECS Cluster to run container service.

### Skills
1. GitHub
2. Travis CI
3. Docker
4. AWS
5. AWS ECR
6. AWS ECS
7. AWS S3

### AWS Environment Config Task List
- [x] AWS EC2 create Key Pairs for EC2 ssh login
- [x] AWS VPC create Security Group
- [x] AWS EC2 create Load Balancer(?)
- [x] AWS IAM Role create ecsInstanceRole (for EC2)
- [x] AWS IAM Role create ecsServiceRole (for ECS)
- [x] AWS IAM Role create batchServiceRole (for Batch)
- [x] AWS ECR create AP Image Repository

### AWS ECS Environment Config Task List
- [x] AWS ECS create AP Cluster
- [x] AWS S3 upload ECS cluster config (for ECS)
- [x] AWS EC2 create 3 instance for ECS cluster (for ECS)

### AWS Batch Environment Config Task List
- [x] AWS Batch create Compute Environment (for Batch)
- [x] AWS Batch create Job Queue (for Batch)
### Local Dev Task List
- [ ] Python Image Dcokerfile
- [ ] Local Test Build AP Docker Image
- [ ] Local Test Run AP Docker Image
- [ ] Push AP code and Dockerfile to GitHub
### Travis CI Task List
- [ ] Integration Github and Travis CI
- [ ] Travis CI build AP Docker Image
- [ ] Travis CI push AP Docker Image to AWS ECR
### CD Task List (ECS)
- [ ] AWS ECS create AP Task Definition
- [ ] AWS CLI create-service and run-task to run container
- [ ] AWS ECS update AP Task Definition
- [ ] AWS CLI update-service and run-task to run container
### CD Task List (Batch)
- [ ] AWS Batch create AP Job Definition
- [ ] AWS CLI schedule AP Job into Job Queue


## AWS Environment Config Task List
- [x] AWS EC2 create Key Pairs for EC2 ssh login
- [x] AWS VPC create Security Group
- [x] AWS EC2 create Load Balancer(?)
- [x] AWS IAM Role create ecsInstanceRole (for EC2)
- [x] AWS IAM Role create ecsServiceRole (for ECS)
- [x] AWS IAM Role create batchServiceRole (for Batch)

- [x] AWS ECR create AP Image Repository

AWS EC2 create Key Pairs for EC2 ssh login
```
  > aws ec2 create-key-pair --key-name aws-ap --query 'KeyMaterial' --output text > ~/.ssh/aws-ap.pem
```
AWS VPC create Security Group
```
  > aws ec2 create-security-group --group-name ap_sg_ap-northeast-1 --description "security group for AP on ap-northeast-1"
```
AWS EC2 create Load Balancer
```
  > cd github-travis-ecs
  > aws elb create-load-balancer --cli-input-json file://ap-load-balancer.json
```
AWS IAM Role create ecsInstanceRole (for EC2)
```
  > cd github-travis-ecs
  > aws iam create-role --role-name ap-ecsInstanceRole --description ap-ecsInstanceRole --assume-role-policy-document file://ec2-role.json
  > aws iam attach-role-policy --role-name ap-ecsInstanceRole --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role
  > aws iam attach-role-policy --role-name ap-ecsInstanceRole --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
  > aws iam create-instance-profile --instance-profile-name ap-ecsInstanceRole
  > aws iam add-role-to-instance-profile --role-name ap-ecsInstanceRole --instance-profile-name ap-ecsInstanceRole
```
AWS IAM Role create ecsServiceRole (for ECS)
```
  > cd github-travis-ecs
  > aws iam create-role --role-name ap-ecsServiceRole --description ap-ecsServiceRole --assume-role-policy-document file://ecs-role.json
  > aws iam attach-role-policy --role-name ap-ecsServiceRole --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole
```
AWS IAM Role create batchServiceRole (for Batch)
```
  > cd github-travis-ecs
  > aws iam create-role --role-name ap-batchServiceRole --description ap-batchServiceRole --assume-role-policy-document file://batch-role.json
  > aws iam attach-role-policy --role-name ap-batchServiceRole --policy-arn arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole
```
AWS ECR create AP Image Repository
```
  > eval "$(aws ecr get-login --no-include-email)"
  > aws ecr create-repository --repository-name ap/ap0001
```

## AWS ECS Environment Config Task List
- [x] AWS ECS create AP Cluster
- [x] AWS S3 upload ECS cluster config (for ECS)
- [x] AWS EC2 create 3 instance for ECS cluster (for ECS)

AWS ECS create AP Cluster
```
  > aws ecs create-cluster --cluster-name ap
```
AWS S3 upload ECS cluster config
```
  > cd github-travis-ecs
  > aws s3api create-bucket --bucket ap-cluster --region ap-northeast-1 --create-bucket-configuration LocationConstraint=ap-northeast-1
  > aws s3 cp ecs.config s3://ap-cluster/ecs.config
```
AWS EC2 create 3 instance for ECS cluster
```
  > aws ec2 run-instances --image-id ami-21815747 --count 3 --instance-type t2.micro --iam-instance-profile Name=ap-ecsInstanceRole --key-name aws-ap --security-group-ids sg-a14a44c7 --user-data file://copy-ecs-config-from-s3
```

## AWS Batch Environment Config Task List
- [x] AWS Batch create Compute Environment (for Batch)
- [x] AWS Batch create Job Queue (for Batch)

AWS Batch create Compute Environment (for Batch)
```
  > cd github-travis-ecs
  > aws batch create-compute-environment --cli-input-json file://ap-compute-environment.json
```
AWS Batch create Job Queue (for Batch)
```
  > cd github-travis-ecs
  > aws batch create-job-queue --cli-input-json file://ap-queue.json
```
