# manifests/monitoring/nagios/server/import.pp
#
# generate nagios resources
#
class pocketprotector::monitoring::nagios::server::import {

  Nagios_command <<||>> {
    notify  => Service[lookup('pocketprotector::monitoring::nagios::service::server')],
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  Nagios_contact <<||>> {
    notify  => Service[lookup('pocketprotector::monitoring::nagios::service::server')],
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  Nagios_host <<||>> {
    notify  => Service[lookup('pocketprotector::monitoring::nagios::service::server')],
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  Nagios_hostgroup <<||>> {
    notify  => Service[lookup('pocketprotector::monitoring::nagios::service::server')],
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  Nagios_service <<||>> {
    notify  => Service[lookup('pocketprotector::monitoring::nagios::service::server')],
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  Nagios_timeperiod <<||>> {
    notify  => Service[lookup('pocketprotector::monitoring::nagios::service::server')],
    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
}
