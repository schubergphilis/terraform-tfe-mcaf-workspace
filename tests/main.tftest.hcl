run "setup" {
  module {
    source = "./tests/setup"
  }
}

mock_provider "tfe" {}

// The default test checks logic in module when using it's default values when creating a plan.
// Additional tests below check individual variables and changes to their defaults. Try not to
// create assertions for resource fields that reference just the variable.

run "default" {
  command = plan

  module {
    source = "./"
  }

  variables {
    name                   = "basic-workspace-${run.setup.random_string}"
    terraform_organization = "my-test-org"
  }

  assert {
    condition     = tfe_workspace.default.name == "basic-workspace-${run.setup.random_string}"
    error_message = "Expected workspace name to be \"basic-workspace-${run.setup.random_string}\""
  }

  assert {
    condition     = tfe_workspace.default.allow_destroy_plan == true
    error_message = "Expected allow_destroy_plan to be true"
  }

  assert {
    condition     = tfe_workspace.default.assessments_enabled == true
    error_message = "Expected assessments_enabled to be true"
  }

  assert {
    condition     = tfe_workspace.default.auto_apply == false
    error_message = "Expected auto_apply to be false"
  }

  assert {
    condition     = tfe_workspace.default.file_triggers_enabled == false
    error_message = "Expected file_triggers_enabled to be false"
  }

  assert {
    condition     = tfe_workspace.default.trigger_patterns == null
    error_message = "Expected trigger_patterns to be null"
  }

  assert {
    condition     = tfe_workspace.default.trigger_prefixes == null
    error_message = "Expected trigger_prefixes to be null"
  }

  assert {
    condition     = tfe_workspace.default.organization == "my-test-org"
    error_message = "Expected organization to be \"my-test-org\""
  }

  assert {
    condition     = tfe_workspace.default.queue_all_runs == true
    error_message = "Expected queue_all_runs to be true"
  }

  assert {
    condition     = tfe_workspace.default.terraform_version == "latest"
    error_message = "Expected terraform_version to be \"latest\""
  }

  assert {
    condition     = tfe_workspace_settings.default.execution_mode == "remote"
    error_message = "Expected execution_mode to be \"remote\""
  }
}

run "set_trigger_prefixes" {
  command = plan

  module {
    source = "./"
  }

  variables {
    name                   = "basic-workspace-${run.setup.random_string}"
    terraform_organization = "my-test-org"

    # No repository_identifier
    trigger_patterns = null
    trigger_prefixes = ["terraform/"]
  }

  assert {
    condition     = tfe_workspace.default.file_triggers_enabled == false
    error_message = "Expected file_triggers_enabled to be false when no repository is connected"
  }

  assert {
    condition     = tfe_workspace.default.trigger_patterns == null
    error_message = "Expected trigger_patterns to be null when no repository is connected"
  }

  assert {
    condition     = tfe_workspace.default.trigger_prefixes == null
    error_message = "Expected trigger_prefixes to be null when no repository is connected"
  }

  assert {
    condition     = tfe_workspace.default.working_directory == null
    error_message = "Expected working_directory to be null when no repository is connected"
  }
}

run "set_repository_identifier" {
  command = plan

  module {
    source = "./"
  }

  variables {
    name                   = "basic-workspace-${run.setup.random_string}"
    terraform_organization = "my-test-org"

    oauth_token_id        = "ot-xxxxxxxxxxxxxxxx"
    repository_identifier = "test/test"
  }

  assert {
    condition     = tfe_workspace.default.file_triggers_enabled == true
    error_message = "Expected file_triggers_enabled to be true"
  }

  assert {
    condition     = length(tfe_workspace.default.trigger_patterns) == 2
    error_message = "Expected trigger_patterns to contain 2 elements"
  }

  assert {
    condition     = contains(tfe_workspace.default.trigger_patterns, "terraform/*")
    error_message = "Expected trigger_patterns to contain \"terraform/*\""
  }

  assert {
    condition     = contains(tfe_workspace.default.trigger_patterns, "modules/**/*")
    error_message = "Expected trigger_patterns to contain \"modules/**/*\""
  }

  assert {
    condition     = tfe_workspace.default.trigger_prefixes == null
    error_message = "Expected trigger_prefixes to be null"
  }
}


run "set_repository_identifier_and_set_file_triggers_enabled_false" {
  command = plan

  module {
    source = "./"
  }

  variables {
    name                   = "basic-workspace-${run.setup.random_string}"
    terraform_organization = "my-test-org"

    oauth_token_id        = "ot-xxxxxxxxxxxxxxxx"
    repository_identifier = "test/test"
    file_triggers_enabled = false
  }

  assert {
    condition     = tfe_workspace.default.file_triggers_enabled == false
    error_message = "Expected file_triggers_enabled to be false"
  }

  assert {
    condition     = tfe_workspace.default.trigger_patterns == null
    error_message = "Expected trigger_patterns to be null"
  }

  assert {
    condition     = tfe_workspace.default.trigger_prefixes == null
    error_message = "Expected trigger_prefixes to be null"
  }
}

run "set_repository_identifier_and_set_multiple_trigger_patterns" {
  command = plan

  module {
    source = "./"
  }

  variables {
    name                   = "basic-workspace-${run.setup.random_string}"
    terraform_organization = "my-test-org"

    oauth_token_id        = "ot-xxxxxxxxxxxxxxxx"
    repository_identifier = "test/test"
    trigger_patterns      = ["path1/*.tf", "path2/*.tf"]
  }

  assert {
    condition     = length(tfe_workspace.default.trigger_patterns) == 3
    error_message = "Expected trigger_patterns to contain 3 elements"
  }

  assert {
    condition     = tfe_workspace.default.trigger_patterns[0] == "path1/*.tf"
    error_message = "Expected trigger_patterns[1] to be \"path1/*.tf\""
  }

  assert {
    condition     = tfe_workspace.default.trigger_patterns[1] == "path2/*.tf"
    error_message = "Expected trigger_patterns[2] to be \"path2/*.tf\""
  }

  assert {
    condition     = tfe_workspace.default.trigger_patterns[2] == "terraform/*"
    error_message = "Expected trigger_patterns[0] to be \"terraform/*\""
  }
}

run "set_repository_identifier_and_set_trigger_patterns_working_directory_recursive_to_true" {
  command = plan

  module {
    source = "./"
  }

  variables {
    name                   = "basic-workspace-${run.setup.random_string}"
    terraform_organization = "my-test-org"

    oauth_token_id                               = "ot-xxxxxxxxxxxxxxxx"
    repository_identifier                        = "test/test"
    trigger_patterns_working_directory_recursive = true
  }

  assert {
    condition     = length(tfe_workspace.default.trigger_patterns) == 2
    error_message = "Expected trigger_patterns to contain 2 elements"
  }

  assert {
    condition     = contains(tfe_workspace.default.trigger_patterns, "terraform/**/*")
    error_message = "Expected trigger_patterns to contain \"terraform/**/*\""
  }
}

run "set_repository_identifier_custom_working_directory_and_recursive_patterns" {
  command = plan

  module {
    source = "./"
  }

  variables {
    name                   = "basic-workspace-${run.setup.random_string}"
    terraform_organization = "my-test-org"

    oauth_token_id        = "ot-xxxxxxxxxxxxxxxx"
    repository_identifier = "test/test"

    working_directory                            = "infra"
    trigger_patterns                             = ["path1/*.tf"]
    trigger_patterns_working_directory_recursive = true
  }

  assert {
    condition     = tfe_workspace.default.file_triggers_enabled == true
    error_message = "Expected file_triggers_enabled to be true when repository is connected and triggers are configured"
  }

  assert {
    condition     = length(tfe_workspace.default.trigger_patterns) == 2
    error_message = "Expected trigger_patterns to contain 2 elements (custom pattern + infra/**/*)"
  }

  assert {
    condition     = contains(tfe_workspace.default.trigger_patterns, "path1/*.tf")
    error_message = "Expected trigger_patterns to contain \"path1/*.tf\""
  }

  assert {
    condition     = contains(tfe_workspace.default.trigger_patterns, "infra/**/*")
    error_message = "Expected trigger_patterns to contain \"infra/**/*\" when recursive is true and working_directory is \"infra\""
  }

  assert {
    condition     = tfe_workspace.default.trigger_prefixes == null
    error_message = "Expected trigger_prefixes to be null when trigger_patterns is non-null"
  }

  assert {
    condition     = tfe_workspace.default.working_directory == "infra"
    error_message = "Expected working_directory to be \"infra\""
  }
}

run "set_repository_identifier_and_set_trigger_patterns_null_and_use_trigger_prefixes" {
  command = plan

  module {
    source = "./"
  }

  variables {
    name                   = "basic-workspace-${run.setup.random_string}"
    terraform_organization = "my-test-org"

    oauth_token_id        = "ot-xxxxxxxxxxxxxxxx"
    repository_identifier = "test/test"
    trigger_patterns      = null
    trigger_prefixes      = ["terraform/"]
  }

  assert {
    condition     = tfe_workspace.default.file_triggers_enabled == true
    error_message = "Expected file_triggers_enabled to be true"
  }

  assert {
    condition     = tfe_workspace.default.trigger_patterns == null
    error_message = "Expected trigger_patterns to be null"
  }

  assert {
    condition     = length(tfe_workspace.default.trigger_prefixes) == 1
    error_message = "Expected trigger_prefixes to contain 1 element"
  }

  assert {
    condition     = tfe_workspace.default.trigger_prefixes[0] == "terraform/"
    error_message = "Expected trigger_prefixes[0] to be \"terraform/"
  }
}

run "set_both_trigger_patterns_and_prefixes_should_fail" {
  command = plan

  module {
    source = "./"
  }

  variables {
    name                   = "basic-workspace-${run.setup.random_string}"
    terraform_organization = "my-test-org"

    # These two together violate the validation:
    trigger_patterns = ["modules/**/*"]
    trigger_prefixes = ["terraform/"]
  }

  expect_failures = [
    var.trigger_patterns,
  ]
}
