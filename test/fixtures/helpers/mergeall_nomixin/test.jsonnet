local h = import '_custom/helpers.libsonnet';

h.mergeAll([
  { greeting: 'hello' },
  { message: 'world' },
])
