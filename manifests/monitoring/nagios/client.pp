# manifests/monitoring/nagios/client.pp

class pocketprotector::monitoring::nagios::client {
  if lookup('pocketprotector::monitoring::enable',undef,undef,true) {
    # install client packages
    pocketprotector::packages::parse{'pocketprotector::monitoring::nagios::client::packages':}

    # keep client service running
    service {
      lookup('pocketprotector::monitoring::nagios::service::client'):
        ensure  => 'running',
        enable  => true,
        # require below doesn't work w/ Hash lookups
        #require => Package[lookup('pocketprotector::monitoring::nagios::client::packages')];
    }

    # configure nrpe
    file {
      lookup('pocketprotector::monitoring::nagios::client::configfile'):
        mode    => '0444',
        content => template('pocketprotector/monitoring/nagios/nrpe.cfg.erb'),
        notify  => Service[lookup('pocketprotector::monitoring::nagios::service::client')],
        #require => Package[lookup('pocketprotector::monitoring::nagios::client::packages')];
    }

    # look configd and use as var, so we can munge it
    $nagconfigd = lookup('pocketprotector::monitoring::nagios::server::configd')

    # export host checks
    @@nagios_host { $::fqdn:
      use                   => lookup('pocketprotector::monitoring::nagios::client::use',undef,deep,'production-host'),
      host_name             => $::fqdn,
      address               => lookup('pocketprotector::monitoring::nagios::client::ip',undef,deep,"${::ipaddress}"),
      alias                 => $::fqdn,
      check_command         => 'check-host-alive!3000.0,80%!5000.0,100%!10',
      target                => "${nagconfigd}/host_${::fqdn}.cfg";
    }

    # parse and export further checks
    #lookup('pocketprotector::monitoring::nagios',undef,deep,undef)
  }
}
