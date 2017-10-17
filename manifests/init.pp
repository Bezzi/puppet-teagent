# == Class: te_agent
#
# Puppet module for the ThousandEyes agent.
#
# === Parameters
#
# [*account_token*]
#   Account token for the agent.
#   Default is the sample value, which equals a disabled agent.
#
# [*international_langs*]
#   Handles the international language package.
#   Possible values are: 'present','installed','absent','purged','held','latest'.
#   Default value is 'absent'.
#
# [*browserbot*]
#   Handles the browserbot package.
#   Possible values are: 'present','installed','absent','purged','held','latest'.
#   Default value is 'absent'.
#
# [*agent_utils*]
#   Handles instalation of the agent utils package.
#   Possible values are: 'present','installed','absent','purged','held','latest'.
#   Default value is 'absent'.
#
# [*log_level*]
#   Agent log level.
#   Possible values are: 'DEBUG', 'TRACE'
#   Default: 'DEBUG'
#
# [*log_file_size*]
#   Agent log file size in MB.
#   Default: 10
#
# [*num_log_files*]
#   Amount of agent's log files.
#   Default: 13
#
# [*log_path*]
#   Agent log path.
#   Default: /var/log
#
# [*proxy_user*]
#   Proxy username.
#   Default (disabled): ''
#
# [*proxy_pass*]
#   Proxy password.
#   Default (disabled): ''
#
# [*proxy_bypass_list*]
#   Proxy bypass list. Comma separated value.
#   Default (disabled): ''
#
# [*set_repo*]
#   Handles or not the ThousandEyes repository installation.
#   Default: true
#
# === Examples
#
# Call teagent as a parameterized class
#
# See README for details.
#
# === Authors
#
# Gaston Bezzi <gaston@thousandeyes.com>
# Paulo Cabido <paulo@thousandeyes.com>
#
# === Copyright
#
# Copyright © 2017 ThousandEyes, Inc.
#
class te_agent(
  Optional[String] $account_token,
  Enum['present','installed','absent','purged','held','latest'] $international_langs = 'absent',
  Enum['present','installed','absent','purged','held','latest'] $browserbot  = 'absent',
  Enum['present','installed','absent','purged','held','latest'] $agent_utils = 'absent',
  Enum['DEBUG','TRACE'] $log_level = 'DEBUG',
  Integer[0] $log_file_size = 10,
  Integer[0] $num_log_files = 13,
  String $log_path = '/var/log',
  String $proxy_user = '',
  String $proxy_pass = '',
  String $proxy_bypass_list = '',
  Boolean $set_repo = false,
){

  if $set_repo == true {
    contain teagent::dependency
  }

  class { 'te_agent::install': }
  -> class { 'te_agent::config': }
  -> class { 'te_agent::service': }
}
