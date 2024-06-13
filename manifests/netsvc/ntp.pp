# manifests/netsvc/ntp.pp
#
# ntp support 
#

class pocketprotector::netsvc::ntp {
  if lookup('pocketprotector::netsvc::ntp::servers', undef, 'deep', false) {
    pocketprotector::packages::parse{'pocketprotector::netsvc::ntp::packages':}
    pocketprotector::files::templates::parse{'pocketprotector::netsvc::ntp::templates':}
    pocketprotector::services::parse{'pocketprotector::netsvc::ntp::services':}
  }
}

