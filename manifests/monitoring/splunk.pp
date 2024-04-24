# manifests/monitoring/splunk.pp
#

class pocketprotector::monitoring::splunk {
  class { 
    'splunk::params':
      server => lookup('pocketprotector::monitoring::splunk::server');
    'splunk::forwarder':
      package_ensure => 'latest',
  }

  case $::fqdn {
    lookup('pocketprotector::monitoring::splunk::server'): {
      include splunk::enterprise
    }
    default: {
      include splunk::forwarder
    }
  }
}

