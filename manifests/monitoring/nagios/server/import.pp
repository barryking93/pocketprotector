# manifests/monitoring/nagios/server/import.pp

#
# "import" nagios exported resources
#
class pocketprotector::monitoring::nagios::server::import {
  # look configd and use as var, so we can munge it
  $nagconfigd = lookup('pocketprotector::monitoring::nagios::server::configd')

  exec {
    'fix nagios perms':
      command     => "/usr/bin/chmod -R 644 ${nagconfigd}/*cfg",
      refreshonly => 'true',
      notify      => Service[lookup('pocketprotector::monitoring::nagios::service::server')];
  }

  Nagios_command <<||>> {
    notify  => [Service[lookup('pocketprotector::monitoring::nagios::service::server')],Exec['fix nagios perms']],
    require => Package[lookup('pocketprotector::monitoring::nagios::server::packages')],
  }
  Nagios_contact <<||>> {
    notify  => [Service[lookup('pocketprotector::monitoring::nagios::service::server')],Exec['fix nagios perms']],
    require => Package[lookup('pocketprotector::monitoring::nagios::server::packages')],
  }
  Nagios_contactgroup <<||>> {
    notify  => [Service[lookup('pocketprotector::monitoring::nagios::service::server')],Exec['fix nagios perms']],
    require => Package[lookup('pocketprotector::monitoring::nagios::server::packages')],
  }
  Nagios_host <<||>> {
    notify  => [Service[lookup('pocketprotector::monitoring::nagios::service::server')],Exec['fix nagios perms']],
    require => Package[lookup('pocketprotector::monitoring::nagios::server::packages')],
  }
  Nagios_hostgroup <<||>> {
    notify  => [Service[lookup('pocketprotector::monitoring::nagios::service::server')],Exec['fix nagios perms']],
    require => Package[lookup('pocketprotector::monitoring::nagios::server::packages')],
  }
  Nagios_service <<||>> {
    notify  => [Service[lookup('pocketprotector::monitoring::nagios::service::server')],Exec['fix nagios perms']],
    require => Package[lookup('pocketprotector::monitoring::nagios::server::packages')],
  }
  Nagios_timeperiod <<||>> {
    notify  => [Service[lookup('pocketprotector::monitoring::nagios::service::server')],Exec['fix nagios perms']],
    require => Package[lookup('pocketprotector::monitoring::nagios::server::packages')],
  }
}
