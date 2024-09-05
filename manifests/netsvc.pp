# manifests/netsvc.pp
#
# network services
#

class pocketprotector::netsvc {
  include pocketprotector::netsvc::apache
  include pocketprotector::netsvc::freeradius
  include pocketprotector::netsvc::nginx
  include pocketprotector::netsvc::ntp
}
