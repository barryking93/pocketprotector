# manifests/puppet.pp
#

# everyone gets the client, but only the server gets the server
class pocketprotector::puppet {
  case $::fqdn {
    lookup('pocketprotector::puppet::server'): {
      include pocketprotector::puppet::server
    }
    default: {
      include pocketprotector::puppet::client
    }
  }

  file {
    lookup('pocketprotector::puppet::client::configfile'):
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('pocketprotector/puppet/client/puppet.conf.erb');
    lookup('pocketprotector::puppet::client::configpuppetdb'):
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('pocketprotector/puppet/client/puppetdb.conf.erb');
  }
}
