// mergeAll takes a list of objects and merges them together into a single object, processing the objects from left to
// right. This is useful when you want to create many Terraform resources using list comprehension.
//
// Args:
//   objs (list[obj]): List of objects to be merged into one.
//
// Returns:
//   A single object that is the result of merging all the input objects together.
local mergeAll(objs) = std.foldl(
  function(x, y) (x + y),
  objs,
  {},
);


// objItems takes an object and returns a list of objects with two attributes:
// - k: The object key being iterated.
// - v: The object value being iterated.
//
// This is useful when iterating the keys and values of an object. For example, if you had the object:
//
// {
//   one: 1,
//   two: 2,
//   three: 3,
// }
//
// You can create iterate the fields like so:
//   [i.k + ' = ' + i.v for i in objItems(obj)]
//
// Args:
//   obj (obj): The object whose fields and values to iterate.
//
// Returns:
//   A list of objects with attributes k and v to denote the object keys and values.
local objItems(obj) =
  [
    { k: k, v: std.get(obj, k) }
    for k in std.objectFields(obj)
  ];


// objItemsAll is like objItems, but also includes hidden fields.
//
// Args:
//   obj (obj): The object whose fields and values to iterate.
//
// Returns:
//   A list of objects with attributes k and v to denote the object keys and values.
local objItemsAll(obj) =
  [
    { k: k, v: std.get(obj, k) }
    for k in std.objectFieldsAll(obj)
  ];


// isStringArray returns true if the given value is an array with all elements as string.
//
// Args:
//   v (any): The value being evaluated.
//
// Returns:
//   A boolean indicating whether the given arg is a string array.
local isStringArray(v) =
  std.isArray(v)
  && (
    // We temporarily avoid using std.all since the linter does not support it.
    std.foldl(
      function(x, y) (x && y),
      [
        std.isString(i)
        for i in v
      ],
      true,
    )
  );


{
  mergeAll:: mergeAll,
  objItems:: objItems,
  objItemsAll:: objItemsAll,
  isStringArray:: isStringArray,
}
