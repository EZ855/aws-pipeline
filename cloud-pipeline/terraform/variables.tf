// Terraform variables
variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "bucket_name" {
  description = "S3 bucket for data pipeline"
  type        = string
  default     = "my-stock-etl-bucket"
}

variable "glue_job_name" {
  description = "Name of the AWS Glue Job"
  type        = string
  default     = "stock-etl-transform"
}
