# manifests/fs/nfs.pp
#

define pocketprotector::fs::nfs::mounts::parse (
  String $mountyaml = $name,
){
  if lookup($mountyaml, undef, 'deep', false) {
    $fstypedefault = lookup('pocketprotector::fs::nfs::defaults.fstype', undef, 'first', undef)
    $optionsdefault = lookup('pocketprotector::fs::nfs::defaults.options', undef, 'first', undef)

    pocketprotector::packages::parse{'pocketprotector::fs::nfs::base':}

    lookup($mountyaml, undef, 'deep', undef).each |String $mountname, Hash $mounthash| {
      #notify {"pocketprotector::fs::nfs::mounts::parse: debug file for ${mountname}":}

      mount { $mountname:
        name        => lookup("${mountyaml}.${mountname}.name", undef, 'deep', undef),
        ensure      => lookup("${mountyaml}.${mountname}.ensure", undef, 'deep', 'mounted'),
        atboot      => lookup("${mountyaml}.${mountname}.atboot", undef, 'deep', true),
        blockdevice => lookup("${mountyaml}.${mountname}.blockdevice", undef, 'deep', undef),
        device      => lookup("${mountyaml}.${mountname}.device", undef, 'deep', undef), 
        dump        => lookup("${mountyaml}.${mountname}.dump", undef, 'deep', undef),
        fstype      => lookup("${mountyaml}.${mountname}.fstype", undef, 'deep', $fstypedefault),
        options     => lookup("${mountyaml}.${mountname}.options", undef, 'deep', $optionsdefault),
        pass        => lookup("${mountyaml}.${mountname}.pass", undef, 'deep', undef),
        provider    => lookup("${mountyaml}.${mountname}.provider", undef, 'deep', undef),
        remounts    => lookup("${mountyaml}.${mountname}.remounts", undef, 'deep', undef),
        target      => lookup("${mountyaml}.${mountname}.target", undef, 'deep', undef),
      }
    }
  }
}

# 
# TO DO:  nfs exports
#
# define pocketprotector::fs::nfs::exports::parse (
#   String $mountyaml = $name,
# ){
# }

class pocketprotector::fs::nfs {
  pocketprotector::fs::nfs::mounts::parse{'pocketprotector::fs::nfs::mounts':}
}
