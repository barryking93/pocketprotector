# manifests/monitoring/snmp.pp
#

class pocketprotector::monitoring::snmp {
  include snmp

  class snmp {
    agentaddress => lookup('pocketprotector::monitoring::snmp::agentaddress',undef,'first',undef),
    contact      => lookup('pocketprotector::monitoring::snmp::contact',undef,'first',undef),
    location     => lookup('pocketprotector::monitoring::snmp::location',undef,'first',undef),
    ro_community => lookup('pocketprotector::monitoring::snmp::ro_community',undef,'first',undef),
    ro_network   => lookup('pocketprotector::monitoring::snmp::ro_network',undef,'first',undef),
  }
}
