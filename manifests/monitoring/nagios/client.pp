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

    # look up configd and use as var, so we can munge it
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

    # check filesystems
    $::mountpoints.each | $name, $filesystem| {
      $fs = $::mountpoints[$name]['filesystem']
      case $fs {
        lookup('pocketprotector::monitoring::nagios::client::fs::checkedtypes'): {
          case $name {
            '/': { $fsname = 'root' }
            default: { $fsname = regsubst($name,'/', '', 'G') }
          }

          $fswarnpct = lookup('pocketprotector::monitoring::nagios::client::fs::warnpct')
          $fscritpct = lookup('pocketprotector::monitoring::nagios::client::fs::critpct')

          @@nagios_service { "${::fqdn}_check_disk-${fsname}":
            ensure              => present,
            use                 => 'generic-service',
            host_name           => $::fqdn,
            service_description => "${::fqdn} partition - ${name}",
            check_command       => "check_disk!${fswarnpct}!${fscritpct}!${name}",
            target                => "${nagconfigd}/host_${::fqdn}.cfg";
          }
        }
        default: {
        }
      }
    }

    # parse and export further checks
    #lookup('pocketprotector::monitoring::nagios',undef,deep,undef)
  }
}
