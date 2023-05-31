# manifests/puppet/packages.pp

class pocketprotector::puppet::packages::client {
  package { lookup('pocketprotector::puppet::packages::client'):
    ensure => installed,
  }
}

class pocketprotector::puppet::packages::server {
  package { lookup('pocketprotector::puppet::packages::server'):
    ensure => installed,
  }
}
