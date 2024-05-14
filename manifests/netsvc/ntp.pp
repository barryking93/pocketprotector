# manifests/netsvc/ntp.pp
#
# freeradius for tie-in with samba/ntlm
#

class pocketprotector::netsvc::ntp {
  if lookup('pocketprotector::netsvc::ntp::servers', undef, 'deep', false) {
    pocketprotector::packages::parse{'pocketprotector::netsvc::ntp::packages':}
    #pocketprotector::files::templates::parse{'pocketprotector::netsvc::ntp::templates':}
    file {
      '/etc/ntp.conf':
        content => template('pocketprotector/netsvc/ntp/ntp.conf.erb')
    }
    pocketprotector::services::parse{'pocketprotector::netsvc::ntp::services':}
  }
}

