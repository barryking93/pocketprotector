# manifests/packages/repositories.pp
#
# package repository support
#

define pocketprotector::packages::repositories::parse (
  String $repositoriesyaml = $name,
){
  case lookup('pocketprotector::packages::provider') {
    'apt': {
      pocketprotector::packages::repositories::apt::source::parse{$repositoriesyaml:}
    }
    'zypper': {
      pocketprotector::packages::repositories::zypper::parse{$repositoriesyaml:}
    }
}

# build repository list & pass to appropriate module
class pocketprotector::packages::repositories {
  case lookup('pocketprotector::packages::provider') {
    'apt': {
      include pocketprotector::packages::repositories::apt::init
      pocketprotector::packages::repositories::apt::pin::parse{'pocketprotector::packages::pin':}
      pocketprotector::packages::repositories::apt::ppa::parse{'pocketprotector::packages::ppa':}
      include pocketprotector::packages::updates::apt
    }
    # if we ever need any special init for zypper, it'll go below 
    'zypper': {}
    default: {
      notify{'pocketprotector::packages::repositories: the package repository for your OS is not (yet?) supported':}
    }
  }
  pocketprotector::packages::repositories::parse{'pocketprotector::packages::repositories':}
}

