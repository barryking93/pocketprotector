# manifests/monitoring/snmp.pp
#

class pocketprotector::monitoring::snmp {
  if lookup('pocketprotector::monitoring::snmp::accounts',undef,'first',false) {
    pocketprotector::accounts::parse{'pocketprotector::monitoring::snmp::accounts':}
  }
  pocketprotector::files::packages::parse{"pocketprotector::monitoring::snmp::packages":}
  pocketprotector::files::templates::parse{"pocketprotector::monitoring::snmp::templates":}
}
