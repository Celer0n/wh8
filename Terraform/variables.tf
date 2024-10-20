variable "region" {
  description = "Project region"
  type        = string
  default     = "eu-central-1"
}

variable "profile" {
  description = "AWS access profile"
  type        = string
  default     = "default"
}

variable "ami_id_ubuntu" {
  description = "AMI UB VM"
  type        = string
  default     = "ami-07652eda1fbad7432"
}

variable "ami_id_rhel" {
  description = "AMI RH VM"
  type        = string
  default     = "ami-08ec94f928cf25a9d"
}

variable "instance_type" {
  description = "VM type"
  type        = string
  default     = "t2.micro"
}

variable "volume_size" {
  description = "Volume size"
  type        = number
  default     = "10"
}

variable "volume_type" {
  description = "Volume type"
  type        = string
  default     = "gp2"
}