# manifests/openbox.pp

class pocketprotector::openbox {
  if lookup('pocketprotector::openbox::enabled',undef,'deep',false) {
    # deploy packages
    package {
      lookup('pocketprotector::openbox::packages',undef,'deep',undef):
        ensure => installed;
    }
    # configure files
    pocketprotector::files(lookup('pocketprotector::openbox::files', undef, 'deep', undef)
    # configure templates
    pocketprotector::files(lookup('pocketprotector::openbox::files::templates', undef, 'deep', undef)
  }
}
