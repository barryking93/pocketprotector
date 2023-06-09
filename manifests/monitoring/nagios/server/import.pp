# manifests/monitoring/nagios/server/import.pp
#
# generate nagios resources
#
class pocketprotector::monitoring::nagios::server::import {

  nagios_command <<||>> {
    notify  => lookup('pocketprotector::monitoring::nagios::service::server'),
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  nagios_contact <<||>> {
    notify  => lookup('pocketprotector::monitoring::nagios::service::server'),
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
    notify  => lookup('pocketprotector::monitoring::nagios::service::server'),
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  nagios_host <<||>> {
    notify  => lookup('pocketprotector::monitoring::nagios::service::server'),
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  nagios_hostgroup <<||>> {
    notify  => lookup('pocketprotector::monitoring::nagios::service::server'),
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  nagios_service <<||>> {
    notify  => lookup('pocketprotector::monitoring::nagios::service::server'),
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  nagios_timeperiod <<||>> {
    notify  => lookup('pocketprotector::monitoring::nagios::service::server'),
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
}
