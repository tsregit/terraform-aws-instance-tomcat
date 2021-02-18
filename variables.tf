variable "cidr" {
  type = string
  default = "172.31.0.0/16"
}

variable "ami_id" {
  type = string
  default = "ami-047a51fa27710816e"
}

variable "ami_type" {
  type = string
  default = "t2.micro"
}

variable project_name {
  description = "Project name, used for namespacing things"
  default = "tomcatEC2"
}

variable in_source_security_group {
  description = "Security group to receive SSH access"
  type = "string"
  default = ""
}

variable in_cidr_blocks {
  type = "list"
  default = ["0.0.0.0/0"]
}

variable ssh_user {
  type = string
  default = "ec2-user"
}

variable ssh_key_name {
  type = string
  default = "keyPairTomcat"
}

variable region {
  type = string
  default = "us-east-1"
}

variable profile {
  type = string
  default = "tomas-dev"
}