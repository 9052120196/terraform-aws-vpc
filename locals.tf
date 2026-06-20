locals {
    commons_tags = {
            name = var.project
            environment = var.environment
            terraform = "true"
        }
    


vpcfinaltags = merge(
local.commons_tags,
{
    Name = "${var.project}-${var.environment}"
}

)

igw_final_tags = merge(
    local.commons_tags,
{
    Name = "${var.project}-${var.environment}"
},
var.igw_tags


)

az_names =slice(data.aws_availability_zones.available.names,0,2)

}