import sys
from awsglue.context import GlueContext
from pyspark.context import SparkContext
from awsglue.utils import getResolvedOptions
from pyspark.sql.functions import to_date

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

input_path = "s3://my-stock-etl-bucket/stock/raw/"
output_path = "s3://my-stock-etl-bucket/stock/processed/"

df = spark.read.option("header", True).csv(input_path)

# Basic cleaning
df = df.dropna(subset=["Close"]) \
       .withColumnRenamed("Close", "close_price") \
       .withColumn("trade_date", to_date("Datetime"))

df.write.mode("overwrite") \
    .partitionBy("symbol", "trade_date") \
    .parquet(output_path)
