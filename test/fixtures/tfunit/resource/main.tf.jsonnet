local tf = import 'main.libsonnet';

tf.withResource('null_resource', 'foo', {})
