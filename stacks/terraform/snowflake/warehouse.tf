resource "snowflake_warehouse" "dev_xs_warehouse" {
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
