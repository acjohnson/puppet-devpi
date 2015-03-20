# == Class: devpi
#
# Installs devpi - http://doc.devpi.net/latest/index.html
#
# === Parameters
#
# [*ensure*]
#   Ensurable
#
# [*package_name*]
#   Name of package to install
#
# [*service_refresh*]
#   Boolean if service should restart on config changes
#
# [*service_enable*]
#   Service type enable
#
# [*service_ensure*]
#   Service type ensure
#
# [*service_name*]
#   Name of service to manage
#
# [*user*]
#   Name of user running devpi
#
# [*group*]
#   Name of group of user running devpi
#
# [*manage_user*]
#   Boolean if user/group resource should be declared in this module
#
# [*listen_host*]
#   devpi-server --host parameter
#
# [*listen_port*]
#   devpi-server --port parameter
#
# [*refresh*]
#   devpi-server --refresh parameter 
#
# [*server_dir*]
#   devpi-server --serverdir parameter
#
# === Examples
#
# include ::devpi
#
# === Copyright
#
# Copyright 2015 North Development AB
#
class devpi (
  $ensure          = 'present',
  $package_name    = $::devpi::params::package,
  $service_refresh = true,
  $service_enable  = true,
  $service_ensure  = 'running',
  $service_name    = $::devpi::params::service,
  $user            = $::devpi::params::user,
  $group           = $::devpi::params::group,
  $manage_user     = true,
  $listen_host     = '0.0.0.0',
  $listen_port     = 3141,
  $refresh         = 3600,
  $server_dir      = $::devpi::params::server_dir
) inherits devpi::params {

  anchor { '::devpi::start': } ->
  class { '::devpi::user': } ->
  class { '::devpi::package': } ->
  class { '::devpi::config': } ->
  class { '::devpi::files': } ->
  class { '::devpi::service': } ->
  anchor { '::devpi::end': }

  if $service_refresh {
    Class['::devpi::config'] ~>
    Class['::devpi::service']
  }

}