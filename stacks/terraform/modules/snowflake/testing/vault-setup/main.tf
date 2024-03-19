data "aws_secretsmanager_secret" "dbt_playground_tf_snow_private_key" {
  name = "dbt-playground/tf-snow-private-key"
}

data "aws_secretsmanager_secret_version" "dbt_playground_tf_snow_private_key" {
  secret_id = data.aws_secretsmanager_secret.dbt_playground_tf_snow_private_key.id
}

data "aws_secretsmanager_secret" "dbt_playground_tf_snow_private_key_passphrase" {
  name = "dbt-playground/tf-snow-private-key-passphrase"
}

data "aws_secretsmanager_secret_version" "dbt_playground_tf_snow_private_key_passphrase" {
  secret_id = data.aws_secretsmanager_secret.dbt_playground_tf_snow_private_key_passphrase.id
}
