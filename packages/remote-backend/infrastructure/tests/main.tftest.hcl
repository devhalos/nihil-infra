run "valid_dyene_web_app_remote_backend" {
  command = plan

  assert {
    condition     = module.dyene_web_app.state_bucket_name == "devhalos-nihil-dyene-state"
    error_message = "state bucket name did not match expected"
  }

  assert {
    condition     = module.dyene_web_app.state_lock_table_name == "devhalos-nihil-dyene-state-locking"
    error_message = "state table name did not match expected"
  }
}
