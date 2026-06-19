locals {
    commons_tag = {
            name = var.project
            environment = var.environment
            terraform = "true"
        }
    


vpcfinaltags = merge (
local.commons_tag,
{
    name = "${var.project}-${var.environment}"
}

)

}