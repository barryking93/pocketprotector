# manifests/monitoring/nagios/server.pp

class pocketprotector::monitoring::nagios::server {
  package {
    lookup('pocketprotector::monitoring::nagios::packages::server', undef, 'deep', undef):
      ensure => 'present'
    }
  }

  # keep service running
  service {
    lookup('pocketprotector::monitoring::nagios::service::server'):
      ensure => 'running',
      enable => true,
  }

  # primary nagios config
  file {
    lookup('pocketprotector::monitoring::nagios::client::configfile'):
      mode    => '0444',
      notify  => Service[lookup('pocketprotector::monitoring::nagios::service::server')],
      require => Package[lookup('pocketprotector::monitoring::nagios::packages::server')];
  }

  # feeding yaml to nagios
  #
  # note: most of the custom work is to use a non-standard target specification
  # also note: there may be missing configuration options. this is an MVP.
  #

  lookup('pocketprotector::monitoring::nagios::resources',undef,deep,undef).each | String $nagiosresource, Hash $resourcehash | {
    case $nagiosresource {
      command: {
        lookup('pocketprotector::monitoring::nagios::resources.command',undef,deep,undef).each | String $nagioscommand, Hash $commandhash | {
          @@nagios_command {
            $nagioscommand: {
              target       => "%{lookup("pocketprotector::monitoring::nagios::server::configd")}/command.cfg",
              command_line => lookup("pocketprotector::monitoring::nagios::resources.command.${nagioscommand}",
            }
          }
        }
      }
      contact: {
        lookup('pocketprotector::monitoring::nagios::resources.contact',undef,deep,undef).each | String $nagioscontact, Hash $contacthash | {
          @@nagios_contact {
            $nagioscontact: {
              target => lookup("pocketprotector::monitoring::nagios::server::configd") + "/contact.cfg"
              alias => lookup("pocketprotector::monitoring::nagios::resources.contact.${nagioscontact}.alias"
              email => lookup("pocketprotector::monitoring::nagios::resources.contact.${nagioscontact}.email"
              host_notification_commands => lookup("pocketprotector::monitoring::nagios::resources.contact.${nagioscontact}.host_notification_commands"
              host_notification_options => lookup("pocketprotector::monitoring::nagios::resources.contact.${nagioscontact}.host_notification_options"
              host_notification_period => lookup("pocketprotector::monitoring::nagios::resources.contact.${nagioscontact}.host_notification_period"
              service_notification_commands => lookup("pocketprotector::monitoring::nagios::resources.contact.${nagioscontact}.service_notification_commands"
              service_notification_options => lookup("pocketprotector::monitoring::nagios::resources.contact.${nagioscontact}.service_notification_options"
              service_notification_period => lookup("pocketprotector::monitoring::nagios::resources.contact.${nagioscontact}.service_notification_period"
            }
          }
        }
      }
      contactgroup: {
        lookup('pocketprotector::monitoring::nagios::resources.contactgroup',undef,deep,undef).each | String $nagioscontactgroup, Hash $contactgrouphash | {
          @@nagios_contactgroup {
            $nagioscontactgroup: {
              target  => "%{lookup("pocketprotector::monitoring::nagios::server::configd")}/contactgroup.cfg"
              members => lookup("pocketprotector::monitoring::nagios::resources.contactgroup.${nagioscontactgroup}",
            }
          }
        }
      }
      host: {
        lookup('pocketprotector::monitoring::nagios::resources.host',undef,deep,undef).each | String $nagioshost, Hash $hosthash | {
          @@nagios_host {
            $nagioshost: {
              target => "%{lookup("pocketprotector::monitoring::nagios::server::configd")}/host_${nagioshost}.cfg"
              alias => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.use",undef,deep,undef),
              address => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.use",undef,deep,undef),
              check_command => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.use",undef,deep,undef),
              contact_groups => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.contact_groups",undef,deep,undef),
              event_handler_enabled => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.use",undef,deep,undef),
              flap_detection_enabled => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.use",undef,deep,undef),
              failure_prediction_enabled => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.use",undef,deep,undef),
              hostname => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.use",undef,deep,undef),
              max_check_attempts => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.use",undef,deep,undef),
              notification_interval => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.use",undef,deep,undef),
              notification_period => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.use",undef,deep,undef),
              notification_options => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.use",undef,deep,undef),
              notifications_enabled => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.use",undef,deep,undef),
              process_perf_data => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.use",undef,deep,undef),
              retain_status_information => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.use",undef,deep,undef),
              retain_nonstatus_information => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.use",undef,deep,undef),
              register => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.register",undef,deep,1),
              use => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.use",undef,deep,undef),
            }
          }
        }
      }
      hostgroup: {
        lookup('pocketprotector::monitoring::nagios::resources.hostgroup',undef,deep,undef).each | String $nagioshostgroup, Hash $hostgrouphash | {
          @@nagios_hostgroup {
            $nagioshostgroup: {
              target => "%{lookup("pocketprotector::monitoring::nagios::server::configd")}/hostgroups.cfg"
              alias => lookup("pocketprotector::monitoring::nagios::resources.hostgroup.${nagioshostgroup}.alias",undef,deep,undef),
              members => lookup("pocketprotector::monitoring::nagios::resources.hostgroup.${nagioshostgroup}.members",undef,deep,undef),
            }
          }
        }
      }
      service: {
        lookup('pocketprotector::monitoring::nagios::resources.service',undef,deep,undef).each | String $nagiosservice, Hash $servicehash | {
          @@nagios_service {
            $nagiosservice: {
              target => "%{lookup("pocketprotector::monitoring::nagios::server::configd")}/service.cfg"
              active_checks_enabled => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.active_checks_enabled",undef,deep,1),
              passive_checks_enabled => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.passive_checks_enabled",undef,deep,1),
              parallelize_check => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.parallelize_check",undef,deep,1),
              obsess_over_service => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.obsess_over_service",undef,deep,1),
              check_freshness => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.check_freshness",undef,deep,1),
              notifications_enabled => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.notifications_enabled",undef,deep,1),
              event_handler_enabled => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.event_handler_enabled",undef,deep,1),
              flap_detection_enabled => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.flap_detection_enabled",undef,deep,1),
              process_perf_data => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.process_perf_data",undef,deep,1),
              retain_status_information => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.retain_status_information",undef,deep,1),
              retain_nonstatus_information => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.retain_nonstatus_information",undef,deep,1),
              is_volatile => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.is_volatile",undef,deep,undef),
              check_period => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.check_period",undef,deep,undef),
              max_check_attempts => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.max_check_attempts",undef,deep,undef),
              check_interval => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.check_interval",undef,deep,undef),
              retry_interval => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.retry_interval",undef,deep,undef),
              contact_groups => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.contact_groups",undef,deep,undef),
              notification_options => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.notification_options",undef,deep,undef),
              notification_interval => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.notification_interval",undef,deep,undef),
              notification_period => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.notification_period",undef,deep,undef),
              register => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.register",undef,deep,1),
            }
          }
        }
      }
      timeperiod: {
        lookup('pocketprotector::monitoring::nagios::resources.timeperiod',undef,deep,undef).each | String $nagiostimeperiod, Hash $timeperiodhash | {
          @@nagios_timeperiod {
            $nagiosservice: {
              target => "%{lookup("pocketprotector::monitoring::nagios::server::configd")}/timeperiod.cfg"
              alias => lookup("pocketprotector::monitoring::nagios::resources.timeperiod.${nagiostimeperiod}.alias",undef,deep,undef),
              sunday => lookup("pocketprotector::monitoring::nagios::resources.timeperiod.${nagiostimeperiod}.sunday",undef,deep,undef),
              monday => lookup("pocketprotector::monitoring::nagios::resources.timeperiod.${nagiostimeperiod}.monday",undef,deep,undef),
              tuesday => lookup("pocketprotector::monitoring::nagios::resources.timeperiod.${nagiostimeperiod}.tuesday",undef,deep,undef),
              wednesday => lookup("pocketprotector::monitoring::nagios::resources.timeperiod.${nagiostimeperiod}.wednesday",undef,deep,undef),
              thursday => lookup("pocketprotector::monitoring::nagios::resources.timeperiod.${nagiostimeperiod}.thursday",undef,deep,undef),
              friday => lookup("pocketprotector::monitoring::nagios::resources.timeperiod.${nagiostimeperiod}.friday",undef,deep,undef),
              saturday => lookup("pocketprotector::monitoring::nagios::resources.timeperiod.${nagiostimeperiod}.saturday",undef,deep,undef),
            }
          }
        }
      }
    }
  }
}
