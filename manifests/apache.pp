# manifests/apache.pp

class pocketprotector::apache {
  class { 'apache':
    default_vhost => false,
  }
}
