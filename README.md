# aws-project-3

# Pre-Req
# 1. jdk
# 2. mvn
# 3. aws cli
# 4. docker

cd java-microservices-ecr-demo
# Maven clean package
mvn clean package

# Login to ECR
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com

# Docker Build
# MAC OS or ARM
docker buildx build --platform linux/amd64 -t demo-java-microservices-1 .
# Others
docker build -t demo-java-microservices-1 .

# Docker Tag
docker tag demo-java-microservices-1:latest <awsaccountid>.dkr.ecr.ap-south-1.amazonaws.com/demo-java-microservices-1:latest

# Docker Push
docker push <awsaccountid>.dkr.ecr.ap-south-1.amazonaws.com/demo-java-microservices-1:latest

# To run on local
docker run -p 8080:8080 demo-java-microservices-1
