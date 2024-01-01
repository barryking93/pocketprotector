# manifests/packages/updates/apt.pp
#
# apt automatic update support
#

class pocketprotector::packages::updatess::apt {
  if lookup('pocketprotector::packages::updates::apt::packages',undef,'deep',false) {
    pocketprotector::packages::parse{'pocketprotector::packages::updates::apt::packages':}
  }

  if lookup('pocketprotector::packages::updates::apt::files::templates',undef,'deep',false) {
    pocketprotector::files::templates::parse{'pocketprotector::packages::updates::apt::files::templates':}
  }
}

