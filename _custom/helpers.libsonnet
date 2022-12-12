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


{
  mergeAll:: mergeAll,
}
