# manifests/puppet/packages.pp

# install puppet client packages
class pocketprotector::puppet::packages::client {
  package { lookup('pocketprotector::puppet::packages::client'):
    ensure => installed,
  }
}

# install puppet server packages
class pocketprotector::puppet::packages::server {
  package { lookup('pocketprotector::puppet::packages::server'):
    ensure => installed,
  }
}
