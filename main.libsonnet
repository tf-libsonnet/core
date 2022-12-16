local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

{
  '#': d.pkg(
    name='tf',
    url='github.com/tf-libsonnet/core/main.libsonnet',
    help=|||
      `tf` implements core utility functions for generating Terraform code.
    |||,
  ),
}
+ (import 'src/_custom/main.libsonnet')
