locals {
    commons_tag = {
            name = var.project
            environment = var.environment
            terraform = "true"
        }
    }


vpc_final_tags = merge (
local.commom_tags,
{
    name = "${var.project}-${var.environment}"
}

)