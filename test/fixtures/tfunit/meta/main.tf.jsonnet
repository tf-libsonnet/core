local tf = import 'main.libsonnet';

tf.withResource(
  'null_resource',
  'foo',
  {},
  _meta=tf.meta.new(count=5),
)
+ tf.withOutput('output', { num_created: '${length(null_resource.foo)}' })
