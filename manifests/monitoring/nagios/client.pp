# manifests/monitoring/nagios/client.pp

class pocketprotector::monitoring::nagios::client {
  if lookup('pocketprotector::monitoring::enable',undef,undef,true) {
    # install client packages
    pocketprotector::packages::parse{'pocketprotector::monitoring::nagios::client::packages':}
    pocketprotector::files::templates::parse{'pocketprotector::monitoring::nagios::client::templates':}

    # sudo updates
    sudo::conf { 'nagios':
      content  => 'nagios ALL = NOPASSWD: /usr/lib/nagios/plugins/check_disk',
    }

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
    }

    # look up configd and use as var, so we can munge it
    $nagconfigd = lookup('pocketprotector::monitoring::nagios::server::configd')

    # export host checks
    @@nagios_host { $facts['networking']['fqdn']:
      use                   => lookup('pocketprotector::monitoring::nagios::client::use',undef,deep,'production-host'),
      host_name             => $facts['networking']['fqdn'],
      address               => lookup('pocketprotector::monitoring::nagios::client::ip',undef,deep,"${::ipaddress}"),
      alias                 => $facts['networking']['fqdn'],
      check_command         => 'check-host-alive!3000.0,80%!5000.0,100%!10',
      target                => "${nagconfigd}/host_${facts['networking']['fqdn']}.cfg";
    }

    # check filesystems if in checkedtypes & export check
    $facts['mountpoints'].each | $name, $filesystem | {
      $fs = $facts['mountpoints'][$name]['filesystem']
      if $fs in lookup('pocketprotector::monitoring::nagios::client::fs::checkedtypes') {
        case $name {
          '/': { $fsname = 'systemroot' }
          default: { $fsname = regsubst($name,'/', '', 'G') }
        }

        #notify{"pocketprotector::monitoring::nagios::client: mountpoint is $name, filesytem is $fs and fsname is $fsname":}

        @@nagios_service { "${facts['networking']['fqdn']}_check_disk-${fsname}":
          ensure              => present,
          use                 => 'generic-service',
          host_name           => $facts['networking']['fqdn'],
          service_description => "${facts['networking']['fqdn']} filesystem - ${name}",
          check_command       => "check_disk_nrpe!${name}",
          target                => "${nagconfigd}/host_${facts['networking']['fqdn']}.cfg";
        }
      }
      else {
        #notify{"pocketprotector::monitoring::nagios::client: ${name} on ${::fqdn} is not a checked filesystem type [${fs}]":}
      }
    }

    # parse and export further checks
    #lookup('pocketprotector::monitoring::nagios',undef,deep,undef)
  }
}
