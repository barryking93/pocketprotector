# manifests/monitoring.pp
#

class pocketprotector::monitoring {
  case lookup('pocketprotector::monitoring') {
    'nagios': {
      include pocketprotector::monitoring::nagios
    }
    'prometheus': {
      #include pocketprotector::monitoring::prometheus
      notify{'pocketprotector::monitoring: prometheus is not (yet?) supported':}
    }
    default: {}
  }
}
