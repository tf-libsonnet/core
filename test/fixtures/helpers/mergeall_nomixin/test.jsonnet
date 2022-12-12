local h = import 'src/_custom/helpers.libsonnet';

h.mergeAll([
  { greeting: 'hello' },
  { message: 'world' },
])
