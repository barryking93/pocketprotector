# manifests/puppet.pp
#

# everyone gets the client, but only the server gets the server
class pocketprotector::puppet {
  case $facts['networking']['fqdn'] {
    lookup('pocketprotector::puppet::server'): {
      include pocketprotector::puppet::server
    }
    default: {
      include pocketprotector::puppet::client
    }
  }

  $puppetcfgprefix = lookup('pocketprotector::puppet::prefix::cfg')  

  file {
    "${puppetcfgprefix}/puppet.conf":
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('pocketprotector/puppet/client/puppet.conf.erb');
  }
}
