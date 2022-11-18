variable "region" {
    default = "us-central1"
    type = string
}

variable "management-subnet-cidr" {
    default = "10.0.0.0/24"
    type = string
}


variable "restricted-subnet-cidr" {
    default = "10.0.1.0/24"
    type = string
}