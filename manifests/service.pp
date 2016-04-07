# Class to manage vault service
class vault::service(
  $restart_cmd    = $::vault::restart_cmd,
  $service_ensure = $::vault::service_ensure,
  $service_enable = $::vault::service_enable
  ){
  service {
    'vault':
      ensure     => $service_ensure,
      enable     => $service_enable,
      hasstatus  => true,
      hasrestart => true,
      restart    => $restart_cmd,
      require    => File['/etc/vault/vault.json'],
  }
}
