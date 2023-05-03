# manifests/puppet.pp

pocketprotector::puppet {
  case $::fqdn {
    lookup('pocketprotector::puppet::server'): {
      include pocketprotector::puppet::server
    }
    default: {
      include pocketprotector::puppet::client
    }
  }
}

pocketprotector::puppet::client {
  include pocketprotector::puppet::cron::client
  include pocketprotector::puppet::packages::client

  service {
    lookup('pocketprotector::puppet::client::servicename'):
      ensure => 'running',
      enable => 'true'
  }
}

pocketprotector::puppet::server {
  include pocketprotector::puppet::cron::server
  include pocketprotector::puppet::packages::client
  include pocketprotector::puppet::packages::server
  include pocketprotector::utils::git

  # defaults for Debian-based systems
  if lookup("pocketprotector::puppet::defaults", undef, undef, false) {
    file {
      '/etc/default/puppetserver':
        mode    => '0644',
        content => template('pocketprotector/puppet/server/defaults.erb'),
        notify  => Service[lookup('pocketprotector::puppet::server::servicename')]
    }
  }

  command {
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
      content => template('pocketprotector/puppet/server/defaults.erb'),
      notify  => [
        Command['deploy r10k'],
        Service[lookup('pocketprotector::puppet::server::servicename')]
      ]
  }

  service {
    lookup('pocketprotector::puppet::servicename'):
      ensure => 'running',
      enable => 'true'
  }
}
