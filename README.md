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
- [ ] AWS EC2 create Key Pairs for EC2 ssh login
- [ ] AWS VPC create Security Group
- [ ] AWS EC2 create Load Balancer(?)
- [ ] AWS IAM Role create ecsInstanceRole (for EC2)
- [ ] AWS IAM Role create ecsServiceRole (for ECS)
- [ ] AWS ECR create AP Image Repository
- [ ] AWS S3 upload ECS cluster config
- [ ] AWS EC2 create 3 instance for ECS cluster
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
- [ ] AWS Batch create Compute Environment
- [ ] AWS Batch create Job Queue
- [ ] AWS Batch create AP Job Definition
- [ ] AWS CLI schedule AP Job into Job Queue