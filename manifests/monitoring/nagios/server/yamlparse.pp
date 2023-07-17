# manifests/monitoring/nagios/server/yamlparse.pp

# feeding yaml to nagios
#
# note: most of the custom work is to use a non-standard target specification
# also note: there may be missing configuration options. this is an MVP.
class pocketprotector::monitoring::nagios::server::yamlparse {
  # look configd and use as var, so we can munge it
  $nagconfigd = lookup('pocketprotector::monitoring::nagios::server::configd')

  # commands
  lookup('pocketprotector::monitoring::nagios::resources.command',undef,deep,undef).each | String $nagioscommand, Hash $commandhash | {
    @@nagios_command {
      $nagioscommand:
        ensure       => present,
        #export       => true,
        target       => "${nagconfigd}/command.cfg",
        command_line => lookup("pocketprotector::monitoring::nagios::resources.command.${nagioscommand}.command_line",undef,deep,undef);
    }
  }
  # contacts
  lookup('pocketprotector::monitoring::nagios::resources.contact',undef,deep,undef).each | String $nagioscontact, Hash $contacthash | {
    @@nagios_contact {
      $nagioscontact:
        ensure                        => present,
        #export                        => true,
        target                        => "${nagconfigd}/contact.cfg",
        alias                         => lookup("pocketprotector::monitoring::nagios::resources.contact.${nagioscontact}.alias",undef,deep,undef),
        email                         => lookup("pocketprotector::monitoring::nagios::resources.contact.${nagioscontact}.email",undef,deep,undef),
        host_notification_commands    => lookup("pocketprotector::monitoring::nagios::resources.contact.${nagioscontact}.host_notification_commands",undef,deep,undef),
        host_notification_options     => lookup("pocketprotector::monitoring::nagios::resources.contact.${nagioscontact}.host_notification_options",undef,deep,undef),
        host_notification_period      => lookup("pocketprotector::monitoring::nagios::resources.contact.${nagioscontact}.host_notification_period",undef,deep,undef),
        service_notification_commands => lookup("pocketprotector::monitoring::nagios::resources.contact.${nagioscontact}.service_notification_commands",undef,deep,undef),
        service_notification_options  => lookup("pocketprotector::monitoring::nagios::resources.contact.${nagioscontact}.service_notification_options",undef,deep,undef),
        service_notification_period   => lookup("pocketprotector::monitoring::nagios::resources.contact.${nagioscontact}.service_notification_period",undef,deep,undef);
    }
  }
  # contactgroups
  lookup('pocketprotector::monitoring::nagios::resources.contactgroup',undef,deep,undef).each | String $nagioscontactgroup, Hash $contactgrouphash | {
    @@nagios_contactgroup {
      $nagioscontactgroup:
        ensure  => present,
        #export  => true,
        target  => "${nagconfigd}/contactgroup.cfg",
        members => lookup("pocketprotector::monitoring::nagios::resources.contactgroup.${nagioscontactgroup}.members");
    }
  }
  # hosts
  lookup('pocketprotector::monitoring::nagios::resources.host',undef,deep,undef).each | String $nagioshost, Hash $hosthash | {
    @@nagios_host {
      $nagioshost:
        ensure                       => present,
        #export                       => true,
        target                       => "${nagconfigd}/${nagioshost}.cfg",
        alias                        => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.alias",undef,deep,undef),
        address                      => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.address",undef,deep,undef),
        check_command                => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.check_command",undef,deep,undef),
        contact_groups               => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.contact_groups",undef,deep,undef),
        event_handler_enabled        => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.event_handler_enabled",undef,deep,undef),
        flap_detection_enabled       => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.flap_detection_enabled",undef,deep,undef),
        host_name                    => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.hostname",undef,deep,undef),
        max_check_attempts           => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.max_check_attempts",undef,deep,undef),
        notification_interval        => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.notification_interval",undef,deep,undef),
        notification_period          => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.notification_period",undef,deep,undef),
        notification_options         => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.notification_options",undef,deep,undef),
        notifications_enabled        => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.notifications_enabled",undef,deep,undef),
        process_perf_data            => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.process_perf_data",undef,deep,undef),
        retain_status_information    => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.retain_status_information",undef,deep,undef),
        retain_nonstatus_information => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.retain_nonstatus_information",undef,deep,undef),
        register                     => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.register",undef,deep,1),
        use                          => lookup("pocketprotector::monitoring::nagios::resources.host.${nagioshost}.use",undef,deep,undef);
    }
  }
  # hostgroups
  lookup('pocketprotector::monitoring::nagios::resources.hostgroup',undef,deep,undef).each | String $nagioshostgroup, Hash $hostgrouphash | {
    @@nagios_hostgroup {
      $nagioshostgroup:
        ensure  => present,
        #export  => true,
        target  => "${nagconfigd}/hostgroups.cfg",
        alias   => lookup("pocketprotector::monitoring::nagios::resources.hostgroup.${nagioshostgroup}.alias",undef,deep,undef),
        members => lookup("pocketprotector::monitoring::nagios::resources.hostgroup.${nagioshostgroup}.members",undef,deep,undef),
    }
  }
  # services
  lookup('pocketprotector::monitoring::nagios::resources.service',undef,deep,undef).each | String $nagiosservice, Hash $servicehash | {
    @@nagios_service {
      $nagiosservice:
        ensure                       => present,
        #export                       => true,
        target                       => "${nagconfigd}/service.cfg",
        use                          => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.use",undef,deep,undef),
        host_name                    => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.host_name",undef,deep,undef),
        service_description          => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.service_description",undef,deep,undef),
        active_checks_enabled        => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.active_checks_enabled",undef,deep,undef),
        passive_checks_enabled       => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.passive_checks_enabled",undef,deep,undef),
        check_command                => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.check_command",undef,deep,undef),
        parallelize_check            => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.parallelize_check",undef,deep,undef),
        obsess_over_service          => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.obsess_over_service",undef,deep,undef),
        check_freshness              => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.check_freshness",undef,deep,undef),
        notifications_enabled        => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.notifications_enabled",undef,deep,undef),
        event_handler_enabled        => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.event_handler_enabled",undef,deep,undef),
        flap_detection_enabled       => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.flap_detection_enabled",undef,deep,undef),
        process_perf_data            => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.process_perf_data",undef,deep,undef),
        retain_status_information    => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.retain_status_information",undef,deep,undef),
        retain_nonstatus_information => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.retain_nonstatus_information",undef,deep,undef),
        is_volatile                  => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.is_volatile",undef,deep,undef),
        check_period                 => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.check_period",undef,deep,undef),
        max_check_attempts           => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.max_check_attempts",undef,deep,undef),
        check_interval               => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.check_interval",undef,deep,undef),
        retry_interval               => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.retry_interval",undef,deep,undef),
        contact_groups               => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.contact_groups",undef,deep,undef),
        notification_options         => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.notification_options",undef,deep,undef),
        notification_interval        => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.notification_interval",undef,deep,undef),
        notification_period          => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.notification_period",undef,deep,undef),
        register                     => lookup("pocketprotector::monitoring::nagios::resources.service.${nagiosservice}.register",undef,deep,1),
    }
  }
  # timeperiods
  lookup('pocketprotector::monitoring::nagios::resources.timeperiod',undef,deep,undef).each | String $nagiostimeperiod, Hash $timeperiodhash | {
    @@nagios_timeperiod {
      $nagiostimeperiod:
        ensure    => present,
        #export    => true,
        target    => "${nagconfigd}/timeperiod.cfg",
        alias     => lookup("pocketprotector::monitoring::nagios::resources.timeperiod.${nagiostimeperiod}.alias",undef,deep,undef),
        sunday    => lookup("pocketprotector::monitoring::nagios::resources.timeperiod.${nagiostimeperiod}.sunday",undef,deep,undef),
        monday    => lookup("pocketprotector::monitoring::nagios::resources.timeperiod.${nagiostimeperiod}.monday",undef,deep,undef),
        tuesday   => lookup("pocketprotector::monitoring::nagios::resources.timeperiod.${nagiostimeperiod}.tuesday",undef,deep,undef),
        wednesday => lookup("pocketprotector::monitoring::nagios::resources.timeperiod.${nagiostimeperiod}.wednesday",undef,deep,undef),
        thursday  => lookup("pocketprotector::monitoring::nagios::resources.timeperiod.${nagiostimeperiod}.thursday",undef,deep,undef),
        friday    => lookup("pocketprotector::monitoring::nagios::resources.timeperiod.${nagiostimeperiod}.friday",undef,deep,undef),
        saturday  => lookup("pocketprotector::monitoring::nagios::resources.timeperiod.${nagiostimeperiod}.saturday",undef,deep,undef),
    }
  }
}
