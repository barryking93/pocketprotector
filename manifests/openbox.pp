# manifests/openbox.pp

class pocketprotector::openbox {
  if lookup('pocketprotector::openbox::enabled',undef,deep,false) {
    packages {
      lookup('pocketprotector::openbox::packages',undef,deep,undef):
        ensure => installed;
    }
    lookup('pocketprotector::openbox::files', undef, 'deep', undef).each |String $filename, Hash $filehash| {
      notify {"pocketprotector::openbox::files: debug file for ${filename}":}

      file {
        $filename: $filehash
      }
    }
  }
}
