<h1 align="center">tf-libsonnet/core</h1>

<p align="center">
  <em>Generate Terraform with Jsonnet</em>
</p>

<p align="center">
  <a href="https://github.com/tf-libsonnet/core/blob/main/LICENSE">
    <img alt="LICENSE" src="https://img.shields.io/github/license/tf-libsonnet/core?style=for-the-badge">
  </a>
  <a href="https://github.com/tf-libsonnet/core/actions/workflows/lint-and-test.yml?query=branch%3Amain">
    <img alt="main branch CI" src="https://img.shields.io/github/actions/workflow/status/tf-libsonnet/core/lint-and-test.yml?branch=main&logo=github&label=CI&style=for-the-badge">
  </a>
  <a href="https://github.com/tf-libsonnet/core/releases/latest">
    <img alt="latest release" src="https://img.shields.io/github/v/release/tf-libsonnet/core?style=for-the-badge">
  </a>
</p>

This repository contains [Jsonnet](https://jsonnet.org/) functions for generating Terraform code.

Learn more about `tf.libsonnet` [here](https://docs.tflibsonnet.com).

## Usage

Install the package using [jsonnet-bundler](https://github.com/jsonnet-bundler/jsonnet-bundler):

```
jb install github.com/tf-libsonnet/core@main

# Or if you want to install a specific release
#   jb install github.com/tf-libsonnet/core@v0.0.1
```

You can then import the package in your Jsonnet code:

```jsonnet
// main.tf.json.jsonnet
local tf = import 'github.com/tf-libsonnet/core/main.libsonnet';

tf.withVariable('some_input', type='string')
+ tf.withLocal('some_local', '${var.some_input}')
+ tf.withOutput('some_output', '${local.some_local}')
```

This will generate the following Terraform JSON :

```json
{
   "locals": {
      "some_local": "${var.some_input}"
   },
   "output": {
      "some_output": {
         "value": "${local.some_local}"
      }
   },
   "variable": {
      "some_input": {
         "type": "string"
      }
   }
}
```

Refer to the [reference docs](/docs/README.md) for a reference of all exporeted functions.


## Support

If you have any questions about how to use the `tf.libsonnet` libraries, ask in the [Organization GitHub
Discussion](https://github.com/orgs/tf-libsonnet/discussions).


## Contributing

Refer to the [CONTRIBUTING.md](/CONTRIBUTING.md) document for information on how to contribute to `tf.libsonnet`.
