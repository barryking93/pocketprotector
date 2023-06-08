#

class pocketprotector::monitoring::nagios::client {
  if lookup('pocketprotector::monitoring::enable') == true {
    # install client packages
    package {
      lookup('pocketprotector::monitoring::nagios::packages::client', undef, 'deep', undef):
        ensure => 'present'
    }

    # keep client service running
    service {
      lookup('pocketprotector::monitoring::nagios::service::client'):
        ensure  => 'running',
        enable  => true,
        require => Package[lookup('pocketprotector::monitoring::nagios::packages::client')];
    }

    # configure nrpe
    file {
      lookup('pocketprotector::monitoring::nagios::client::configfile'):
        mode    => '0444',
        notify  => Service[lookup('pocketprotector::monitoring::nagios::service::client')],
        require => Package[lookup('pocketprotector::monitoring::nagios::packages::client')];
    }

    # export host checks
    $nagios_configd = lookup('pocketprotector::monitoring::nagios::server::configd')
    
    @@nagios_host { $::fqdn:
      use           => generic-host,
      host_name     => $::fqdn,
      address       => lookup('pocketprotector::monitoring::nagios::client::ip',undef,undef,"${::ip}"),
      alias         => $::fqdn,
      check_command => 'check-host-alive!3000.0,80%!5000.0,100%!10',
      target        => "${nagios_configd}/host_${::fqdn}.cfg";
    }

    # parse and export further checks
    #lookup('pocketprotector::monitoring::nagios',undef,deep,undef)
  }
}
