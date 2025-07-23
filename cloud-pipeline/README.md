# Cloud Pipeline Template — Stock Price ETL with AWS Glue

This project is a template for building a cloud-native ETL pipeline that ingests daily stock price data from Yahoo Finance, stores it in S3, and transforms it using AWS Glue.

## Architecture

![architecture](architecture_diagram.png)

## Features

- Python script to fetch stock data using `yfinance`
- Upload to Amazon S3 (raw zone)
- AWS Glue PySpark job to clean and partition data
- Terraform to deploy all infrastructure

## Getting Started

1. Clone the repo:
   ```bash
   git clone https://github.com/yourusername/cloud-pipeline-template.git
   ```
2. Edit variables.tf to set your bucket name and region.

3. Deploy infrastructure:
    ```bash
    cd terraform
    terraform init
    terraform apply
    ```
4. Upload your transform script to S3:
    ```bash
    aws s3 cp glue_jobs/transform_job.py s3://<your-bucket-name>/scripts/
    ```
5. Trigger the Glue job manually or on schedule.
