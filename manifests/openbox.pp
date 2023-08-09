# manifests/openbox.pp

class pocketprotector::openbox {
  if lookup('pocketprotector::openbox::enabled',undef,deep,false) {
    # deploy packages
    package {
      lookup('pocketprotector::openbox::packages',undef,deep,undef):
        ensure => installed;
    }
    # configure files
    lookup('pocketprotector::openbox::files', undef, 'deep', undef).each |String $filename, Hash $filehash| {
      #notify {"pocketprotector::openbox: debug file for ${filename}":}

      file {
        $filename:
          path                    => lookup("pocketprotector::openbox::files.${filename}.path", undef, 'deep', undef),
          source                  => lookup("pocketprotector::openbox::files.${filename}.source", undef, 'deep', undef),
      }
    }
    # configure templates
    lookup('pocketprotector::openbox::files::templates', undef, 'deep', undef).each |String $filename, Hash $filehash| {
      #notify {"pocketprotector::openbox: debug file template for ${filename}":}

      file {
        $filename:
          path                    => lookup("pocketprotector::openbox::files::templates.${filename}.path", undef, 'deep', undef),
          content                 => template(lookup("pocketprotector::openbox::files::templates.${filename}.content", undef, 'deep', undef)),
      }
    }
  }
}
