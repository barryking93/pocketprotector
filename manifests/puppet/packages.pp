# manifests/puppet/packages.pp

pocketprotector::puppet::packages::client {
  package { lookup('pocketprotector::puppet::packages::client'):
    ensure => installed,
  }
}

pocketprotector::puppet::packages::server {
  package { lookup('pocketprotector::puppet::packages::server'):
    ensure => installed,
  }
}
