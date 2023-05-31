# manifests/puppet.pp
#

class pocketprotector::puppet {
  case $::fqdn {
    lookup('pocketprotector::puppet::server'): {
      include pocketprotector::puppet::server
    }
    default: {
      include pocketprotector::puppet::client
    }
  }
}
