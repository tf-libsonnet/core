local tf = import 'main.libsonnet';

tf.withLocal('foo', { msg: 'hello world' })
+ tf.withOutput('output', '${local.foo}')
