variable "project" {

    type = string
}


variable "environment" {
    type = string
}

variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}

variable "igw_tags" {
    type = map
    default = {}

}

variable "public_subnet_cidrs"{
 type = list
 default = ["10.0.1.0/24" , "10.0.2.0/24"]

}

variable "public_subnet_tags"{
    type = map
    default={}
}

variable "private_subnet_cidrs"{
 type = list
 default = ["10.0.11.0/24" , "10.0.12.0/24"]

}

variable "private_subnet_tags"{
    type = map
    default={}
}

variable "Database_subnet_cidrs"{
 type = list
 default = ["10.0.21.0/24" , "10.0.22.0/24"]

}

variable "Database_subnet_tags"{
    type = map
    default={}
}

variable "public_route_table_tags"{

    type= map 
    default={}
}

variable "private_route_table_tags"{

    type= map 
    default={}
}
variable "Database_route_table_tags"{

    type= map 
    default={}
}

variable "aws_eip_tags"{

    type= map 
    default={}
}

variable "aws_nat_gateway_tags"{
    type= map 
    default={}
}