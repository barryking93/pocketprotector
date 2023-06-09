# manifests/puppet.pp
#

# everyone gets the client, but only the server gets the server
class pocketprotector::puppet {
  include pocketprotector::puppet::client
  case $::fqdn {
    lookup('pocketprotector::puppet::server'): {
      include pocketprotector::puppet::server
    }
    default: {}
  }
}
