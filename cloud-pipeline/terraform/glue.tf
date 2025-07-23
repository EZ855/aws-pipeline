// AWS Glue job Terraform resource
resource "aws_s3_bucket" "data_pipeline" {
  bucket = var.bucket_name
}

resource "aws_iam_role" "glue_role" {
  name = "glue-job-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "glue.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "glue_policy_attach" {
  role       = aws_iam_role.glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_glue_job" "transform_job" {
  name     = var.glue_job_name
  role_arn = aws_iam_role.glue_role.arn

  command {
    name            = "glueetl"
    script_location = "s3://${var.bucket_name}/scripts/transform_job.py"
    python_version  = "3"
  }

  glue_version      = "4.0"
  max_capacity      = 2
  number_of_workers = 2
  worker_type       = "G.1X"
}
