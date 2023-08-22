# manifests/puppet.pp
#
# managing client, server, and standalone instances of puppet
#

class pocketprotector::puppet::server {
  include pocketprotector::puppet::cron::server
  include pocketprotector::puppet::packages::client
  include pocketprotector::puppet::packages::server
  include pocketprotector::utils::git
  include pocketprotector::puppet::server::puppetdb
  include pocketprotector::puppet::server::puppetboard

  exec {
    'install r10k':
      command => '/opt/puppetlabs/puppet/bin/gem install r10k',
      creates => '/opt/puppetlabs/puppet/bin/r10k';
    'deploy r10k':
      command     => '/opt/puppetlabs/puppet/bin/r10k deploy environment -p',
      refreshonly => 'true',
  }

  file {
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

  service {
    lookup('pocketprotector::puppet::server::servicename'):
      ensure => 'running',
      enable => 'true'
  }
}

class pocketprotector::puppet::server::puppetboard {
  include pocketprotector::apache

  class { 'puppetboard':
    python_version    => '3.8',
    manage_virtualenv => true,
    extra_settings    => {
      'SECRET_KEY'     => lookup('pocketprotector::puppet::server::puppetboard::secret_key')
    },
  }

  class { 'puppetboard::apache::vhost':
    vhost_name => lookup('pocketprotector::puppet::server::puppetboard::hostname', undef, 'first', "${::fqdn}"),
    port       => 80,
  }
}

class pocketprotector::puppet::server::puppetdb {
  class {
    'puppetdb::server':
      database_host => lookup('pocketprotector::puppet::puppetdb::database::hostname',undef,undef,'localhost'),
      java_args     => { '-Xmx' => lookup('pocketprotector::puppet::puppetdb::database::maxram',undef,undef,'2g') },
      ssl_deploy_certs => true;
    'puppetdb::database::postgresql':
      listen_addresses => lookup('pocketprotector::puppet::puppetdb::database::listen_addresses',undef,undef,'localhost'),
      postgres_version => lookup('pocketprotector::puppet::puppetdb::database::version',undef,undef,undef),
  }
}
