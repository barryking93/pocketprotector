# manifests/monitoring/splunk.pp
#

class pocketprotector::monitoring::splunk {
  class { 
    'splunk::params':
      server => lookup('pocketprotector::monitoring::splunk::server');
  }

  # enterprise on server, forwarder elsewhere
  case $::fqdn {
    lookup('pocketprotector::monitoring::splunk::server'): {
      include splunk::enterprise

      # parse inputs if they exist
      if lookup('pocketprotector::monitoring::splunk::inputs',undef,'deep',false) {
        lookup('pocketprotector::monitoring::splunk::inputs',undef,'deep',undef).each | String $splunkinput, Hash $inputhash | {
          splunk_input {
            $splunkinput:
              section => lookup("pocketprotector::monitoring::splunk::inputs.${splunkinput}.section",undef,deep,undef),
              setting => lookup("pocketprotector::monitoring::splunk::inputs.${splunkinput}.setting",undef,deep,undef),
              value   => lookup("pocketprotector::monitoring::splunk::inputs.${splunkinput}.value",undef,deep,undef),
              tag     => lookup("pocketprotector::monitoring::splunk::inputs.${splunkinput}.tag",undef,deep,undef),
          }
        }
      }
    }
    default: {
      class {
        'splunk::forwarder':
          package_ensure => 'latest',
      }
      include splunk::forwarder

      # parse inputs if they exist
      if lookup('pocketprotector::monitoring::splunk::inputs',undef,'deep',false) {
        lookup('pocketprotector::monitoring::splunk::inputs',undef,'deep',undef).each | String $splunkinput, Hash $inputhash | {
          splunkforwarder_input {
            $splunkinput:
              section => lookup("pocketprotector::monitoring::splunk::inputs.${splunkinput}.section",undef,deep,undef),
              setting => lookup("pocketprotector::monitoring::splunk::inputs.${splunkinput}.setting",undef,deep,undef),
              value   => lookup("pocketprotector::monitoring::splunk::inputs.${splunkinput}.value",undef,deep,undef),
              tag     => lookup("pocketprotector::monitoring::splunk::inputs.${splunkinput}.tag",undef,deep,undef),
          }
        }  
      }
    }
  }
}

