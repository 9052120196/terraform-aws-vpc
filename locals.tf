locals {
    commons_tag = {
            name = var.project
            environment = var.environment
            terraform = "true"
        }
    


vpcfinaltags = merge (
local.commons_tags,
{
    name = "${var.project}-${var.environment}"
}

)

}