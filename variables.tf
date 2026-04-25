variable "disk_size" {
  default = 20
  type    = number
}

variable "instance" {
  default = "t3.micro"
  type    = string

}

variable "disk_type" {
  default = "gp3"
  type    = string
}