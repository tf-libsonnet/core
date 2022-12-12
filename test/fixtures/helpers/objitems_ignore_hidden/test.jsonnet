local h = import '_custom/helpers.libsonnet';

local obj = {
  one: 1,
  two: '2-',
  three:: {
    three: 3,
  },
};

{
  [f.k]: f.v
  for f in h.objItems(obj)
}
