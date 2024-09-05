# manifests/netsvc/apache.pp
#
# apache web server support 
#

class pocketprotector::netsvc::apache {
  if lookup('pocketprotector::netsvc::apache', undef, 'deep', false) {
    class { 'apache': }
  }
}


