# manifests/puppet/server/puppetdb.pp
#
# managing puppetdb, the puppet database
# which is a JAVA service w/ a postgres backend
#

class pocketprotector::puppet::server::puppetdb {
  class {
    'puppetdb::server':
      database_host      => lookup('pocketprotector::puppet::puppetdb::database::hostname',undef,undef,'localhost'),
      java_args          => { '-Xmx' => lookup('pocketprotector::puppet::puppetdb::database::maxram',undef,undef,'2g') },
      ssl_set_cert_paths => true;
    'puppetdb::database::postgresql':
      listen_addresses => lookup('pocketprotector::puppet::puppetdb::database::listen_addresses',undef,undef,'localhost'),
      postgres_version => lookup('pocketprotector::puppet::puppetdb::database::version',undef,undef,undef),
  }
}
