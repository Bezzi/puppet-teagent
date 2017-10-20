# == Class: te_agent::service
#
# Handles the te-agent service.
#
# === Copyright
#
# Copyright © 2017 ThousandEyes, Inc.
#
class te_agent::service {

  $te_agent_service_ensure = $te_agent::te_agent ? {
    true  => 'running',
    false => 'stopped',
  }

  $browserbot_service_ensure = $te_agent::browserbot ? {
    true  => 'running',
    false => 'stopped',
  }

  service { 'te-agent':
    ensure     => $te_agent_service_ensure,
    enable     => $te_agent::te_agent,
    hasrestart => true,
    hasstatus  => true,
    require    => [Package['te-agent'],File['/etc/te-agent.cfg']],
    subscribe  => File['/etc/te-agent.cfg'],
  }

  service { 'te-browserbot':
    ensure      => $browserbot_service_ensure,
    enable      => $te_agent::browserbot,
    hasrestart  => true,
    hasstatus   => true,
    require     => Package['te-browserbot'],
    refreshonly => true,
  }

}
