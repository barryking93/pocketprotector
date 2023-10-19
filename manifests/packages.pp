# manifests/packages.pp
#
class pocketprotector::packages {
  include pocketprotector::packages::repositories

  if lookup('pocketprotector::packages', undef, 'deep', false) {
    packages{lookup('pocketprotector::packages', undef, 'deep', false):}
  }
}

# build repository list & pass to appropriate module
class pocketprotector::packages::repositories {
  case lookup('pocketprotector::packages::provider') {
    'apt': {
      include pocketprotector::packages::repositories::apt
    }
    'zypper': {
      include pocketprotector::packages::repositories::zypper
    }
    default: {
      notify{'pocketprotector::packages::repositories: the package repository for your OS is not (yet?) supported':}
    }
  }
}
