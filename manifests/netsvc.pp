# manifests/netsvc.pp
#
# network services
#

class pocketprotector::netsvc {
  include pocketprotector::netsvc::freeradius
  include pocketprotector::netsvc::ntp
}
