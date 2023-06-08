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

  file { lookup('pocketprotector::puppet::client::configfile'):
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('pocketprotector/puppet/client/puppet.conf.erb'),
  }
}
