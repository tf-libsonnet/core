local h = import 'src/_custom/helpers.libsonnet';

{
  number: h.isStringArray(42),
  string: h.isStringArray('hello world'),
  object: h.isStringArray({ msg: 'hello world' }),
  emptyArray: h.isStringArray([]),
  arrayNumber: h.isStringArray([42]),
  arrayObject: h.isStringArray([{ msg: 'hello world' }]),
  arrayString: h.isStringArray(['hello', 'world']),
  arrayNestedString: h.isStringArray([
    ['hello'],
    ['world'],
  ]),
  arrayNestedStringFlattened: h.isStringArray(
    std.flattenArrays([
      ['hello'],
      ['world'],
    ]),
  ),
}
