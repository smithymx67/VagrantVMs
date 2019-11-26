class ntp_service {  
  class { 'ntp':
    servers => ['0.pool.npt.org','1.pool.npt.org','2.pool.npt.org','3.pool.npt.org',]
  }
}
