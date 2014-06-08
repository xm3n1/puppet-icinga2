# == Class: icinga2::params
#
# Default parameters for the icinga class.
#
# === Authors
#
# Evgeni Golov <evgeni@golov.de>
#
# === Copyright
#
# Copyright 2014 Evgeni Golov, unless otherwise noted.
#
class icinga2::params {

  case $::osfamily {
    Debian: {
      $icinga2_package     = 'icinga2'
      $frontend_package    = 'icinga2-classicui'
      $nrpe_plugin_package = 'nagios-nrpe-plugin'
      $nrpe_server_package = 'nagios-nrpe-server'
      $nrpe_service        = 'nagios-nrpe-server'
      $nrpe_d_folder       = '/etc/nagios/nrpe.d'
      $plugins_packages    = [
                              'nagios-plugins-basic',
                              'nagios-plugins-standard',
                              'nagios-plugins-contrib'
                              ]
    }
    default: {
      fail('This module only supports Debian-based systems')
    }
  }

  $ensure              = 'present'
  $ensure_running      = 'running'
  $ensure_enable       = 'true'
  $allowed_hosts       = ['127.0.0.1']
}
