# manifests/monitoring/nagios/server/import.pp

#
# "import" nagios exported resources
#
class pocketprotector::monitoring::nagios::server::import {
  # look configd and use as var, so we can munge it
  $nagconfigd = lookup('pocketprotector::monitoring::nagios::server::configd')

  exec {
    'fix nagios perms':
      command     => "/usr/bin/chmod -R 644 ${nagconfigd}",
      refreshonly => 'true';
  }

  Nagios_command <<||>> {
    notify  => [Service[lookup('pocketprotector::monitoring::nagios::service::server')],Exec['fix nagios perms']],
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  Nagios_contact <<||>> {
    notify  => [Service[lookup('pocketprotector::monitoring::nagios::service::server')],Exec['fix nagios perms']],
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  Nagios_host <<||>> {
    notify  => [Service[lookup('pocketprotector::monitoring::nagios::service::server')],Exec['fix nagios perms']],
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  Nagios_hostgroup <<||>> {
    notify  => [Service[lookup('pocketprotector::monitoring::nagios::service::server')],Exec['fix nagios perms']],
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  Nagios_service <<||>> {
    notify  => [Service[lookup('pocketprotector::monitoring::nagios::service::server')],Exec['fix nagios perms']],
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  Nagios_timeperiod <<||>> {
    notify  => [Service[lookup('pocketprotector::monitoring::nagios::service::server')],Exec['fix nagios perms']],
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
}
