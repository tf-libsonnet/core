local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

local h = import './helpers.libsonnet';

local withProviderDoc =
  d.fn(
    |||
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
    |||,
    [
      d.arg('name', d.T.string),
      d.arg('attrs', d.T.object),
      d.arg('alias', d.T.string, d.T.nil),
      d.arg('src', d.T.string, d.T.nil),
      d.arg('version', d.T.string, d.T.nil),
    ],
  );
local withProvider(name, attrs, alias=null, src=null, version=null) =
  local maybeAlias =
    if alias != null then
      { alias: alias }
    else
      {};

  local maybeRequiredProviders =
    if src != null || version != null then
      {
        terraform+: {
          required_providers+: {
            [name]: (
              if src != null then
                { source: src }
              else
                {}
            ) + (
              if version != null then
                { version: version }
              else
                {}
            ),
          },
        },
      }
    else
      {};

  {
    provider+: {
      [name]+: [
        maybeAlias + attrs,
      ],
    },
  }
  + maybeRequiredProviders;


local withResourceDoc =
  d.fn(
    |||
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
    |||,
    [
      d.arg('type', d.T.string),
      d.arg('label', d.T.string),
      d.arg('attrs', d.T.object),
      d.arg('_meta', d.T.object, {}),
    ],
  );
// TODO: add type checking for _meta
local withResource(type, label, attrs, _meta={}) = {
  resource+: {
    [type]+: {
      [label]: (
        attrs
        + _meta
      ),
    },
  },

  _ref+:: {
    [type]+:: {
      [label]:: {
        getRef:: function(attr) (
          type + '.' + label + '.' + attr
        ),
        get:: function(attr) (
          '${' + self.getRef(attr) + '}'
        ),
      },
    },
  },
};


local withDataDoc =
  d.fn(
    |||
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
    |||,
    [
      d.arg('type', d.T.string),
      d.arg('label', d.T.string),
      d.arg('attrs', d.T.object),
      d.arg('_meta', d.T.object, {}),
    ],
  );
local withData(type, label, attrs, _meta={}) = {
  data+: {
    [type]+: {
      [label]: (
        attrs
        + _meta
      ),
    },
  },

  _ref+:: {
    data+:: {
      [type]+:: {
        [label]:: {
          getRef:: function(attr) (
            'data.' + type + '.' + label + '.' + attr
          ),
          get:: function(attr) (
            '${' + self.getRef(attr) + '}'
          ),
        },
      },
    },
  },
};


local withModuleDoc =
  d.fn(
    |||
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
    |||,
    [
      d.arg('name', d.T.string),
      d.arg('source', d.T.string),
      d.arg('inpuuts', d.T.object),
      d.arg('version', d.T.string, d.T.nil),
      d.arg('_meta', d.T.object, {}),
    ],
  );
// TODO: add type checking for _meta
local withModule(name, source, inputs, version=null, _meta={}) =
  local maybeVersion =
    if version != null then
      { version: version }
    else
      {};

  {
    module+: {
      [name]:
        { source: source }
        + maybeVersion
        + inputs
        + _meta,
    },

    _ref+:: {
      module+:: {
        [name]:: {
          getRef:: function(attr) (
            'module.' + name + '.' + attr
          ),
          get:: function(attr) (
            '${' + self.getRef(attr) + '}'
          ),
        },
      },
    },
  };


local withVariableDoc =
  d.fn(
    |||
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
    |||,
    [
      d.arg('name', d.T.string),
      d.arg('isRequired', d.T.bool, true),
      d.arg('type', d.T.string, d.T.nil),
      d.arg('description', d.T.string, d.T.nil),
      d.arg('default', d.T.any, d.T.nil),
    ],
  );
// MAINTAINER'S NOTE: The isRequired field is necessary to support emitting null as a default value for the variable, as
// opposed to omitting the default field.
local withVariable(name, isRequired=true, type=null, description=null, default=null) =
  local maybeType =
    if type != null then
      { type: type }
    else
      {};
  local maybeDescription =
    if description != null then
      { description: description }
    else
      {};
  local maybeDefault =
    if !isRequired then
      { default: default }
    else
      {};

  {
    variable+: {
      [name]:
        maybeType
        + maybeDescription
        + maybeDefault,
    },
  };


local withOutputDoc =
  d.fn(
    |||
      `tf.withOutput` injects a new Terraform `output` block into the root configuration.

      **Args**:
      - `name` (`string`): The name of the output.
      - `value` (`string`): The expression to bind to the output name.
      - `description` (`string`): The description of the output. When `null`, the `description` field is omitted from
                                  the object.
      - `sensitive` (`bool`): Whether the output contains sensitive information. When `null`, the `sensitive` field is
                              omitted from the object.

      **Returns**:
      - A mixin object that injects the new output into the root Terraform configuration.
    |||,
    [
      d.arg('name', d.T.string),
      d.arg('value', d.T.string),
      d.arg('description', d.T.string, d.T.nil),
      d.arg('sensitive', d.T.bool, d.T.nil),
    ],
  );
local withOutput(name, value, description=null, sensitive=null) =
  local maybeDescription =
    if description != null then
      { description: description }
    else
      {};

  local maybeSensitive =
    if sensitive != null then
      { sensitive: sensitive }
    else
      {};

  {
    output+: {
      [name]:
        { value: value }
        + maybeDescription
        + maybeSensitive,
    },
  };


local withOutputMapDoc =
  d.fn(
    |||
      `tf.withOutputMap` injects all the key value pairs of the input map as Terraform `output` blocks into the root
      configuration.

      **Args**:
      - `map` (`map[str, str]`): Map of output keys to output values.

      **Returns**:
      - A mixin object that injects all the key value pairs as output blocks.
    |||,
    [
      d.arg('map', d.T.object),
    ],
  );
local withOutputMap(map) =
  h.mergeAll([
    withOutput(i.k, i.v)
    for i in h.objItems(map)
  ]);


local withSensitiveOutputMapDoc =
  d.fn(
    |||
      `tf.withSensitiveOutputMap` injects all the key value pairs of the input map as Terraform `output` blocks with
      `sensitive` set to `true` into the root configuration.

      **Args**:
      - `map` (`map[str, str]`): Map of output keys to output values.

      **Returns**:
      - A mixin object that injects all the key value pairs as output blocks.
    |||,
    [
      d.arg('map', d.T.object),
    ],
  );
local withSensitiveOutputMap(map) =
  h.mergeAll([
    withOutput(i.k, i.v, sensitive=true)
    for i in h.objItems(map)
  ]);


local withOutputListDoc =
  d.fn(
    |||
      `withOutputList` injects the list of output configurations as Terraform `output` blocks into the root
      configuration.

      **Args**:
      - `outputs` (`list[obj]`): List of output configurations, where each element describes an `output` block. Each
                                 element should have the keys `n` (for `name`), `v` (for `value`), `d` (for
                                 `description`), and `s` (for `sensitive`).

      **Returns**:
      - A mixin object that injects all the outputs as output blocks.
    |||,
    [
      d.arg('outputs', d.T.array),
    ],
  );
local withOutputList(outputs) =
  h.mergeAll([
    withOutput(o.n, o.v, std.get(o, 'd', null), std.get(o, 's', null))
    for o in outputs
  ]);


local withLocalDoc =
  d.fn(
    |||
      `tf.withLocal` injects a new Terraform `local` definition into the root configuration.

      **Args**:
      - `name` (`string`): The name of the `local` to define.
      - `value` (`any`): The value to bind to the `local`.

      **Returns**:
      - A mixin object that injects the new local into the root Terraform configuration.
    |||,
    [
      d.arg('name', d.T.string),
      d.arg('value', d.T.any),
    ],
  );
local withLocal(name, value) = {
  locals+: {
    [name]: value,
  },
};


local withLocalMapDoc =
  d.fn(
    |||
      `tf.withLocalMap` injects all the key value pairs of the input map as Terraform `local` definitions in the root
      configuration.

      **Args**:
      - `map` (`map[str, str]`): Map of local keys to local values.

      **Returns**:
      - A mixin object that injects all the key value pairs as locals.
    |||,
    [
      d.arg('map', d.T.object),
    ],
  );
local withLocalMap(map) =
  h.mergeAll([
    withLocal(i.k, i.v)
    for i in h.objItems(map)
  ]);


local withLocalListDoc =
  d.fn(
    |||
      `tf.withLocalList` injects the list of local configurations as Terraform `local` definitions in the root
      configuration.

      **Args**:
      - `locals` (`list[obj]`): List of local configurations, where each element describes a `local`. Each element
                                should have the keys `n` (for `name`) and `v` (for `value`).

      **Returns**:
      - A mixin object that injects all the locals into the Terraform config.
    |||,
    [
      d.arg('locals', d.T.array),
    ],
  );
local withLocalList(locals) =
  h.mergeAll([
    withLocal(l.n, l.v)
    for l in locals
  ]);


{
  '#withProvider':: withProviderDoc,
  withProvider:: withProvider,
  '#withResource':: withResourceDoc,
  withResource:: withResource,
  '#withData':: withDataDoc,
  withData:: withData,
  '#withModule':: withModuleDoc,
  withModule:: withModule,
  '#withVariable':: withVariableDoc,
  withVariable:: withVariable,
  '#withOutput':: withOutputDoc,
  withOutput:: withOutput,
  '#withOutputMap':: withOutputMapDoc,
  withOutputMap:: withOutputMap,
  '#withSensitiveOutputMap':: withSensitiveOutputMapDoc,
  withSensitiveOutputMap:: withSensitiveOutputMap,
  '#withOutputList':: withOutputListDoc,
  withOutputList:: withOutputList,
  '#withLocal':: withLocalDoc,
  withLocal:: withLocal,
  '#withLocalMap':: withLocalMapDoc,
  withLocalMap:: withLocalMap,
  '#withLocalList':: withLocalListDoc,
  withLocalList:: withLocalList,
}
