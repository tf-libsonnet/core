local h = import 'src/_custom/helpers.libsonnet';

h.mergeAll([
  { msgs+: ['hello'] },
  { msgs+: ['world'] },
])
