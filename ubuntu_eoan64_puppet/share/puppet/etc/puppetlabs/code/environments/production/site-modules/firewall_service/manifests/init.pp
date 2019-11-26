class firewall_service {
  resources { 'firewall':
    purge => true,
  }

  Firewall {
    before  => Class['firewall_service::post'],
    require => Class['firewall_service::pre'],
  }

  class { ['firewall_service::pre', 'firewall_service::post']: }

  class { 'firewall': }
}
