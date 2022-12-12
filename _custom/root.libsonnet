// withProvider injects a new Terraform provider block into the root configuration.
//
// Args:
//   name (string): The name of the provider to inject.
//   attrs (obj): The attributes to apply to the provider block being injected.
//   alias (string): The alias to bind to the provider block. When null, the alias attribute is omitted from the
//                   provider attributes.
//
// Returns:
//   A mixin object that injects the new provider block into the root Terraform configuration.
local withProvider(name, attrs, alias=null) =
  local maybeAlias =
    if alias != null then
      { alias: alias }
    else
      {};

  {
    provider+: {
      [name]+: [
        maybeAlias + attrs,
      ],
    },
  };


// withResource injects a new Terraform resource block into the root configuration.
//
// Args:
//   type (string): The resource type to create (e.g., aws_instance, null_resource, etc).
//   label (string): The label to apply to the instance of the resource.
//   attrs (obj): The attributes for the instance of the resource being created.
//
// Returns:
//   A mixin object that injects the new resource into the root Terraform configuration.
local withResource(type, label, attrs) = {
  resource+: {
    [type]+: {
      [label]: attrs,
    },
  },
};


// withData injects a new Terraform data source block into the root configuration.
//
// Args:
//   type (string): The data source type to create (e.g., aws_instance, local_file, etc).
//   label (string): The label to apply to the instance of the data source.
//   attrs (obj): The attributes for the instance of the data source to read.
//
// Returns:
//   A mixin object that injects the new data source into the root Terraform configuration.
local withData(type, label, attrs) = {
  data+: {
    [type]+: {
      [label]: attrs,
    },
  },
};


// withModule injects a new module block into the root configuration.
//
// Args:
//   name (string): The name of the module block.
//   source (string): The source for the module block.
//   inputs (obj): The input values to pass into the module block.
//   version (string): The version of the module source to pull in, if the module source references a registry. When
//                     null, the version field is omitted from the resulting module block.
//
// Returns:
//   A mixin object that injects the new module block into the root Terraform configuration.
local withModule(name, source, inputs, version=null) =
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
        + inputs,
    },
  };


// withVariable injects a new Terraform variable block into the root configuration.
//
// Args:
//   name (string): The name of the variable.
//   isRequired (bool): Whether the variable is required. When true, the default value is omitted from the object.
//   type (string): The type of the variable. When null, the type field is omitted from the object.
//   description (string): The description of the variable. When null, the description field is omitted from the object.
//   default (any): The default value of the variable. Omitted when isRequired is true.
//
// Returns:
//   A mixin object that injects the new variable into the root Terraform configuration.
//
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


// withOutput injects a new Terraform output block into the root configuration.
//
// Args:
//   name (string): The name of the output.
//   value (string): The expression to bind to the output name.
//   description (string): The description of the output. When null, the description field is omitted from the object.
//
// Returns:
//   A mixin object that injects the new output into the root Terraform configuration.
local withOutput(name, value, description=null) =
  local maybeDescription =
    if description != null then
      { description: description }
    else
      {};

  {
    output+: {
      [name]:
        { value: value }
        + maybeDescription,
    },
  };


// withLocal injects a new Terraform local definition into the root configuration.
//
// Args:
//   name (string): The name of the local to define.
//   value (any): The value to bind to the local.
//
// Returns:
//   A mixin object that injects the new local into the root Terraform configuration.
local withLocal(name, value) = {
  'local'+: {
    [name]: value,
  },
};


{
  withProvider:: withProvider,
  withResource:: withResource,
  withData:: withData,
  withModule:: withModule,
  withVariable:: withVariable,
  withOutput:: withOutput,
  withLocal:: withLocal,
}
