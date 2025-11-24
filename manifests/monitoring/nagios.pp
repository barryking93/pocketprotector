# manifests/monitoring/nagios.pp

class pocketprotector::monitoring::nagios {
  # everyone is a client
  include pocketprotector::monitoring::nagios::client
  # only the server is a server
  case $facts['networking']['fqdn'] {
    lookup('pocketprotector::monitoring::nagios::server'): {
      include pocketprotector::monitoring::nagios::server
    }
    default: {}
  }
}
