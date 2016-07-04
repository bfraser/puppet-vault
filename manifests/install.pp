# Class to install Hashicorp Vault
class vault::install(
  $archive_source = $::vault::archive_source,
  $bin_dir        = $::vault::bin_dir,
  $install_method = $::vault::install_method,
  $manage_user    = $::vault::manage_user,
  $package_ensure = $::vault::package_ensure,
  $vault_user     = $::vault::vault_user,
  $version        = $::vault::version,
) {
  if $archive_source != undef {
    $real_archive_source = $archive_source
  }
  else {
    $real_archive_source = "https://releases.hashicorp.com/vault/${version}/vault_${version}_linux_amd64.zip"
  }

  if $manage_user {
    group { $vault_user:
      ensure => 'present',
    }

    user { $vault_user:
      ensure  => 'present',
      gid     => $vault_user,
      require => Group[$vault_user],
    }
  }

  case $install_method {
    'package': {
      case $::osfamily {
        /(Debian|Ubuntu)/: {
          $real_provider = 'aptitude'
        }
        default: {
          fail("\"${module_name}\" We don't support \"${::osfamily}\"")
        }
      }

      $vault_ensure = $package_ensure ? {
        'absent' => 'purged',
        default  => $version,
      }

      package { 'vault':
        ensure   => $vault_ensure,
        provider => $real_provider,
      }

      # If we are uninstalling Vault we should remove
      #   all its dependencies
      if $package_ensure == 'absent' {
        group { $vault_user:
          ensure => $package_ensure,
        }

        user { $vault_user:
          ensure  => $package_ensure,
        }

        file { '/etc/init.d/vault':
          ensure  => $package_ensure,
        }

        file { '/etc/vault':
          ensure  => $package_ensure,
        }
      }
    }
    'archive': {
      $install_path = '/opt/puppet-archive'

      include ::archive

      file { "${install_path}/vault-${version}":
        ensure => directory,
      }->
      archive { "${install_path}/vault_${version}_linux_amd64.zip":
        ensure       => present,
        source       => $real_archive_source,
        extract      => true,
        extract_path => "${install_path}/vault-${version}",
        creates      => "${install_path}/vault-${version}/vault",
        require      => Package['unzip'],
      }->
      file { "${bin_dir}/vault":
        ensure => link,
        target => "${install_path}/vault-${version}/vault"
      }
    }
  }
}
