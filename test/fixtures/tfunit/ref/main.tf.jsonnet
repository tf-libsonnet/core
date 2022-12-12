local tf = import 'main.libsonnet';

local o =
  tf.withData('null_data_source', 'foo', {
    inputs: {
      msg: 'hello world',
    },
  })
  + tf.withResource('null_resource', 'foo', {})
  + tf.withOutput('output', {
    msg: o._ref.data.null_data_source.foo.get('outputs.msg'),
    null_resource_id: o._ref.null_resource.foo.get('id'),
  });

o
