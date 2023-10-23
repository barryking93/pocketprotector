# manifests/openbox.pp

class pocketprotector::openbox {
  if lookup('pocketprotector::openbox::enabled',undef,'deep',false) {
    pocketprotector::packages::parse {'pocketprotector::openbox::packages':}
    pocketprotector::files::parse{'pocketprotector::openbox::files':}
    pocketprotector::files::templates::parse{'pocketprotector::openbox::files::templates':}
  }
}
