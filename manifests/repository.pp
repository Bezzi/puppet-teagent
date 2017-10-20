# == Class: teagent::repository
#
# Manages the ThousandEyes repository.
#
# === Copyright
#
# Copyright © 2017 ThousandEyes, Inc.
#
class te_agent::repository {

  if $te_agent::set_repository == true {

    $distribution = $facts['os']['distro']['id']
    $architecture = $facts['os']['architecture']
    $os_codename  = $facts['os']['distro']['codename']
    $os_maj_release = $facts['os']['release']['major']


    case $distribution {

      'RedHat', 'CentOS': {
        yumrepo { 'thousandeyes.repo':
          ensure   => present,
          baseurl  => "http://yum.thousandeyes.com/${os_codename}/${os_maj_release}/${architecture}",
          gpgkey   => 'http://yum.thousandeyes.com/RPM-GPG-KEY-thousandeyes',
          gpgcheck => true,
        }
      }

      'Ubuntu': {
        $public_key = '/etc/apt/trusted.gpg.d/thousandeyes-apt-key.pub'
        $repository = '/etc/apt/sources.list.d/thousandeyes.list'

        file { $public_key:
          ensure => 'present',
          source => 'puppet:///modules/te_agent/thousandeyes-apt-key.pub',
        }
        ~> exec { "/usr/bin/apt-key add ${public_key}":
            refreshonly => true,
          }
        -> file { $repository:
            ensure  => 'present',
            content => template('te_agent/thousandeyes.list.erb'),
          }
        ~> exec { '/usr/bin/apt-get update':
            refreshonly => true,
          }
      }

      default: {
        fail('Operating system is not supported.')
      }
    }
  }
}
