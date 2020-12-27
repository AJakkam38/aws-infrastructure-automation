variable "myvar" {
    type = string
    default = "Hello Terraform"     # var.myvar OR "${var.myvar}"
}

variable "mymap" {
  type = map(string)
  default = {
      mykey = "my value"        # var.mymap["mykey"] --> "my value"
  }
}

variable "mylist" {
  type = list
  default = [ 1, 2, 3]      # var.mylist[0] --> 1
}