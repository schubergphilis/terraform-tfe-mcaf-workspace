# Changelog

All notable changes to this project will automatically be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## v2.4.0 - 2025-03-14

### What's Changed

Note: This version bumps the Terraform required version to `>= 1.7.0`, see #26

#### 🐛 Bug Fixes

* fix: invalid for_each argument error in TF 1.10.0+ when notification configuration url is marked sensitive (#26) @mlflr

**Full Changelog**: https://github.com/schubergphilis/terraform-tfe-mcaf-workspace/compare/v2.3.1...v2.4.0

## v2.3.1 - 2025-02-24

### What's Changed

#### 🐛 Bug Fixes

* bug: trigger patterns could be null (#25) @marwinbaumannsbp

**Full Changelog**: https://github.com/schubergphilis/terraform-tfe-mcaf-workspace/compare/v2.3.0...v2.3.1

## v2.3.0 - 2025-02-24

### What's Changed

#### 🚀 Features

* enhancement: move trigger_prefix default values to trigger_patterns (#24) @noobnesz

**Full Changelog**: https://github.com/schubergphilis/terraform-tfe-mcaf-workspace/compare/v2.2.0...v2.3.0

## v2.2.0 - 2025-01-28

### What's Changed

#### 🚀 Features

* feat(options): Add speculative_enabled option (#23) @stromp

**Full Changelog**: https://github.com/schubergphilis/terraform-tfe-mcaf-workspace/compare/v2.1.1...v2.2.0

## v2.1.1 - 2024-12-13

### What's Changed

#### 🐛 Bug Fixes

* fix: Fix deprecation (#22) @fatbasstard

**Full Changelog**: https://github.com/schubergphilis/terraform-tfe-mcaf-workspace/compare/v2.1.0...v2.1.1

## v2.1.0 - 2024-12-11

### What's Changed

#### 🚀 Features

* feature: Support GitHub app for VCS connections (#21) @shoekstra

**Full Changelog**: https://github.com/schubergphilis/terraform-tfe-mcaf-workspace/compare/v2.0.0...v2.1.0

## v2.0.0 - 2024-08-23

### What's Changed

#### 🚀 Features

* breaking: Sync changes from terrraform-aws-mcaf-workspace to this repo (#20) @stefanwb

**Full Changelog**: https://github.com/schubergphilis/terraform-tfe-mcaf-workspace/compare/v1.0.0...v2.0.0

## v1.0.0 - 2024-01-30

### What's Changed

#### 🚀 Features

* breaking: improve team access settings (#18) @marwinbaumannsbp

**Full Changelog**: https://github.com/schubergphilis/terraform-tfe-mcaf-workspace/compare/v0.5.0...v1.0.0

## v0.5.0 - 2024-01-30

### What's Changed

#### 🚀 Features

* feature: add central workflow, make repository_identifier optional, fix bug in workspace_tags (#19) @marwinbaumannsbp

**Full Changelog**: https://github.com/schubergphilis/terraform-tfe-mcaf-workspace/compare/v0.4.1...v0.5.0
