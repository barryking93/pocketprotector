# manifests/netsvc/ntp.pp
#
# ntp support 
#

class pocketprotector::netsvc::ntp {
  if lookup('pocketprotector::netsvc::ntp::servers', undef, 'deep', false) {
    pocketprotector::cron::parse{'pocketprotector::netsvc::ntp::cron':}
    pocketprotector::packages::parse{'pocketprotector::netsvc::ntp::packages':}
    pocketprotector::files::templates::parse{'pocketprotector::netsvc::ntp::templates':}
    pocketprotector::services::parse{'pocketprotector::netsvc::ntp::services':}
  }
}

