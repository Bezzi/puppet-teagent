# == Class: te_agent::dependency
#
# Checks for required dependencies.
#
# === Copyright
#
# Copyright © 2017 ThousandEyes, Inc.
#
class te_agent::dependency{

  $os_family   = $facts['os']['family']
  $os_release  = $facts['os']['release']['full']
  $os_codename = $facts['os']['distro']['codename']

  case $os_family {

    'RedHat': {
      if ($os_release < 6.3 ) {
        fail("Please upgrade your operating system ${os_family} ${os_release} (${os_codename}) to 6.3 or newer.")
      }
    }

    'Debian': {
      if !($os_codename == 'trusty' or $os_codename == 'xenial') {
        fail('Only Ubuntu 14.04 (trusty) and 16.04 (xenial) are supported. Please contact support.')
      }
    }

    default: {
      fail("Operating system ${os_family} ${os_release} (${os_codename}) is not supported.")
    }
  }

}
