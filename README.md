# puppet-vault [![Build Status](https://travis-ci.com/rhoml/puppet-vault.svg?token=vfFGLwkzPiw5jXGyyDBy&branch=master)](https://travis-ci.com/rhoml/puppet-vault)

# Overview

This is a puppet module to install Hashicorp's [vault project](https://www.vaultproject.io) to keep your secrets safe. This module doesn't build the Vault packages which should be pretty easy to do using fpm.

Documentation for Vault can be found on their [site](https://www.vaultproject.io/docs/config/index.html). Take into consideration:
* You can only define one storage backend, listener and telemetry on the config file.
* Other configurations should be set up using Vault API or CLI.

# Install Vault

````
include ::vault
````

# Configure Vault using Hiera

This module enables you to use hiera to configure your Vault server. It also allows you to use module [data](https://github.com/rhoml/puppet-vault/blob/master/data/common.yaml).

````
vault::config_hash:
    backend:
        consul:
            address: 127.0.0.1:8500
            advertise_addr: "http://%{::ipaddress_eth0}"
            path: 'vault/'
    listener:
        tcp:
            address: "%{::fqdn}:8200"
            tls_disable: 1
    telemetry:
        statsite_address: '127.0.0.1:8125'
        disable_hostname: true
    disable_mlock: true
vault::manage_user: true
vault::package_ensure: 'latest'
vault::vault_user: 'vault'
vault::restart_cmd: '/etc/init.d/vault restart'
````

# Uninstalling Vault

Ensure the following hiera key is present so Vault can be correctly uninstalled

```
vault::package_ensure: absent
```

# See also

* [hiera-vault](https://github.com/jsok/hiera-vault)
* [consul](https://github.com/solarkennedy/puppet-consul)
