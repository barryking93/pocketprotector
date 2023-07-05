# manifests/packages.pp
#
class pocketprotector::packages {
  include pocketprotector::packages::repositories
  include pocketprotector::packages::install
}

# package installer
class pocketprotector::packages::install {
  case lookup('pocketprotector::packages', undef, 'deep', false) {
    false: {}
    default: {
      package {
        lookup('pocketprotector::packages', undef, 'deep', undef):
          ensure => installed;
      }
    }
  }
  case lookup('pocketprotector::packages::latest', undef, 'deep', false) {
    false: {}
    default: {
      package {
        lookup('pocketprotector::packages::latest', undef, 'deep', undef):
          ensure => latest;
      }
    }
  }
}

# build repository list & pass to appropriate module
class pocketprotector::packages::repositories {
  case lookup('pocketprotector::packages::provider') {
    'apt': {
      class {'apt':
        purge => {
          'sources.list'   => true,
          'sources.list.d' => true
        };
      }

      lookup('pocketprotector::packages::repositories',undef,deep,undef).each | String $aptrepo, Hash $aptrepohash | {
        apt::source { $aptrepo:
          location => lookup("pocketprotector::packages::repositories.${aptrepo}.location"),undef,first,undef),
          release  => lookup("pocketprotector::packages::repositories.${aptrepo}.release"),undef,first,undef),
          repos    => lookup("pocketprotector::packages::repositories.${aptrepo}.release"),undef,first,undef),
          key      => {
            'id'     => lookup("pocketprotector::packages::repositories.${aptrepo}.key.id"),undef,first,undef),
            'source' => lookup("pocketprotector::packages::repositories.${aptrepo}.key.source"),undef,first,undef),
          }
        }
      }
    }
    'dnf': {}
    'zypper': {}
    default: {
      notify{'the package repository for your OS is not (yet?) supported'}:
    }
  }
}
