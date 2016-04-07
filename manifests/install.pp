# Class to install Hashicorp Vault
class vault::install(
  $package_ensure = $::vault::package_ensure,
  $vault_user     = $::vault::vault_user,
  $version        = $::vault::version,
) {

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
