# manifests/monitoring.pp
#

class pocketprotector::monitoring {
  # detect if a server's defined for the varios monitoring server types, install if so
  if lookup('pocketprotector::monitoring::librenms::server',undef,'deep',false) {
    include pocketprotector::monitoring::librenms
    include pocketprotector::monitoring::snmp
  }
  if lookup('pocketprotector::monitoring::nagios::server',undef,'deep',false) {
    include pocketprotector::monitoring::nagios
  }
  if lookup('pocketprotector::monitoring::splunk::server',undef,'deep',false) {
    include pocketprotector::monitoring::splunk
  }
}
