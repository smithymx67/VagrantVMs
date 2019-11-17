node 'client' {
   file { '/tmp/puppetdir':                                    # Resource type file
      ensure => 'directory',                                   # Create as a diectory
      owner => 'root',                                         # Ownership
      group => 'root',                                         # Group Name
      mode => '0755',                                          # Directory permissions
   }

   file { '/tmp/puppetdir/puppetfile':                         # Resource type file
      ensure => 'present',                                     # Make sure it exists
      owner => 'root',                                         # Ownership
      group => 'root',                                         # Group Name
      mode => '0644',                                          # File permissions
      content => "This File is created by Puppet Server"       # Content of the file
   }
}
