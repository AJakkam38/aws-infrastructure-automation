variable "AWS_REGION" {
    default = "us-east-1"
}

variable "AMI" {
  type = map(string)
  default = {
      us-east-1 = "ami-0947d2ba12ee1ff75"
  }
}