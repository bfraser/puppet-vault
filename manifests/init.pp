# Class: vault
# ===========================
#
# Full description of class vault here.
#
# Usage
# -----
#
# class { 'vault':
#   config_hash => {
#     'backend' => {
#       'github'         => {
#         'token' => '<insert your github token>'
#       }
#     },
#     'listener' => {
#       'tcp'            => {
#         'address'     => '127.0.0.1:8200',
#         'tls_disable' => 1
#       }
#     },
#     'telemetry'        => {
#       'statsite_address' => '127.0.0.1:8125'
#     },
#     'disable_hostname' => true,
#     'disable_mlock'    => false
#   }
# }
#
#
# Authors
# -------
#
# Rhommel Lamas <roml@rhommell.com>
# Twitter: @rhoml
# IRC #freenode: @rhoml
#
#
# Copyright
# ---------
#
# Copyright 2015 Rhommel Lamas, unless otherwise noted.
#
class vault (
  $archive_source = undef,
  $bin_dir        = '/usr/local/bin',
  $config_hash    = {},
  $install_method = 'package',
  $manage_user    = undef,
  $package_ensure = 'present',
  $restart_cmd    = '/etc/init.d/vault restart',
  $service_ensure = 'running',
  $service_enable = true,
  $vault_user     = 'vault',
  $version        = '0.5.2'
  ){

  validate_re($package_ensure, [ '^present$', '^absent$' ],
    '\$package_ensure should be \'present\' or \'purged\'.')

  validate_hash($config_hash)

  if $package_ensure == 'present' {
    class {'::vault::install': }
    ->
    class {'::vault::config':  }
    ~>
    class{'::vault::service':  }
  } else {
    class {'::vault::install': }
  }
}
