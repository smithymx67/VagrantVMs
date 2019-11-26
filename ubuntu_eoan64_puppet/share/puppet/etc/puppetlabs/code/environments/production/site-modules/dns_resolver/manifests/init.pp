class dns_resolver {
  $nameservers = ['127.0.0.53']

  file { '/etc/resolv.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('dns_resolver/resolv.conf.erb'),
  }
}
