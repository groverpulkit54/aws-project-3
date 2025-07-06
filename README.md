# aws-project-3

## Java Microservice
### Pre-Req
1. jdk
2. mvn
3. aws cli
4. docker

cd java-microservices-ecr-demo
### Maven clean package
mvn clean package

### Login to ECR
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com

### Docker Build
 MAC OS or ARM
docker buildx build --platform linux/amd64 -t demo-java-microservices-1 .
** Others **
docker build -t demo-java-microservices-1 .

### Docker Tag
docker tag demo-java-microservices-1:latest <awsaccountid>.dkr.ecr.ap-south-1.amazonaws.com/demo-java-microservices-1:latest

### Docker Push
docker push <awsaccountid>.dkr.ecr.ap-south-1.amazonaws.com/demo-java-microservices-1:latest

### To run on local
docker run -p 8080:8080 demo-java-microservices-1

## App Infrastructure
cd app-infrastrucure

### The below will deploy a basic microservice to ECS and is accessible using ALB endpoint.
1. terraform init
2. terraform plan
3. terraform apply

# Add a microservice
### Copy the existing microservice directory. This is only for demo.
Change the return value from java code to differentiate. Our apps run in different containers so we use the same 8080 port for all our microservices.

### Login to AWS CLI and ECR
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com

### Build and push the new docker image for the new service
docker build -t demo-java-microservices-2 .
docker buildx build --platform linux/amd64 -t demo-java-microservices-2 .

To run on Local
docker run -p 8080:8080 demo-java-microservices-2

docker tag demo-java-microservices-2:latest 594541045824.dkr.ecr.ap-south-1.amazonaws.com/demo-java-microservices-2:latest

docker push 594541045824.dkr.ecr.ap-south-1.amazonaws.com/demo-java-microservices-2:latest

## Infrastructure for the new microservice
### Duplicate the following
1. Add a new variable to variables.tf with the new ECR value. Also add it to tfvars
2. Add new target group in alb.tf
3. Add listener for path based routing. In our case(/hi)
4. Add task definition in ecs.tf
5. Add ECS service for the new service that we are creating
