# manifests/puppet/server/puppetdb.pp
#
# managing puppetdb, the puppet database
# which is a JAVA service w/ a postgres backend
#

class pocketprotector::puppet::server::puppetdb {
  class {
    'puppetdb::globals':
      puppet_confdir => lookup('pocketprotector::puppet::puppetdb::globals::puppet_confdir',undef,undef,undef),
      version        => lookup('pocketprotector::puppet::puppetdb::globals::version',undef,undef,undef);
    'puppetdb::database::postgresql':
      listen_addresses    => lookup('pocketprotector::puppet::puppetdb::database::listen_addresses',undef,undef,'localhost'),
      manage_package_repo => lookup('pocketprotector::puppet::puppetdb::database::managerepo',undef,undef,false),
      postgres_version    => lookup('pocketprotector::puppet::puppetdb::database::version',undef,undef,undef);
    'puppetdb::master::config':
      puppetdb_server                => lookup('pocketprotector::puppet::puppetdb::master::puppetdb_server',undef,undef,undef),
      puppetdb_port                  => lookup('pocketprotector::puppet::puppetdb::master::puppetdb_port',undef,undef,undef),
      puppetdb_disable_ssl           => lookup('pocketprotector::puppet::puppetdb::master::puppetdb_disable_ssl',undef,undef,undef),
      puppetdb_soft_write_failure    => lookup('pocketprotector::puppet::puppetdb::master::puppetdb_soft_write_failure',undef,undef,undef),
      manage_routes                  => lookup('pocketprotector::puppet::puppetdb::master::manage_routes',undef,undef,undef),
      manage_storeconfigs            => lookup('pocketprotector::puppet::puppetdb::master::manage_storeconfigs',undef,undef,undef),
      manage_report_processor        => lookup('pocketprotector::puppet::puppetdb::master::manage_report_processor',undef,undef,undef),
      manage_config                  => lookup('pocketprotector::puppet::puppetdb::master::manage_config',undef,undef,undef),
      create_puppet_service_resource => lookup('pocketprotector::puppet::puppetdb::master::create_puppet_service_resource',undef,undef,undef),
      strict_validation              => lookup('pocketprotector::puppet::puppetdb::master::strict_validation',undef,undef,undef),
      enable_reports                 => lookup('pocketprotector::puppet::puppetdb::master::enable_reports',undef,undef,undef),
      enable_storeconfigs            => lookup('pocketprotector::puppet::puppetdb::master::enable_storeconfigs',undef,undef,undef),
      puppet_confdir                 => lookup('pocketprotector::puppet::puppetdb::master::puppet_confdir',undef,undef,undef),
      puppet_conf                    => lookup('pocketprotector::puppet::puppetdb::master::puppet_conf',undef,undef,undef),
      masterless                     => lookup('pocketprotector::puppet::puppetdb::master::masterless',undef,undef,undef),
      terminus_package               => lookup('pocketprotector::puppet::puppetdb::master::terminus_package',undef,undef,undef),
      puppet_service_name            => lookup('pocketprotector::puppet::puppetdb::master::puppet_service_name',undef,undef,undef),
      puppetdb_startup_timeout       => lookup('pocketprotector::puppet::puppetdb::master::puppetdb_startup_timeout',undef,undef,undef),
      test_url                       => lookup('pocketprotector::puppet::puppetdb::master::test_url',undef,undef,undef),
      restart_puppet                 => lookup('pocketprotector::puppet::puppetdb::master::restart_puppet',undef,undef,undef);
    'puppetdb::server':
      database_name      => lookup('pocketprotector::puppet::puppetdb::database::name',undef,undef,'puppetdb'),
      database_host      => lookup('pocketprotector::puppet::puppetdb::database::hostname',undef,undef,'localhost'),
      java_args          => { '-Xmx' => lookup('pocketprotector::puppet::puppetdb::database::maxram',undef,undef,'2g') },
      ssl_set_cert_paths => true,
      vardir             => lookup('pocketprotector::puppet::puppetdb::vardir',undef,undef,undef);
  }
}
