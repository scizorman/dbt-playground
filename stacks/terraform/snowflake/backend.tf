terraform {
  backend "s3" {
    bucket = "dbt-playground-terraform-state"
    key    = "snowflake/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
