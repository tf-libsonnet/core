local h = import '_custom/helpers.libsonnet';

h.mergeAll([
  { msgs+: ['hello'] },
  { msgs+: ['world'] },
])
