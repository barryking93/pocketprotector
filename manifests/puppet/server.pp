# manifests/puppet.pp
#
# managing client, server, and standalone instances of puppet
#

class pocketprotector::puppet::server {
  class {
    'puppetdb::database::postgresql':
    'puppetdb':
  }

  include pocketprotector::puppet::cron::server
  include pocketprotector::puppet::packages::client
  include pocketprotector::puppet::packages::server
  include pocketprotector::utils::git

  # defaults for Debian-based systems
  if lookup('pocketprotector::puppet::defaults', undef, undef, false) {
    file {
      '/etc/default/puppetserver':
        mode    => '0644',
        content => template('pocketprotector/puppet/server/defaults.erb'),
        notify  => Service[lookup('pocketprotector::puppet::server::servicename')]
    }
  }

  exec {
    'install r10k':
      command => '/opt/puppetlabs/puppet/bin/gem install r10k',
      creates => '/opt/puppetlabs/puppet/bin/r10k';
    'deploy r10k':
      command     => '/opt/puppetlabs/puppet/bin/r10k deploy environment -p',
      refreshonly => 'true',
  }

  file {
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

  service {
    lookup('pocketprotector::puppet::server::servicename'):
      ensure => 'running',
      enable => 'true'
  }
}
