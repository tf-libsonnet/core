// Meta-argument constructor functions. Refer to the meta-arguments tab on
// https://developer.hashicorp.com/terraform/language for more information.
//
// This can be used as arguments to the `_meta` parameter for any resource
// or data source constructor generated by libgenerator.

local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';

local h = import './helpers.libsonnet';

local newMetaDoc =
  d.fn(
    |||
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
      - `connection` (`obj`): Set the `connection` meta-argument blocks on the resulting block. When
                              `null`, there will be no `provisioner` blocks added. It is recommended to generate
                              this using in [tf.meta.provisioner.connection.new](#obj-metaprovisionerconnectionnew).
      - `provisioner` (`list[obj]`): Set the list of `provisioner` meta-argument blocks on the resulting block. When
                                     `null`, there will be no `provisioner` blocks added. It is recommended to generate
                                     this using functions in [tf.meta.provisioner](#obj-metaprovisioner).

      **Returns**:
      - A mixin that can be merged with a resource or data source object to set meta-arguments.
    |||,
    [
      d.arg('count', d.T.number, d.T.nil),
      d.arg('depends_on', d.T.array, d.T.nil),
      d.arg('for_each', d.T.array, d.T.nil),
      d.arg('provider', d.T.string, d.T.nil),
      d.arg('lifecycle', d.T.object, d.T.nil),
      d.arg('connection', d.T.object, d.T.nil),
      d.arg('provisioner', d.T.array, d.T.nil),
    ],
  );
local newMeta(count=null, depends_on=null, for_each=null, provider=null, lifecycle=null, connection=null, provisioner=null) =
  local maybeCount =
    if count != null then
      { count: count }
    else
      {};

  local maybeDependsOn =
    if depends_on != null then
      { depends_on: depends_on }
    else
      {};

  local maybeForEach =
    if for_each != null then
      { for_each: for_each }
    else
      {};

  local maybeProvider =
    if provider != null then
      { provider: provider }
    else
      {};

  local maybeLifecycle =
    if lifecycle != null then
      { lifecycle: lifecycle }
    else
      {};

  local maybeConnection =
    if connection != null then
      { connection: connection }
    else
      {};

  local maybeProvisioner =
    if provisioner != null then
      { provisioner: provisioner }
    else
      {};

  maybeCount
  + maybeDependsOn
  + maybeForEach
  + maybeProvider
  + maybeLifecycle
  + maybeConnection
  + maybeProvisioner;


local newModuleMetaDoc =
  d.fn(
    |||
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
    |||,
    [
      d.arg('count', d.T.number, d.T.nil),
      d.arg('depends_on', d.T.array, d.T.nil),
      d.arg('for_each', d.T.array, d.T.nil),
      d.arg('providers', d.T.object, d.T.nil),
    ],
  );
local newModuleMeta(count=null, depends_on=null, for_each=null, providers=null) =
  local maybeCount =
    if count != null then
      { count: count }
    else
      {};

  local maybeDependsOn =
    if depends_on != null then
      { depends_on: depends_on }
    else
      {};

  local maybeForEach =
    if for_each != null then
      { for_each: for_each }
    else
      {};

  local maybeProviders =
    if providers != null then
      if std.isObject(providers) then
        { providers: providers }
      else
        error 'providers meta argument must be a map'
    else
      {};

  maybeCount
  + maybeDependsOn
  + maybeForEach
  + maybeProviders;


local newLifecycleDoc =
  d.fn(
    |||
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
    |||,
    [
      d.arg('create_before_destroy', d.T.bool, d.T.nil),
      d.arg('prevent_destroy', d.T.bool, d.T.nil),
      d.arg('ignore_changes', d.T.array, d.T.nil),
      d.arg('replace_triggered_by', d.T.array, d.T.nil),
      d.arg('precondition', d.T.array, d.T.nil),
      d.arg('postcondition', d.T.array, d.T.nil),
    ],
  );
local newLifecycle(
  create_before_destroy=null,
  prevent_destroy=null,
  ignore_changes=null,
  replace_triggered_by=null,
  precondition=null,
  postcondition=null,
      ) =
  local maybeCreateBeforeDestroy =
    if create_before_destroy != null then
      if std.isBoolean(create_before_destroy) then
        { create_before_destroy: create_before_destroy }
      else
        error 'lifecycle meta argument attr create_before_destroy must be a boolean'
    else
      {};

  local maybePreventDestroy =
    if prevent_destroy != null then
      if std.isBoolean(prevent_destroy) then
        { prevent_destroy: prevent_destroy }
      else
        error 'lifecycle meta argument attr prevent_destroy must be a boolean'
    else
      {};

  local maybeIgnoreChanges =
    if ignore_changes != null then
      if h.isStringArray(ignore_changes) then
        { ignore_changes: ignore_changes }
      else
        error 'lifecycle meta argument attr ignore_changes must be a string array'
    else
      {};

  local maybeReplaceTriggeredBy =
    if replace_triggered_by != null then
      if h.isStringArray(replace_triggered_by) then
        { replace_triggered_by: replace_triggered_by }
      else
        error 'lifecycle meta argument attr replace_triggered_by must be a string array'
    else
      {};

  local maybePrecondition =
    if precondition != null then
      if std.isArray(precondition) then
        { precondition: precondition }
      else
        error 'lifecycle meta argument attr precondition must be an array of condition blocks'
    else
      {};

  local maybePostcondition =
    if postcondition != null then
      if std.isArray(postcondition) then
        { postcondition: postcondition }
      else
        error 'lifecycle meta argument attr postcondition must be an array of condition blocks'
    else
      {};

  maybeCreateBeforeDestroy
  + maybePreventDestroy
  + maybeIgnoreChanges
  + maybeReplaceTriggeredBy
  + maybePrecondition
  + maybePostcondition;


local newConditionDoc =
  d.fn(
    |||
      `tf.meta.lifecycle.condition.new` will generate a new `condition` block that can be used as part of `precondition`
      or `postcondition` in the `lifecycle` block.

      **Args**:
      - `condition` (`string`): Set the `condition` attribute on the block. This should be a Terraform expression
                                escaped with `${}`.
      - `error_message` (`string`): Set the `error_message` attribute on the block.

      **Returns**:
      - An object that can be used as a `precondition` or `postcondition` subblock for a `lifecycle` block.
    |||,
    [
      d.arg('condition', d.T.string),
      d.arg('error_message', d.T.string),
    ],
  );
local newCondition(condition, error_message) =
  {
    condition: condition,
    error_message: error_message,
  };


// root object
{
  meta:: {
    '#new':: newMetaDoc,
    new:: newMeta,
    '#newForModule':: newModuleMetaDoc,
    newForModule:: newModuleMeta,
    lifecycle:: {
      '#new':: newLifecycleDoc,
      new:: newLifecycle,
      condition:: {
        '#new':: newConditionDoc,
        new:: newCondition,
      },
    },
    provisioner:: (import './meta_provisioner.libsonnet'),
  },
}
