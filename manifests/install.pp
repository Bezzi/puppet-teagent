# == Class: te_agent::install()
#
# Manages packages: te-agent, te-browserbot, te-agent-utils and te-intl-fonts.
#
# === Copyright
#
# Copyright © 2017 ThousandEyes, Inc.
#
class te_agent::install(){

  $os_distro   = facts['os.distro']
  $os_release  = facts['os.release.full']
  $os_codename = facts['os.distro.codename']

  case $os_distro {

    centos, redhat: {
      if ($os_release < 6.3 ) {
        fail("Please upgrade your operating system ${os_distro} ${os_release} (${os_codename}) to 6.3 or newer.")
      }
    }

    ubuntu: {
      if  $os_codename != trusty or $os_codename != xenial {
        fail('Only Ubuntu 14.04 (trusty) and 16.04 (xenial) are supported. Please contact support.')
      }
    }

    default: {
      fail("Operating system ${os_distro} ${os_release} (${os_codename}) is not supported.")
    }
  }

  package { 'te-agent':
    ensure  => 'installed',
  }

  package { 'te-browserbot':
    ensure  => $te_agent::browserbot,
    require => Package['te-agent'],
  }

  package { 'te-agent-utils':
    ensure  => $te_agent::agent_utils,
    require => Package['te-agent'],
  }

  package { 'te-intl-fonts':
    ensure  => $te_agent::international_langs,
  }

}
