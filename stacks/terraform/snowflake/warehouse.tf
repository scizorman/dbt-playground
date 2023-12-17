resource "snowflake_warehouse" "dev_xs" {
  name                                = "DBT_PLAYGROUND_DEV_XS_WH"
  auto_resume                         = true
  auto_suspend                        = 60
  comment                             = "The XS warehouse used in dbt-playground developments."
  initially_suspended                 = true
  query_acceleration_max_scale_factor = 8
  statement_timeout_in_seconds        = 300

  lifecycle {
    ignore_changes = [initially_suspended]
  }
}

resource "snowflake_warehouse" "dbt_xs" {
  name                                = "DBT_PLAYGROUND_DBT_XS_WH"
  auto_resume                         = true
  auto_suspend                        = 60
  comment                             = "The XS warehouse used by dbt in dbt-playground."
  initially_suspended                 = true
  max_cluster_count                   = 2
  min_cluster_count                   = 1
  query_acceleration_max_scale_factor = 8
  scaling_policy                      = "ECONOMY"
  statement_timeout_in_seconds        = 300

  lifecycle {
    ignore_changes = [initially_suspended]
  }
}
