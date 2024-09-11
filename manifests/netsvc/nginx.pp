# manifests/netsvc/nginx.pp
#
# nginx web server support 
#

class pocketprotector::netsvc::nginx {
  if lookup('pocketprotector::netsvc::nginx', undef, 'deep', false) {
    include nginx
  }
}


