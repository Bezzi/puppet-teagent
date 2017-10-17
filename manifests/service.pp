# == Class: te_agent::service
#
# Handles the te-agent service.
#
# === Copyright
#
# Copyright © 2017 ThousandEyes, Inc.
#
class te_agent::service {

    service { 'te-agent':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      subscribe  => File['/var/lib/te-agent/config_teagent.sh'],
    }
}
