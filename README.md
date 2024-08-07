TERRAFORM HONEYCOMBIO REFINERY-STARTER-PACK
================================================================

[![OSS Lifecycle](https://img.shields.io/osslifecycle/honeycombio/terraform-honeycombio-refinery-starter-pack?color=success)](https://github.com/honeycombio/home/blob/main/honeycomb-oss-lifecycle-and-practices.md)
[![CI](https://github.com/honeycombio/terraform-honeycombio-refinery-starter-pack/actions/workflows/test-terraform-module.yml/badge.svg)](https://github.com/honeycombio/terraform-honeycombio-refinery-starter-pack/actions?query=Test%20Terraform%20Module)

This module creates resources like Boards (and someday Triggers and SLOs!) in [Honeycomb](https://www.honeycomb.io) to help you manage the health of your Refinery cluster

## Use
You must have `terraform` installed. Follow [these directions](https://learn.hashicorp.com/tutorials/terraform/install-cli) to install for your platform.

You will need a Honeycomb API key with the adequate permissions to create boards, queries etc.. Once you have the API key, you can set it like so:

The minimal config is:

```hcl
module "explore-honeycombio-refinery-starter-pack" {
  source = "honeycombio/refinery-starter-pack/honeycombio"

  refinery_metrics_dataset = "Refinery Metrics" # Optional: defaults to "Refinery Metrics"
  refinery_logs_dataset = "Refinery Logs" # Optional: defaults to "Refinery Metrics"
  refinery_cluster_name = "Production" # Optional: defaults to "Production"
}
```

Set the API key used by Terraform setting the HONEYCOMB_API_KEY environment variable.

```bash
export HONEYCOMB_API_KEY=$HONEYCOMB_API_KEY
```

Now you can run `terraform plan/apply` in sequence.

<img src="https://user-images.githubusercontent.com/3537368/193894740-e22a156f-954d-49c4-96f5-1f8322bc02ff.png" width="500"> <img src="https://user-images.githubusercontent.com/3537368/193894750-44cf688e-9841-4bc0-bc21-df9a13783ec0.png" width="500">



For more config options,
see [USAGE.md](https://github.com/honeycombio/terraform-honeycombio-refinery-starter-pack/blob/main/USAGE.md)
.

## Video Walkthrough

Note: Video is muted by default

[HNY-SP-REFOPS.webm](https://user-images.githubusercontent.com/3537368/193695669-5828ef3b-ac90-4571-991e-3536574d7c66.webm)



## Examples

Examples of use of this module can be found
in [`examples/`](https://github.com/honeycombio/terraform-honeycombio-refinery-starter-pack/tree/main/examples)
. We've
provided a build durations exploration example.

## Development

### Tests

Test cases that run against local code are
in [`tests/`](https://github.com/honeycombio/terraform-honeycombio-refinery-starter-pack/tree/main/tests)
. To set up:

1. Set the API key used by Terraform setting the HONEYCOMB_API_KEY environment variable.

3. `terraform plan` and `terraform apply` will now work as expected, as will
   `terraform destroy`.

4. Test cases also run as part of the pipeline.
   See [test-terraform-module.yml](https://github.com/honeycombio/terraform-honeycombio-refinery-starter-pack/blob/main/.github/workflows/test-terraform-module.yml)

### Docs

Docs are autogenerated via `./docs.sh`, and put
in [USAGE.md](https://github.com/honeycombio/terraform-honeycombio-refinery-starter-pack/blob/main/USAGE.md)
. Please
regenerate and commit before merging.

### Lints

We use [tflint](https://github.com/terraform-linters/tflint) and `terraform
fmt`, and enforce this with a [github action](.github/workflows/tflint.yml).

## Contributions

Features, bug fixes and other changes to this module are gladly accepted. Please open issues or a pull request with your
change.

All contributions will be released under the Apache License 2.0.
