# manifests/netsvc/nginx.pp
#
# nginx web server support 
#

#define pocketprotector::netsvc::nginx::virthost (
#  String $vhostyaml = $name,
#){
#  $vhost_location = lookup('pocketprotector::netsvc::nginx::virthost_location', undef, 'deep', undef)
#  $vhost_symdir = lookup('pocketprotector::netsvc::nginx::virthost_symdir', undef, 'deep', undef)
#  $vhost_name = lookup("${vhostyaml}.name")
#  file {
#    "${vhost_location}/${vhost_name}":
#      content => template('pocketprotector/netsvc/nginx/virthost.erb'),
#      owner   => lookup('pocketprotector::netsvc::nginx::config::user');
#    "${vhost_symdir}/${vhost_name}":
#      type   => link,
#      target => "${vhost_location}/${vhost_name}";
#  }
#}

#class pocketprotector::netsvc::nginx {
#  if lookup('pocketprotector::netsvc::nginx::virthosts', undef, 'deep', false) {
#    pocketprotector::packages::parse{'pocketprotector::netsvc::nginx::packages':}
#    pocketprotector::files::parse{'pocketprotector::netsvc::nginx::files':}
#    pocketprotector::files::templates::parse{'pocketprotector::netsvc::nginx::templates':}
#    pocketprotector::services::parse{'pocketprotector::netsvc::nginx::services':}
#
#    # step through virthosts
#    lookup('pocketprotector::netsvc::nginx::virthosts', undef, 'deep', undef).each |String $virthost, Hash $virthash| {
#      pocketprotector::netsvc::nginx::virthost{"pocketprotector::netsvc::nginx::virthosts.${virthost}":}
#    }
#  }
#}


class pocketprotector::netsvc::nginx {
  if lookup('pocketprotector::netsvc::nginx', undef, 'deep', false) {
    inclide nginx
  }
}


