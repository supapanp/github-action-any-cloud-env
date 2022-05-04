############################################################################################################
# Basic Variable Configuration                                                                             #
############################################################################################################
variable "queue_deploymentmode" {
    type = string
    default = "ACTIVE_STANDBY_MULTI_AZ"
    description = "Queue operate for deployment mode"
    validation {
    condition     = contains(["ACTIVE_STANDBY_MULTI_AZ"], var.queue_deploymentmode)
    error_message = "Deployment mode is incorrect. Allow value is should be (ACTIVE_STANDBY_MULTI_AZ)."
    }
}

variable "queue_prefixname" {
    type = string
    default = "queuemodule"
    description = "Queue prefix name. This will use to setup prefix name of cache (Must begin with a lower case letter and contain only alphanumeric characters)."
}

variable "queue_engtype" {
    type = string
    default = "ActiveMQ"
    description = "Define message queue engine for operate"
    validation {
    condition     = contains(["ActiveMQ"], var.queue_engtype)
    error_message = "Queue engine is incorrect. Allow value is should be (ActiveMQ)."
    }
}

variable "queue_storage_type" {
    type = string
    default = "efs"
    description = "Define storage type for queue"
    validation {
    condition     = contains(["efs","ebs"], var.queue_storage_type)
    error_message = "Queue engine is incorrect. Allow value is should be (efs,ebs)."
    }
}

variable "queue_engversion" {
    type = map
    description = "Queue engine version. By default system will choose lastest version parameter group for you. This can customize by check detail on Queue"
    default = {
    "RabbitMQ"    = "3.9.13"
    "ActiveMQ"    = "5.16.4"
  }
}

variable "queue_instance_type" {
    type = string
    default = "mq.t3.micro"
    description = "Define Queue sizing for create"
    validation {
    condition     = contains(["mq.t3.micro", "mq.m5.large", "mq.m5.xlarge", "mq.m5.2xlarge"], var.queue_instance_type)
    error_message = "Queue sizing variable is incorrect. Allow value is should be (mq.t3.micro, mq.m5.large, mq.m5.xlarge, mq.m5.2xlarge)."
    }
}

variable "queue_username" {
    type = string
    default = "queuemaster"
    description = "Queue username"
}

variable "queue_password" {
    type = string
    default = "qmsg49hs1234567890"
    description = "Queue password"
}

variable "queue_publiclyaccessible" {
  type = bool
  default = false
  description = "Is it require this queue public access or not ? (true/false)"
}

############################################################################################################
# Local Tag Description Variable                                                                           #
############################################################################################################
variable "tag_category" {
  type = string
  default = "queue"
  description = "Category of element to create on AWS for queue element wil define value as 'queue'"
}