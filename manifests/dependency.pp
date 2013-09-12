# == Class: teagent::dependency
# Copyright © 2013 ThousandEyes, Inc.
#
# === Copyright
#
# Copyright © 2013 ThousandEyes, Inc.
#
class teagent::dependency {
  ### check if the OS is supported
  case $::operatingsystem {
    centos, redhat: {
      if ($::operatingsystemrelease < 6.3) {
        fail("Please upgrade your operating system to ${::operatingsystem} to >= 6.3")
      }
      else {
        # the OS check passed, install the repo
        include teagent::repository
      }
    }
    debian: {
      case $::operatingsystemrelease {
        '6.0','6.0.1','6.0.2','6.0.3','6.0.4','6.0.5','6.0.6','6.0.7','6.0.8','6.0.9': {
          package { 'lsb-release': ensure => 'installed' }
          class { 'teagent::repository': require => Package['lsb-release'] }
        }
        default: {
          fail('Only Ubuntu 10.4 (lucid) and 12.04 (precise) are supported. Please contact support.')
        }
      }
    }
    ubuntu: {
      if ($::lsbdistcodename != 'lucid') and ($::lsbdistcodename != 'precise') {
        fail('Only Ubuntu 10.4 (lucid) and 12.04 (precise) are supported. Please contact support.')
      }
      else {
        # the OS check passed, install the repo
        package { 'lsb-release': ensure => 'installed' }
        class { 'teagent::repository': require => Package['lsb-release'] }
      }
    }
    default: {
      fail("Operating system ${::operatingsystem} ${::operatingsystemrelease} isn't supported.")
    }
  }
}
