# manifests/monitoring/rsyslog.pp

class pocketprotector::monitoring::rsyslog {
  pocketprotector::files::templates::parse{'pocketprotector::monitoring::rsyslog::templates':}
}

