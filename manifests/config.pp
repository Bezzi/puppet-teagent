# == Class: te_agent::config()
#
# Handles te te-agent configuration.
#
# === Copyright
#
# Copyright © 2017 ThousandEyes, Inc.
#
class te_agent::config(){

  file { '/var/lib/te-agent/config_teagent.sh':
    ensure  => 'present',
    content => template('te_agent/config_teagent.sh.erb'),
    mode    => '0755',
  }

  exec { '/bin/bash /var/lib/te-agent/config_teagent.sh':
    subscribe   => File['/var/lib/te-agent/config_teagent.sh'],
    refreshonly => true,
  }
}
