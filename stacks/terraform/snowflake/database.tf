resource "snowflake_database" "tpch" {
  name    = "DBT_PLAYGROUND_TPCH"
  comment = "The TPC-H database used in dbt-playground."
}
