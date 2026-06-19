locals {
    commons_tags = {
            name = var.project
            environment = var.environment
            terraform = "true"
        }
    


vpcfinaltags = merge (
local.commons_tags,
{
    Name = "${var.project}-${var.environment}"
}

)

}