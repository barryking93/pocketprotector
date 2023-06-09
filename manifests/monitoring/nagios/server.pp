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
  #include pocketprotector::monitoring::nagios::server::feedme
  #include pocketprotector::monitoring::nagios::server::import
}

# bulk import of yaml
#class pocketprotector::monitoring::nagios::server::feedme {
#  @@nagios_command {lookup('pocketprotector::monitoring::nagios::resources.command')}
#  @@nagios_contact {lookup('pocketprotector::monitoring::nagios::resources.contact')}
#  @@nagios_contactgroup {lookup('pocketprotector::monitoring::nagios::resources.contactgroup')}
#  @@nagios_host {lookup('pocketprotector::monitoring::nagios::resources.host')}
#  @@nagios_hostgroup {lookup('pocketprotector::monitoring::nagios::resources.hostgroup')}
#  @@nagios_service {lookup('pocketprotector::monitoring::nagios::resources.service')}
#  @@nagios_timeperiod {lookup('pocketprotector::monitoring::nagios::resources.timeperiod')}
#}
