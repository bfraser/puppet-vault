# Class to configure vault
class vault::config (
  $config_hash = $::vault::config_hash,
  $vault_user  = $::vault::vault_user,
  ){

  file { '/etc/init.d/vault':
    ensure  => 'file',
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    content => template('vault/init-script.erb'),
    notify  => Class['::vault::service'],
    #require => Package['vault'],
  }

  file { '/etc/vault':
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    purge   => true,
    recurse => true,
    #require => Package['vault'],
  }

  file { '/etc/vault/vault.json':
    ensure  => 'file',
    mode    => '0644',
    group   => $vault_user,
    owner   => $vault_user,
    content => sorted_json($config_hash),
    notify  => Class['::vault::service'],
    require => [ File['/etc/vault'],
      File['/etc/init.d/vault'] ],
  }
}
