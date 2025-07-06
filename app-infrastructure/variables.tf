
variable "aws_region" {
  default = "ap-south-1"
}

variable "vpc_id" {
  default = "vpc-0c2a34d558258afbe"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["172.31.51.0/24", "172.31.52.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["172.31.53.0/24", "172.31.54.0/24"]
}

variable "public_subnets_ids" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["subnet-019322fa904babac2", "subnet-0594bd624fa8b3016"]
}

variable "private_subnets_ids" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["subnet-0b996b78b19d163f6", "subnet-077b43dcd7515e758"]
}

variable "public_subnet_tags" {
  type = map(string)
  default = {
    Type = "public"
  }
}
variable "private_subnet_tags" {
  type = map(string)
  default = {
    Type = "private"
  }
}

variable "ecr_image_url" {
  description = "ECR image URI (e.g., 123456789012.dkr.ecr.us-east-1.amazonaws.com/my-app:latest)"
  default = "594541045824.dkr.ecr.ap-south-1.amazonaws.com/demo-java-microservices-1:latest"
}
