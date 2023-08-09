# manifests/openbox.pp

class pocketprotector::openbox {
  if lookup('pocketprotector::openbox::enabled',undef,deep,false) {
    packages {
      lookup('pocketprotector::openbox::packages',undef,deep,undef):
        ensure => installed;
    }
    file {
      lookup('pocketprotector::openbox::packages',undef,deep,undef)
    }
  }
}
