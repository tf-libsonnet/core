local tf = import 'main.libsonnet';

tf.withData('null_data_source', 'foo', {
  inputs: {
    msg: 'hello world',
  },
})
+ tf.withOutput('output', { msg: '${data.null_data_source.foo.outputs.msg}' })
