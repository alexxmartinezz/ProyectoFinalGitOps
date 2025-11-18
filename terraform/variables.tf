variable "owner" {
  type    = string
  default = "Alejandro Martinez"
}

variable "project" {
  type    = string
  default = "GitOps Final Project"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "key_name" {
  type    = string
  default = "alejandro"
}

variable "asg_min_size" {
  default = 2
}
variable "asg_max_size" {
  default = 4
}
variable "instance_type" {
  default = "t3.micro"
}

variable "rds_username" {
  default = "postgres_user"
}
variable "rds_password" {
  default = "postgres_pass"
}
