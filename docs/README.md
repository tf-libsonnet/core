---
permalink: /
---

# tf

```jsonnet
local tf = import "github.com/tf-libsonnet/core/main.libsonnet"
```

`tf` implements core utility functions for generating Terraform code.


## Index

* [`fn isStringArray(v)`](#fn-isstringarray)
* [`fn mergeAll(objs)`](#fn-mergeall)
* [`fn objItems(obj)`](#fn-objitems)
* [`fn objItemsAll(obj)`](#fn-objitemsall)
* [`fn withData(type, label, attrs, _meta={})`](#fn-withdata)
* [`fn withLocal(name, value)`](#fn-withlocal)
* [`fn withLocalList(locals)`](#fn-withlocallist)
* [`fn withLocalMap(map)`](#fn-withlocalmap)
* [`fn withModule(name, source, inpuuts, version='null', _meta={})`](#fn-withmodule)
* [`fn withOutput(name, value, description='null')`](#fn-withoutput)
* [`fn withOutputList(outputs)`](#fn-withoutputlist)
* [`fn withOutputMap(map)`](#fn-withoutputmap)
* [`fn withProvider(name, attrs, alias='null', src='null', version='null')`](#fn-withprovider)
* [`fn withResource(type, label, attrs, _meta={})`](#fn-withresource)
* [`fn withVariable(name, isRequired=true, type='null', description='null', default='null')`](#fn-withvariable)

## Fields

### fn isStringArray

```ts
isStringArray(v)
```

`isStringArray` returns `true` if the given value is an array with all elements as string.

Args:
- `v` (`any`): The value being evaluated.

Returns:
- A boolean indicating whether the given arg is a string array.


### fn mergeAll

```ts
mergeAll(objs)
```

`mergeAll` takes a list of objects and merges them together into a single object, processing the objects from left
to right. This is useful when you want to create many Terraform resources using list comprehension.

Args:
- `objs` (`list[obj]`): List of objects to be merged into one.

Returns:
- A single object that is the result of merging all the input objects together.


### fn objItems

```ts
objItems(obj)
```

`objItems` takes an object and returns a list of objects with two attributes:
- `k`: The object key being iterated.
- `v`: The object value being iterated.

This is useful when iterating the keys and values of an object. For example, if you had the object:

    {
      one: 1,
      two: 2,
      three: 3,
    }

You can create iterate the fields like so:

    [i.k + ' = ' + i.v for i in objItems(obj)]

Args:
- `obj` (`obj`): The object whose fields and values to iterate.

Returns:
- A list of objects with attributes k and v to denote the object keys and values.


### fn objItemsAll

```ts
objItemsAll(obj)
```

`objItemsAll` is like `objItems`, but also includes hidden fields.

Args:
- `obj` (`obj`): The object whose fields and values to iterate.

Returns:
- A list of objects with attributes k and v to denote the object keys and values.


### fn withData

```ts
withData(type, label, attrs, _meta={})
```

`withData` injects a new Terraform `data` source block into the root configuration.

Additionally, this inserts a private function into the \_ref attribute that generates references to attributes of the
data source. For example, if you added a new data source using:

    withData('azurerm_virtual_network', 'foo', {})

You can get the reference to the `id` field of the `azurerm_virtual_network` using the reference:

    $._ref.azurerm_virtual_network.foo.get('id')

NOTE: When chaining and merging multiple calls to `withResource`, `withData`, and `withModule`, you may not be
able to use `super`, `self`, or `$` to get the reference to `_ref`. Instead, make an explicit binding to the outer
object using `local`.

Args:
- `type` (`string`): The data source type to create (e.g., `aws_instance`, `local_file`, etc).
- `label` (`string`): The label to apply to the instance of the data source.
- `attrs` (`obj`): The attributes for the instance of the data source being created.
- `_meta` (`obj`): An optional meta-argument object that (see `meta.libsonnet`). Note that while technically you
                   can set the meta-arguments on the `attrs` object, it is recommended to use the `_meta` arg to
                   highlight the meta-arguments.

Returns:
- A mixin object that injects the new data source into the root Terraform configuration.


### fn withLocal

```ts
withLocal(name, value)
```

`withLocal` injects a new Terraform `local` definition into the root configuration.

Args:
- `name` (`string`): The name of the `local` to define.
- `value` (`any`): The value to bind to the `local`.

Returns:
- A mixin object that injects the new local into the root Terraform configuration.


### fn withLocalList

```ts
withLocalList(locals)
```

`withLocalList` injects the list of local configurations as Terraform `local` definitions in the root
configuration.

Args:
- `locals` (`list[obj]`): List of local configurations, where each element describes a `local`. Each element
                          should have the keys `n` (for `name`) and `v` (for `value`).

Returns:
- A mixin object that injects all the locals into the Terraform config.


### fn withLocalMap

```ts
withLocalMap(map)
```

`withLocalMap` injects all the key value pairs of the input map as Terraform `local` definitions in the root
configuration.

Args:
- `map` (`map[str, str]`): Map of local keys to local values.

Returns:
- A mixin object that injects all the key value pairs as locals.


### fn withModule

```ts
withModule(name, source, inpuuts, version='null', _meta={})
```

`withModule` injects a new `module` block into the root configuration.

Additionally, this inserts a private function into the \_ref attribute that generates references to attributes of the
module call. For example, if you added a new module call using:

    withModule('foo', 'some-source', {})

You can get the reference to the `id` output using the reference:

    $._ref.module.foo.get('id')

NOTE: When chaining and merging multiple calls to `withResource`, `withData`, and `withModule`, you may not be
able to use `super`, `self`, or `$` to get the reference to `_ref`. Instead, make an explicit binding to the outer
object using `local`.

Args:
- `name` (`string`): The name of the module block.
- `source` (`string`): The source for the module block.
- `inputs` (`obj`): The input values to pass into the module block.
- `version` (`string`): The version of the module source to pull in, if the module source references a registry.
                        When `null`, the `version` field is omitted from the resulting module block.
- `_meta` (`obj`): An optional meta-argument object that (see `meta.libsonnet`). Note that while technically you
                   can set the meta-arguments on the `inputs` object, it is recommended to use the `_meta` arg to
                   highlight the meta-arguments.

Returns:
- A mixin object that injects the new module block into the root Terraform configuration.


### fn withOutput

```ts
withOutput(name, value, description='null')
```

`withOutput` injects a new Terraform `output` block into the root configuration.

Args:
- `name` (`string`): The name of the output.
- `value` (`string`): The expression to bind to the output name.
- `description` (`string`): The description of the output. When `null`, the `description` field is omitted from
                            the object.

Returns:
- A mixin object that injects the new output into the root Terraform configuration.


### fn withOutputList

```ts
withOutputList(outputs)
```

`withOutputList` injects the list of output configurations as Terraform `output` blocks into the root
configuration.

Args:
- `outputs` (`list[obj]`): List of output configurations, where each element describes an `output` block. Each
                           element should have the keys `n` (for `name`), `v` (for `value`), and `d` (for
                           `description`).

Returns:
- A mixin object that injects all the outputs as output blocks.


### fn withOutputMap

```ts
withOutputMap(map)
```

`withOutputMap` injects all the key value pairs of the input map as Terraform `output` blocks into the root
configuration.

Args:
- `map` (`map[str, str]`): Map of output keys to output values.

Returns:
- A mixin object that injects all the key value pairs as output blocks.


### fn withProvider

```ts
withProvider(name, attrs, alias='null', src='null', version='null')
```

`withProvider` injects a new Terraform `provider` block into the root configuration

Args:
- `name` (`string`): The name of the provider to inject.
- `attrs` (`obj`): The attributes to apply to the provider block being injected.
- `alias` (`string`): The `alias` to bind to the provider block. When `null`, the `alias` attribute is omitted
                      from the provider attributes.
- `src` (`string`): Where to source the provider. If specified, an entry to `required_providers` will be added
                    specifying the source. If both `src` and `version` is `null`, the required_providers entry is
                    omitted.
- `version` (`string`): What `version` of the provider to use. If specified, an entry to `required_providers` will
                        be added specifying the version. If both `src` and `version` is `null`, the
                        `required_providers` entry is omitted.

Returns:
- A mixin object that injects the new provider block into the root Terraform configuration.


### fn withResource

```ts
withResource(type, label, attrs, _meta={})
```

`withResource` injects a new Terraform `resource` block into the root configuration.

Additionally, this inserts a private function into the \_ref attribute that generates references to attributes of the
resource. For example, if you added a new resource using:

    withResource('null_resource', 'foo', {})

You can get the reference to the `id` field of the `null_resource` using the reference:

    $._ref.null_resource.foo.get('id')

NOTE: When chaining and merging multiple calls to `withResource`, `withData`, and `withModule`, you may not be
able to use `super`, `self`, or `$` to get the reference to `_ref`. Instead, make an explicit binding to the outer
object using `local`.

Args:
- `type` (`string`): The resource type to create (e.g., `aws_instance`, `null_resource`, etc).
- `label` (`string`): The label to apply to the instance of the resource.
- `attrs` (`obj`): The attributes for the instance of the resource being created.
- `_meta` (`obj`): An optional meta-argument object that (see `meta.libsonnet`). Note that while technically you
                   can set the meta-arguments on the `attrs` object, it is recommended to use the `_meta` arg to
                   highlight the meta-arguments.

Returns:
- A mixin object that injects the new resource into the root Terraform configuration.


### fn withVariable

```ts
withVariable(name, isRequired=true, type='null', description='null', default='null')
```

`withVariable` injects a new Terraform `variable` block into the root configuration.

Args:
- `name` (`string`): The name of the variable.
- `isRequired` (`bool`): Whether the variable is required. When `true`, the `default` value is omitted from the
                         object.
- `type` (`string`): The type of the variable. When `null`, the `type` field is omitted from the object.
- `description` (`string`): The description of the variable. When `null`, the `description` field is omitted from the object.
- `default` (`any`): The default value of the variable. Omitted when `isRequired` is `true`.

Returns:
- A mixin object that injects the new variable into the root Terraform configuration.
