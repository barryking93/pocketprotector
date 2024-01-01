# manifests/packages/updates/apt.pp
#
# apt automatic update support
#

define pocketprotector::packages::updates::apt (){
  if lookup('pocketprotector::packages::update::apt::packages',undef,'deep',false) {
    pocketprotector::packages::parse{'pocketprotector::packages::update::apt::packages':}
  }

  if lookup('pocketprotector::packages::update::apt::templates',undef,'deep',false) {
    pocketprotector::files::templates::parse{'pocketprotector::packages::update::apt::templates':}
  }
}

