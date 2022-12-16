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
* [`obj meta`](#obj-meta)
  * [`fn new(count='null', depends_on='null', for_each='null', provider='null', lifecycle='null')`](#fn-metanew)
  * [`fn newForModule(count='null', depends_on='null', for_each='null', providers='null')`](#fn-metanewformodule)
  * [`obj meta.lifecycle`](#obj-metalifecycle)
    * [`fn new(create_before_destroy='null', prevent_destroy='null', ignore_changes='null', replace_triggered_by='null', precondition='null', postcondition='null')`](#fn-metalifecyclenew)
    * [`obj meta.lifecycle.condition`](#obj-metalifecyclecondition)
      * [`fn new(condition, error_message)`](#fn-metalifecycleconditionnew)

## Fields

### fn isStringArray

```ts
isStringArray(v)
```

`tf.isStringArray` returns `true` if the given value is an array with all elements as string.

**Args**:
- `v` (`any`): The value being evaluated.

**Returns**:
- A boolean indicating whether the given arg is a string array.


### fn mergeAll

```ts
mergeAll(objs)
```

`tf.mergeAll` takes a list of objects and merges them together into a single object, processing the objects from left
to right. This is useful when you want to create many Terraform resources using list comprehension.

**Args**:
- `objs` (`list[obj]`): List of objects to be merged into one.

**Returns**:
- A single object that is the result of merging all the input objects together.


### fn objItems

```ts
objItems(obj)
```

`tf.objItems` takes an object and returns a list of objects with two attributes:
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

**Args**:
- `obj` (`obj`): The object whose fields and values to iterate.

**Returns**:
- A list of objects with attributes k and v to denote the object keys and values.


### fn objItemsAll

```ts
objItemsAll(obj)
```

`tf.objItemsAll` is like `objItems`, but also includes hidden fields.

**Args**:
- `obj` (`obj`): The object whose fields and values to iterate.

**Returns**:
- A list of objects with attributes k and v to denote the object keys and values.


### fn withData

```ts
withData(type, label, attrs, _meta={})
```

`tf.withData` injects a new Terraform `data` source block into the root configuration.

Additionally, this inserts a private function into the \_ref attribute that generates references to attributes of the
data source. For example, if you added a new data source using:

    withData('azurerm_virtual_network', 'foo', {})

You can get the reference to the `id` field of the `azurerm_virtual_network` using the reference:

    $._ref.azurerm_virtual_network.foo.get('id')

NOTE: When chaining and merging multiple calls to [withResource](#fn-withresource), [withData](#fn-withdata), and
[withModule](#fn-withmodule), you may not be able to use `super`, `self`, or `$` to get the reference to `_ref`.
Instead, make an explicit binding to the outer object using `local`.

**Args**:
- `type` (`string`): The data source type to create (e.g., `aws_instance`, `local_file`, etc).
- `label` (`string`): The label to apply to the instance of the data source.
- `attrs` (`obj`): The attributes for the instance of the data source being created.
- `_meta` (`obj`): An optional meta-argument object that (see `meta.libsonnet`). Note that while technically you
                   can set the meta-arguments on the `attrs` object, it is recommended to use the `_meta` arg to
                   highlight the meta-arguments.

**Returns**:
- A mixin object that injects the new data source into the root Terraform configuration.


### fn withLocal

```ts
withLocal(name, value)
```

`tf.withLocal` injects a new Terraform `local` definition into the root configuration.

**Args**:
- `name` (`string`): The name of the `local` to define.
- `value` (`any`): The value to bind to the `local`.

**Returns**:
- A mixin object that injects the new local into the root Terraform configuration.


### fn withLocalList

```ts
withLocalList(locals)
```

`tf.withLocalList` injects the list of local configurations as Terraform `local` definitions in the root
configuration.

**Args**:
- `locals` (`list[obj]`): List of local configurations, where each element describes a `local`. Each element
                          should have the keys `n` (for `name`) and `v` (for `value`).

**Returns**:
- A mixin object that injects all the locals into the Terraform config.


### fn withLocalMap

```ts
withLocalMap(map)
```

`tf.withLocalMap` injects all the key value pairs of the input map as Terraform `local` definitions in the root
configuration.

**Args**:
- `map` (`map[str, str]`): Map of local keys to local values.

**Returns**:
- A mixin object that injects all the key value pairs as locals.


### fn withModule

```ts
withModule(name, source, inpuuts, version='null', _meta={})
```

`tf.withModule` injects a new `module` block into the root configuration.

Additionally, this inserts a private function into the \_ref attribute that generates references to attributes of the
module call. For example, if you added a new module call using:

    withModule('foo', 'some-source', {})

You can get the reference to the `id` output using the reference:

    $._ref.module.foo.get('id')

NOTE: When chaining and merging multiple calls to [withResource](#fn-withresource), [withData](#fn-withdata), and
[withModule](#fn-withmodule), you may not be able to use `super`, `self`, or `$` to get the reference to `_ref`.
Instead, make an explicit binding to the outer object using `local`.

**Args**:
- `name` (`string`): The name of the module block.
- `source` (`string`): The source for the module block.
- `inputs` (`obj`): The input values to pass into the module block.
- `version` (`string`): The version of the module source to pull in, if the module source references a registry.
                        When `null`, the `version` field is omitted from the resulting module block.
- `_meta` (`obj`): An optional meta-argument object that (see `meta.libsonnet`). Note that while technically you
                   can set the meta-arguments on the `inputs` object, it is recommended to use the `_meta` arg to
                   highlight the meta-arguments.

**Returns**:
- A mixin object that injects the new module block into the root Terraform configuration.


### fn withOutput

```ts
withOutput(name, value, description='null')
```

`tf.withOutput` injects a new Terraform `output` block into the root configuration.

**Args**:
- `name` (`string`): The name of the output.
- `value` (`string`): The expression to bind to the output name.
- `description` (`string`): The description of the output. When `null`, the `description` field is omitted from
                            the object.

**Returns**:
- A mixin object that injects the new output into the root Terraform configuration.


### fn withOutputList

```ts
withOutputList(outputs)
```

`withOutputList` injects the list of output configurations as Terraform `output` blocks into the root
configuration.

**Args**:
- `outputs` (`list[obj]`): List of output configurations, where each element describes an `output` block. Each
                           element should have the keys `n` (for `name`), `v` (for `value`), and `d` (for
                           `description`).

**Returns**:
- A mixin object that injects all the outputs as output blocks.


### fn withOutputMap

```ts
withOutputMap(map)
```

`tf.withOutputMap` injects all the key value pairs of the input map as Terraform `output` blocks into the root
configuration.

**Args**:
- `map` (`map[str, str]`): Map of output keys to output values.

**Returns**:
- A mixin object that injects all the key value pairs as output blocks.


### fn withProvider

```ts
withProvider(name, attrs, alias='null', src='null', version='null')
```

`tf.withProvider` injects a new Terraform `provider` block into the root configuration

**Args**:
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

**Returns**:
- A mixin object that injects the new provider block into the root Terraform configuration.


### fn withResource

```ts
withResource(type, label, attrs, _meta={})
```

`tf.withResource` injects a new Terraform `resource` block into the root configuration.

Additionally, this inserts a private function into the \_ref attribute that generates references to attributes of the
resource. For example, if you added a new resource using:

    withResource('null_resource', 'foo', {})

You can get the reference to the `id` field of the `null_resource` using the reference:

    $._ref.null_resource.foo.get('id')

NOTE: When chaining and merging multiple calls to [withResource](#fn-withresource), [withData](#fn-withdata), and
[withModule](#fn-withmodule), you may not be able to use `super`, `self`, or `$` to get the reference to `_ref`.
Instead, make an explicit binding to the outer object using `local`.

**Args**:
- `type` (`string`): The resource type to create (e.g., `aws_instance`, `null_resource`, etc).
- `label` (`string`): The label to apply to the instance of the resource.
- `attrs` (`obj`): The attributes for the instance of the resource being created.
- `_meta` (`obj`): An optional meta-argument object that (see `meta.libsonnet`). Note that while technically you
                   can set the meta-arguments on the `attrs` object, it is recommended to use the `_meta` arg to
                   highlight the meta-arguments.

**Returns**:
- A mixin object that injects the new resource into the root Terraform configuration.


### fn withVariable

```ts
withVariable(name, isRequired=true, type='null', description='null', default='null')
```

`tf.withVariable` injects a new Terraform `variable` block into the root configuration.

**Args**:
- `name` (`string`): The name of the variable.
- `isRequired` (`bool`): Whether the variable is required. When `true`, the `default` value is omitted from the
                         object.
- `type` (`string`): The type of the variable. When `null`, the `type` field is omitted from the object.
- `description` (`string`): The description of the variable. When `null`, the `description` field is omitted from the object.
- `default` (`any`): The default value of the variable. Omitted when `isRequired` is `true`.

**Returns**:
- A mixin object that injects the new variable into the root Terraform configuration.


## obj meta



### fn meta.new

```ts
new(count='null', depends_on='null', for_each='null', provider='null', lifecycle='null')
```

`tf.meta.new` will generate an object that can be mixed into any resource or data source to set the Terraform meta
arguments. This can be passed in as the `_meta` parameter for any call to [tf.withResource](#fn-withresource] or
[tf.withData](#fn-withdata).

Note that this is for resources and data sources. If you wish to generate meta-arguments for a module block, use
the [tf.meta.newForModule](#fn-metanewformodule) function.

Refer to the meta-arguments tab on the [Terraform language
reference](https://developer.hashicorp.com/terraform/language) for more information.

**Args**:
- `count` (`number`): Set the `count` meta-argument on the block. When `null`, the `count` attribute is omitted.
- `depends_on` (`list[str]` or `string`): Set the `depends_on` meta-argument on the block. When `null`, the
                                          `depends_on` attribute is omitted. This can be a string if using
                                          interpolation in the resulting Terraform.
- `for_each` (`map[str, any]`, `list[any]` or `string`): Set the `for_each` meta-argument on the block. When
                                                         `null`, the `for_each` attribute is omitted. This can be
                                                         a string if using interpolation in the resulting
                                                         Terraform.
- `provider` (`string`): Set the `provider` meta-argument on the block. When `null`, the `provider` attribute is
                         omitted.
- `lifecycle` (`obj`): Set the `lifecycle` meta-argument block on the resulting block. When `null`, the
                       `lifecycle` block is omitted. It is recommended to generate this using
                       [tf.meta.lifecycle.new](#fn-metalifecyclenew).

**Returns**:
- A mixin that can be merged with a resource or data source object to set meta-arguments.


### fn meta.newForModule

```ts
newForModule(count='null', depends_on='null', for_each='null', providers='null')
```

`tf.meta.newForModule` will generate an object that can be mixed into any module block to set the Terraform meta
arguments. This can be passed in as the `_meta` parameter for any call to [tf.withModule](#fn-withmodule].

Note that this is for module calls. If you wish to generate meta-arguments for a resource or data source block,
use the [tf.meta.new](#fn-metanew) function.

Refer to the meta-arguments tab on the [Terraform language
reference](https://developer.hashicorp.com/terraform/language) for more information.

**Args**:
- `count` (`number`): Set the `count` meta-argument on the block. When `null`, the `count` attribute is omitted.
- `depends_on` (`list[str]` or `string`): Set the `depends_on` meta-argument on the block. When `null`, the
                                          `depends_on` attribute is omitted. This can be a string if using
                                          interpolation in the resulting Terraform.
- `for_each` (`map[str, any]`, `list[any]` or `string`): Set the `for_each` meta-argument on the block. When
                                                         `null`, the `for_each` attribute is omitted. This can be
                                                         a string if using interpolation in the resulting
                                                         Terraform.
- `providers` (`map[str, str]`): Set the `providers` meta-argument on the block. When `null`, the `providers`
                                 attribute is omitted.

**Returns**:
- A mixin that can be merged with a resource or data source object to set meta-arguments.


## obj meta.lifecycle



### fn meta.lifecycle.new

```ts
new(create_before_destroy='null', prevent_destroy='null', ignore_changes='null', replace_triggered_by='null', precondition='null', postcondition='null')
```

`tf.meta.lifecycle.new` will generate a new `lifecycle` block.

Note that unlike the other functions, this includes type checking due to the Terraform requirement that the
lifecycle block only supports literal values only. As such, it is easier to do a type check on the args since
there is no possibility to use complex Terraform expressions (which will reduce to a string type in jsonnet).

**Args**:
- `create_before_destroy` (`bool`): Set `create_before_destroy` on the block. When `null`, the
                                    `create_before_destroy` attribute is omitted.
- `prevent_destroy` (`bool`): Set `prevent_destroy` on the block. When `null`, the `prevent_destroy` attribute is
                              omitted.
- `ignore_changes` (`list[str]`): Set `ignore_changes` on the block. When `null`, the `ignore_changes` attribute
                                  is omitted.
- `replace_triggered_by` (`list[str]`): Set `replace_triggered_by` on the block. When `null`, the
                                       `replace_triggered_by` attribute is omitted.
- `precondition` (`list[object]`): Set `precondition` subblocks on the block. When `null`, no `precondition`
                                   subblocks will be rendered. It is recommended to construct this using
                                   [tf.meta.lifecycle.condition.new](#fn-metalifecycleconditionnew).
- `postcondition` (`list[object]`): Set `postcondition` subblocks on the block. When `null`, no `postcondition`
                                   subblocks will be rendered. It is recommended to construct this using
                                   [tf.meta.lifecycle.condition.new](#fn-metalifecycleconditionnew).

**Returns**:
- A mixin that can be merged with a meta-argument block to set the `lifecycle` block.


## obj meta.lifecycle.condition



### fn meta.lifecycle.condition.new

```ts
new(condition, error_message)
```

`tf.meta.lifecycle.condition.new` will generate a new `condition` block that can be used as part of `precondition`
or `postcondition` in the `lifecycle` block.

**Args**:
- `condition` (`string`): Set the `condition` attribute on the block. This should be a Terraform expression
                          escaped with `${}`.
- `error_message` (`string`): Set the `error_message` attribute on the block.

**Returns**:
- A mixin that can be used as a `precondition` or `postcondition` subblock for a `lifecycle` block.
