# manifests/monitoring/splunk.pp
#

class pocketprotector::monitoring::splunk {
  class { 
    'splunk::params':
      server => lookup('pocketprotector::monitoring::splunk::server');
  }

  case $::fqdn {
    lookup('pocketprotector::monitoring::splunk::server'): {
      include splunk::enterprise
    }
    default: {
      class {
        'splunk::forwarder':
          package_ensure => 'latest',
      }
      include splunk::forwarder
    }
  }
}

