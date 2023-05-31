# manifests/puppet.pp
#
# managing client, server, and standalone instances of puppet
#

class pocketprotector::puppet::client {
  include pocketprotector::puppet::cron::client
  include pocketprotector::puppet::packages::client

  service {
    lookup('pocketprotector::puppet::client::servicename'):
      ensure => 'stopped',
      enable => 'false'
  }
}
