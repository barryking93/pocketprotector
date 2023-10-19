# manifests/openbox.pp

class pocketprotector::openbox {
  if lookup('pocketprotector::openbox::enabled',undef,'deep',false) {
    packages {
      lookup('pocketprotector::openbox::packages',undef,'deep',undef):
    }
    pocketprotector::files(lookup('pocketprotector::openbox::files', undef, 'deep', undef)
    pocketprotector::files::templates(lookup('pocketprotector::openbox::files::templates', undef, 'deep', undef)
  }
}
