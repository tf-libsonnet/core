local tf = import 'main.libsonnet';

tf.withVariable('required_input', type='string')
+ tf.withVariable('optional_number', isRequired=false, type='number', default=0)
