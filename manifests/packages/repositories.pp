# manifests/packages/repositories.pp
#
# package repository support
#

define pocketprotector::packages::repositories::parse (
  String $repoyaml = $name,
){
  case lookup('pocketprotector::packages::provider') {
    'apt': {
      pocketprotector::packages::repositories::apt::parse{$repoyaml:}
    }
    'zypper': {
      pocketprotector::packages::repositories::zypper::parse{$repoyaml:}
    }
  }
}

# build repository list & pass to appropriate modules
class pocketprotector::packages::repositories {
  case lookup('pocketprotector::packages::provider') {
    'apt': {
      include pocketprotector::packages::repositories::apt::init
      pocketprotector::packages::repositories::parse{'pocketprotector::packages::repositories':}
      pocketprotector::packages::repositories::apt::pin::parse{'pocketprotector::packages::pin':}
      pocketprotector::packages::repositories::apt::ppa::parse{'pocketprotector::packages::ppa':}
      include pocketprotector::packages::updates::apt
    }
    'zypper': {
      pocketprotector::packages::repositories::parse{'pocketprotector::packages::repositories':}
    }
    default: {
      notify{'pocketprotector::packages::repositories: the package repository for your OS is not (yet?) supported':}
    }
  }
}

