// Provisioner meta-argument constructor functions. Refer to
// https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax
// for more information.

local d = import 'github.com/jsonnet-libs/docsonnet/doc-util/main.libsonnet';


// typeCheckWhen is a private unexported function for type checking the when attribute of provisioner blocks. It makes
// sure the the value is either `null` or `"destroy"`.
local typeCheckWhen(whenVal) =
  if whenVal == null || whenVal == 'destroy' then
    { when: whenVal }
  else
    error 'when provisioner attribute must be either null or "destroy"';


// typeCheckOnFailure is a private unexported function for type checking the on_failure attribute of provisioner blocks.
// It makes sure the the value is either `null`, `"continue"`, or `"fail"`.
local typeCheckOnFailure(onFailureVal) =
  if onFailureVal == null || onFailureVal == 'continue' || onFailureVal == 'fail' then
    { on_failure: onFailureVal }
  else
    error 'on_failure provisioner attribute must be either null, "continue", or "fail"';


// typeCheckConnType is a private unexported function for type checking the type attribute of connection blocks. It
// makes sure the the value is either `null`, `"ssh"`, or `"winrm"`.
local typeCheckConnType(val) =
  if val == null || val == 'ssh' || val == 'winrm' then
    { type: val }
  else
    error 'type connection attribute must be either null, "ssh", or "winrm"';


// assertSSH is a private unexported function for making sure that the connection type is set to ssh if the given value
// is not null.
local assertSSH(connType, val, name) =
  local isSSH = connType == null || connType == 'ssh';
  if val == null || (isSSH && val != null) then
    { [name]: val }
  else
    error name + ' can only be set when type is "ssh" on connection block';


// assertWinRM is a private unexported function for making sure that the connection type is set to winrm if the given
// value is not null.
local assertWinRM(connType, val, name) =
  if val == null || (connType == 'winrm' && val != null) then
    { [name]: val }
  else
    error name + ' can only be set when type is "winrm" on connection block';


local newLocalExecProvisionerDoc =
  d.fn(
    |||
      `tf.meta.provisioner.newLocalExec` will generate a new `local-exec` provisioner block that can be used as part of
      the `provisioner` meta-argument block.

      **Args**:
      - `command` (`str`): The command to execute on the operator machine as part of the resource lifecycle.
      - `working_dir` (`str`): The working directory where `command` will be executed. When `null`, the attribute is
                               omitted from the resulting block.
      - `interpreter` (`list[str]`): The list of interpreter arguments used to execute the command. When `null`, the
                                     attribute is omitted from the resulting block.
      - `environment` (`map[str, str]`): Map of key-value pairs representing the environment variables that should be
                                         set. When `null`, the attribute is omitted from the resulting block.
      - `when` (`str`): Specifies when Terraform should run the command. Can only be set to `"destroy"`. When `null`,
                        the attribute is omitted from the resulting block.
      - `on_failure` (`str`): Modify how Terraform handles errors in the underlying command. Must be one of `"continue"`
                              or `"fail"`. When `null`, the attribute is omitted from the resulting block.

      **Returns**:
      - An object that can be used as a `provisioner` meta-argument block in the `provisioner` block list of `tf.meta.new`.
    |||,
    [
      d.arg('command', d.T.string),
      d.arg('working_dir', d.T.string, d.T.nil),
      d.arg('interpreter', d.T.array, d.T.nil),
      d.arg('environment', d.T.object, d.T.nil),
      d.arg('when', d.T.string, d.T.nil),
      d.arg('on_failure', d.T.string, d.T.nil),
    ],
  );
local newLocalExecProvisioner(
  command, working_dir=null, interpreter=null, environment=null, when=null, on_failure=null,
      ) =
  local maybeWorkingDir =
    if working_dir != null then
      { working_dir: working_dir }
    else
      {};

  local maybeInterpreter =
    if interpreter != null then
      { interpreter: interpreter }
    else
      {};

  local maybeEnvironment =
    if environment != null then
      { environment: environment }
    else
      {};

  local maybeWhen =
    if when != null then
      typeCheckWhen(when)
    else
      {};

  local maybeOnFailure =
    if on_failure != null then
      typeCheckOnFailure(on_failure)
    else
      {};

  { command: command }
  + maybeWorkingDir
  + maybeInterpreter
  + maybeEnvironment
  + maybeWhen
  + maybeOnFailure;


local newRemoteExecProvisionerDoc =
  d.fn(
    |||
      `tf.meta.provisioner.newRemoteExec` will generate a new `remote-exec` provisioner block that can be used as part of
      the `provisioner` meta-argument block.

      **Args**:
      - `inline` (`list[str]`): The list of commands to execute on the remote machine as part of the resource lifecycle.
                                Exactly one of `inline`, `script`, or `scripts` must be provied.
      - `script` (`str`): The path to a local script that will be copied to the remote machine and then executed.
                          Exactly one of `inline`, `script`, or `scripts` must be provied.
      - `scripts` (`list[str]`): The list of paths to local scripts that will be copied to the remote machine and then
                                 executed. Exactly one of `inline`, `script`, or `scripts` must be provied.
      - `connection` (`obj`): Set the `connection` meta-argument blocks on the resulting block. When
                              `null`, there will be no `provisioner` blocks added. It is recommended to generate
                              this using in [tf.meta.provisioner.connection.new](#obj-metaprovisionerconnectionnew).
      - `when` (`str`): Specifies when Terraform should run the command. Can only be set to `"destroy"`. When `null`,
                        the attribute is omitted from the resulting block.
      - `on_failure` (`str`): Modify how Terraform handles errors in the underlying command. Must be one of `"continue"`
                              or `"fail"`. When `null`, the attribute is omitted from the resulting block.

      **Returns**:
      - An object that can be used as a `provisioner` meta-argument block in the `provisioner` block list of `tf.meta.new`.
    |||,
    [
      d.arg('inline', d.T.array, d.T.nil),
      d.arg('script', d.T.string, d.T.nil),
      d.arg('scripts', d.T.array, d.T.nil),
      d.arg('connection', d.T.object, d.T.nil),
      d.arg('when', d.T.string, d.T.nil),
      d.arg('on_failure', d.T.string, d.T.nil),
    ],
  );
local newRemoteExecProvisioner(
  inline=null, script=null, scripts=null, connection=null, when=null, on_failure=null,
      ) =
  local mutexErr = 'exactly one of inline, script, or scripts must be set on remote-exec provisioner block';
  local mutexCheck =
    if inline != null && (script == null && scripts == null)
       || script != null && (inline == null && scripts == null)
       || scripts != null && (inline == null && script == null)
    then
      null
    else
      error mutexErr;

  local maybeInline =
    if inline != null then
      { inline: inline }
    else
      {};

  local maybeScript =
    if script != null then
      { script: script }
    else
      {};

  local maybeScripts =
    if scripts != null then
      { scripts: scripts }
    else
      {};

  local maybeConn =
    if connection != null then
      { connection: connection }
    else
      {};

  local maybeWhen =
    if when != null then
      typeCheckWhen(when)
    else
      {};

  local maybeOnFailure =
    if on_failure != null then
      typeCheckOnFailure(on_failure)
    else
      {};

  maybeInline
  + maybeScript
  + maybeScripts
  + maybeConn
  + maybeWhen
  + maybeOnFailure;


local newFileProvisionerDoc =
  d.fn(
    |||
      `tf.meta.provisioner.newFile` will generate a new `file` provisioner block that can be used as part of
      the `provisioner` meta-argument block.

      **Args**:
      - `source` (`str`): The source file or directory to copy. Exactly one of `source` or `content` must be provided.
      - `content` (`str`): The direct content to copy to the destination. Exactly one of `source` or `content` must be provied.
      - `destination` (`str`): The destination path to write on the remote system.
      - `connection` (`obj`): Set the `connection` meta-argument blocks on the resulting block. When
                              `null`, there will be no `provisioner` blocks added. It is recommended to generate
                              this using in [tf.meta.provisioner.connection.new](#obj-metaprovisionerconnectionnew).
      - `when` (`str`): Specifies when Terraform should run the command. Can only be set to `"destroy"`. When `null`,
                        the attribute is omitted from the resulting block.
      - `on_failure` (`str`): Modify how Terraform handles errors in the underlying command. Must be one of `"continue"`
                              or `"fail"`. When `null`, the attribute is omitted from the resulting block.

      **Returns**:
      - An object that can be used as a `provisioner` meta-argument block in the `provisioner` block list of `tf.meta.new`.
    |||,
    [
      d.arg('destination', d.T.string),
      d.arg('source', d.T.string, d.T.nil),
      d.arg('content', d.T.string, d.T.nil),
      d.arg('connection', d.T.object, d.T.nil),
      d.arg('when', d.T.string, d.T.nil),
      d.arg('on_failure', d.T.string, d.T.nil),
    ],
  );
local newFileProvisioner(
  destination, source=null, content=null, connection=null, when=null, on_failure=null,
      ) =
  local mutexErr = 'exactly one of source or content must be set on file provisioner block';
  local mutexCheck =
    if source != null && content == null
       || content != null && source == null
    then
      null
    else
      error mutexErr;

  local maybeSource =
    if source != null then
      { source: source }
    else
      {};

  local maybeContent =
    if content != null then
      { content: content }
    else
      {};

  local maybeConn =
    if connection != null then
      { connection: connection }
    else
      {};

  local maybeWhen =
    if when != null then
      typeCheckWhen(when)
    else
      {};

  local maybeOnFailure =
    if on_failure != null then
      typeCheckOnFailure(on_failure)
    else
      {};

  { destination: destination }
  + maybeSource
  + maybeContent
  + maybeConn
  + maybeWhen
  + maybeOnFailure;


local newProvisionerConnectionDoc =
  d.fn(
    |||
      `tf.meta.provisioner.connection.new` will generate a new `connection` block that can be used as part of
      the `provisioner` meta-argument block.

      **Args**:
      - `host` (`str`): The address of the remote resource to connect to.
      - `type` (`str`): The connection type to use when connecting to the instance. Must be one of `"ssh"` or `"winrm"`.
                        When `null`, the attribute is omitted from the resulting block and defaults to what Terraform
                        has set internally (`"ssh"`).
      - `user` (`str`): The user to use for the connection. When `null`, the attribute is omitted from the resulting
                        block and defaults to what Terraform has set internally.
      - `password` (`str`): The password to use for the connection. When `null`, the attribute is omitted from the
                            resulting block.
      - `port` (`number`): The port to use for the connection. When `null`, the attribute is omitted from the resulting
                           block and defaults to what Terraform has set internally.
      - `timeout` (`str`): The timeout to wait for the connection. When `null`, the attribute is omitted from the
                           resulting block and defaults to what Terraform has set internally (`"5m"`).
      - `script_path` (`str`): The path used to copy scripts meant for remote execution. When `null`, the attribute is
                               omitted from the resulting block.
      - `private_key` (`str`): The contents of an SSH key to use for the connection. When `null`, the attribute is
                               omitted from the resulting block. Can only be set when `type` is `"ssh"` or `null`.
      - `certificate` (`str`): The contents of a signed CA certificate to be used in conjunction with the `private_key`
                               arg. When `null`, the attribute is omitted from the resulting block. Can only be set when
                               `type` is `"ssh"` or `null`.
      - `agent` (`bool`): Whether to use the `ssh-agent` for authenticating. When `null`, the attribute is omitted from
                          the resulting block. Can only be set when `type` is `"ssh"` or `null`.
      - `agent_identity` (`str`): The preferred identity from the ssh agent to use for authentication. When `null`, the
                                  attribute is omitted from the resulting block. Can only be set when `type` is `"ssh"`
                                  or `null`.
      - `host_key` (`str`): The public key from the remote host or the signing CA. This is used to verify the
                            connection. When `null`, the attribute is omitted from the resulting block. Can only be set
                            when `type` is `"ssh"` or `null`.
      - `target_platform` (`str`): The target platform to connect to. Must be one of `"unix"` or `"windows"`. When
                                   `null`, the attribute is omitted from the resulting block and defaults to what
                                   Terraform has set internally (`"unix"`). Can only be set when `type` is `"ssh"` or
                                   `null`.
      - `bastion_host` (`str`): The address of a bastion host to hop the connection through. When `null`, the attribute
                                is omitted from the resulting block. Can only be set when `type` is `"ssh"` or `null`.
      - `bastion_host_key` (`str`): The public key from the bastion host or the signing CA. This is used to verify the
                                    connection. When `null`, the attribute is omitted from the resulting block. Can
                                    only be set when `type` is `"ssh"` or `null`.
      - `bastion_port` (`number`): The port to use for the bastion connection. When `null`, the attribute is omitted
                                   from the resulting block. Can only be set when `type` is `"ssh"` or `null`.
      - `bastion_user` (`str`): The user to use for the bastion connection. When `null`, the attribute is omitted
                                from the resulting block. Can only be set when `type` is `"ssh"` or `null`.
      - `bastion_password` (`str`): The password to use for the bastion connection. When `null`, the attribute is
                                    omitted from the resulting block. Can only be set when `type` is `"ssh"` or `null`.
      - `bastion_private_key` (`str`): The contents of an SSH key file to use for the bastion connection. When `null`,
                                       the attribute is omitted from the resulting block. Can only be set when `type` is
                                       `"ssh"` or `null`.
      - `bastion_certificate` (`str`): The contents of a signed CA certificate to be used in conjunction with the
                                       `bastion_private_key` arg. When `null`, the attribute is omitted from the
                                       resulting block. Can only be set when `type` is `"ssh"` or `null`.
      - `https` (`bool`): Whether to connect using HTTPS as opposed to HTTP. When `null`, the attribute is omitted from
                          the resulting block. Can only be set when `type` is `"winrm"`.
      - `insecure` (`bool`): Whether to skip validation of the HTTPS certificate chain. When `null`, the attribute is
                             omitted from the resulting block. Can only be set when `type` is `"winrm"`.
      - `use_ntlm` (`bool`): Whether to use NTLM authentication. When `null`, the attribute is omitted from the
                             resulting block. Can only be set when `type` is `"winrm"`.
      - `cacert` (`str`): The CA certificate to validate against. When `null`, the attribute is omitted from the
                          resulting block. Can only be set when `type` is `"winrm"`.

      **Returns**:
      - An object that can be used as a `connection` sub block on any `remote-exec` or `file` `provisioner` meta-argument block.
    |||,
    [
      d.arg('host', d.T.string),
      d.arg('type', d.T.string, d.T.nil),
      d.arg('user', d.T.string, d.T.nil),
      d.arg('password', d.T.string, d.T.nil),
      d.arg('port', d.T.number, d.T.nil),
      d.arg('timeout', d.T.string, d.T.nil),
      d.arg('script_path', d.T.string, d.T.nil),
      d.arg('private_key', d.T.string, d.T.nil),
      d.arg('certificate', d.T.string, d.T.nil),
      d.arg('agent', d.T.bool, d.T.nil),
      d.arg('agent_identity', d.T.string, d.T.nil),
      d.arg('host_key', d.T.string, d.T.nil),
      d.arg('target_platform', d.T.string, d.T.nil),
      d.arg('bastion_host', d.T.string, d.T.nil),
      d.arg('bastion_host_key', d.T.string, d.T.nil),
      d.arg('bastion_port', d.T.number, d.T.nil),
      d.arg('bastion_user', d.T.string, d.T.nil),
      d.arg('bastion_password', d.T.string, d.T.nil),
      d.arg('bastion_private_key', d.T.string, d.T.nil),
      d.arg('bastion_certificate', d.T.string, d.T.nil),
      d.arg('https', d.T.bool, d.T.nil),
      d.arg('insecure', d.T.bool, d.T.nil),
      d.arg('use_ntlm', d.T.bool, d.T.nil),
      d.arg('cacert', d.T.string, d.T.nil),
    ],
  );
local newProvisionerConnection(
  host,
  type=null,
  user=null,
  password=null,
  port=null,
  timeout=null,
  script_path=null,
  private_key=null,
  certificate=null,
  agent=null,
  agent_identity=null,
  host_key=null,
  target_platform=null,
  bastion_host=null,
  bastion_host_key=null,
  bastion_port=null,
  bastion_user=null,
  bastion_password=null,
  bastion_private_key=null,
  bastion_certificate=null,
  https=null,
  insecure=null,
  use_ntlm=null,
  cacert=null,
      ) =

  local maybeType =
    if type != null then
      typeCheckConnType(type)
    else
      {};

  local maybeUser =
    if user != null then
      { user: user }
    else
      {};

  local maybePass =
    if password != null then
      { password: password }
    else
      {};

  local maybePort =
    if port != null then
      { port: port }
    else
      {};

  local maybeTimeout =
    if timeout != null then
      { timeout: timeout }
    else
      {};

  local maybeScriptPath =
    if script_path != null then
      { script_path: script_path }
    else
      {};

  local maybePrivateKey =
    if private_key != null then
      assertSSH(type, private_key, 'private_key')
    else
      {};

  local maybeCertificate =
    if certificate != null then
      assertSSH(type, certificate, 'certificate')
    else
      {};

  local maybeAgent =
    if agent != null then
      assertSSH(type, agent, 'agent')
    else
      {};

  local maybeAgentIdentity =
    if agent_identity != null then
      assertSSH(type, agent_identity, 'agent_identity')
    else
      {};

  local maybeHostKey =
    if host_key != null then
      assertSSH(type, host_key, 'host_key')
    else
      {};

  local maybeTargetPlatform =
    if target_platform != null then
      assertSSH(type, target_platform, 'target_platform')
    else
      {};

  local maybeBastionHost =
    if bastion_host != null then
      assertSSH(type, bastion_host, 'bastion_host')
    else
      {};

  local maybeBastionHostKey =
    if bastion_host_key != null then
      assertSSH(type, bastion_host_key, 'bastion_host_key')
    else
      {};

  local maybeBastionPort =
    if bastion_port != null then
      assertSSH(type, bastion_port, 'bastion_port')
    else
      {};

  local maybeBastionUser =
    if bastion_user != null then
      assertSSH(type, bastion_user, 'bastion_user')
    else
      {};

  local maybeBastionPassword =
    if bastion_password != null then
      assertSSH(type, bastion_password, 'bastion_password')
    else
      {};

  local maybeBastionPrivateKey =
    if bastion_private_key != null then
      assertSSH(type, bastion_private_key, 'bastion_private_key')
    else
      {};

  local maybeBastionCertificate =
    if bastion_certificate != null then
      assertSSH(type, bastion_certificate, 'bastion_certificate')
    else
      {};

  local maybeHTTPS =
    if https != null then
      assertWinRM(type, https, 'https')
    else
      {};

  local maybeInsecure =
    if insecure != null then
      assertWinRM(type, insecure, 'insecure')
    else
      {};

  local maybeUseNTLM =
    if use_ntlm != null then
      assertWinRM(type, use_ntlm, 'use_ntlm')
    else
      {};

  local maybeCACert =
    if cacert != null then
      assertWinRM(type, cacert, 'cacert')
    else
      {};

  { host: host }
  + maybeType
  + maybeUser
  + maybePass
  + maybePort
  + maybeTimeout
  + maybeScriptPath
  + maybePrivateKey
  + maybeCertificate
  + maybeAgent
  + maybeAgentIdentity
  + maybeHostKey
  + maybeTargetPlatform
  + maybeBastionHost
  + maybeBastionHostKey
  + maybeBastionPort
  + maybeBastionUser
  + maybeBastionPassword
  + maybeBastionPrivateKey
  + maybeBastionCertificate
  + maybeHTTPS
  + maybeInsecure
  + maybeUseNTLM
  + maybeCACert;

{
  '#newLocalExec': newLocalExecProvisionerDoc,
  newLocalExec:: newLocalExecProvisioner,
  '#newRemoteExec': newRemoteExecProvisionerDoc,
  newRemoteExec:: newRemoteExecProvisioner,
  '#newFile': newFileProvisionerDoc,
  newFile:: newFileProvisioner,
  connection:: {
    '#new':: newProvisionerConnectionDoc,
    new:: newProvisionerConnection,
  },
}
