node 
  'puppet'
{
  firewall { '100 allow Puppet':
    proto  => 'tcp',
    dport  => 8140,
    action => 'accept',
  }
}
