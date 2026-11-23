# manifests/puppet.pp
#
# managing client, server, and standalone instances of puppet
#

class pocketprotector::puppet::server {
  include pocketprotector::puppet::cron::server
  include pocketprotector::utils::git
  include pocketprotector::puppet::server::puppetdb
  include pocketprotector::puppet::server::puppetboard

  pocketprotector::packages::parse{'pocketprotector::puppet::client::packages':}

  $puppetbinprefix = lookup('pocketprotector::puppet::prefix::bin')
  $puppetcfgprefix = lookup('pocketprotector::puppet::prefix::cfg')

  cron {
    'clean up puppetserver reports cache':
      command => 'find /opt/puppetlabs/puppet/cache/reports/ -type f -ctime +90 -delete',
      hour    => '0',
      minute  => '0',
      weekday => '0';
  }

  if lookup('pocketprotector::puppet::prefix::bin') == '/opt/puppetlabs/bin' {
    exec {
      'install r10k':
        command => '/opt/puppetlabs/puppet/bin/gem install r10k',
        creates => '/opt/puppetlabs/puppet/bin/r10k';
    }
  }
  exec {
    'deploy r10k':
      command     => "${puppetbinprefix}/r10k deploy environment -p",
      refreshonly => 'true',
  }

  file {
    #    "${puppetcfgprefix}/puppetdb.conf":
    #  owner   => 'root',
    #  group   => 'root',
    #  mode    => '0644',
    #  content => template('pocketprotector/puppet/server/puppetdb.conf.erb');
    lookup('pocketprotector::puppet::server::defaults'):
      mode    => '0644',
      content => template('pocketprotector/puppet/server/defaults.erb'),
      notify  => Service[lookup('pocketprotector::puppet::server::servicename')];
    '/etc/puppetlabs/r10k':
      ensure => 'directory',
      mode   => '0755';
    '/etc/puppetlabs/r10k/r10k.yaml':
      mode    => '0644',
      content => template('pocketprotector/puppet/server/r10k.yaml.erb'),
      notify  => [
        Exec['deploy r10k'],
        Service[lookup('pocketprotector::puppet::server::servicename')]
      ]
  }

}
