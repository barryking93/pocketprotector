# manifests/monitoring/nagios/server/import.pp
#
# generate nagios resources
#
class pocketprotector::monitoring::nagios::server::import {

  Nagios_command <<||>> {
    notify  => lookup('pocketprotector::monitoring::nagios::service::server'),
#    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  Nagios_contact <<||>> {
    notify  => lookup('pocketprotector::monitoring::nagios::service::server'),
#    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  Nagios_host <<||>> {
    notify  => lookup('pocketprotector::monitoring::nagios::service::server'),
#    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  Nagios_hostgroup <<||>> {
    notify  => lookup('pocketprotector::monitoring::nagios::service::server'),
#    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  Nagios_service <<||>> {
    notify  => lookup('pocketprotector::monitoring::nagios::service::server'),
#    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
  Nagios_timeperiod <<||>> {
    notify  => lookup('pocketprotector::monitoring::nagios::service::server'),
#    require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')],
  }
}
