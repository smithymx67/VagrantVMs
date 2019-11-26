class sudo_privileges {
  include sudo

  sudo::conf { 'admins': 
    ensure  => present,
    content => '%admin ALL=(ALL) ALL',
  }

  sudo::conf { 'web': 
    content => 'web ALL=(ALL) NOPASSWD: ALL',
  }

  sudo::conf { 'sam':
    priority  => 60,
    content   => 'sam ALL=(ALL) NOPASSWD: ALL',
  }
}
