# manifests/netsvc/freeradius.pp
#
# freeradius for tie-in with samba/ntlm
#

class pocketprotector::netsvc::freeradius {
  if lookup('pocketprotector::netsvc::freeradius::server::enabled', undef, 'deep', false) {
    pocketprotector::packages::parse{'pocketprotector::netsvc::freeradius::server::packages':}
    pocketprotector::files::templates::parse{'pocketprotector::netsvc::freeradius::server::templates':}
    pocketprotector::services::parse{'pocketprotector::netsvc::freeradius::server::services':}
  }
}

