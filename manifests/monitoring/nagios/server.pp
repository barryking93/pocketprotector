# manifests/monitoring/nagios/server.pp

class pocketprotector::monitoring::nagios::server {
  package {
    lookup('pocketprotector::monitoring::nagios::packages::server', undef, 'deep', undef):
      ensure => 'present'
    }

  # keep service running
  service {
    lookup('pocketprotector::monitoring::nagios::service::server'):
      ensure => 'running',
      enable => true,
  }

  # primary nagios config
  file {
    lookup('pocketprotector::monitoring::nagios::server::configfile'):
      mode    => '0444',
      content => template('pocketprotector/monitoring/nagios/nagios.cfg.erb'),
      notify  => Service[lookup('pocketprotector::monitoring::nagios::service::server')],
      require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')];
  }

  include pocketprotector::monitoring::nagios::server::yamlparse
  include pocketprotector::monitoring::nagios::server::import
}
