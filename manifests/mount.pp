# manifests/mount.pp
#
# handling mount points
#

define pocketprotector::mount::parse (
  String $mountyaml = $name,
){
  if lookup($mountyaml, undef, 'deep', false) {
    lookup($mountyaml, undef, 'deep', undef).each |String $mountname, Hash $mounthash| {
      #notify {"pocketprotector::fs::nfs::mounts::parse: debug file for ${mountname}":}

      mount { lookup("${mountyaml}.${mountname}.target", undef, 'deep', undef):
        name        => lookup("${mountyaml}.${mountname}.name", undef, 'deep', undef),
        ensure      => lookup("${mountyaml}.${mountname}.ensure", undef, 'deep', 'mounted'),
        atboot      => lookup("${mountyaml}.${mountname}.atboot", undef, 'deep', true),
        blockdevice => lookup("${mountyaml}.${mountname}.blockdevice", undef, 'deep', undef),
        device      => lookup("${mountyaml}.${mountname}.device", undef, 'deep', undef),
        dump        => lookup("${mountyaml}.${mountname}.dump", undef, 'deep', undef),
        fstype      => lookup("${mountyaml}.${mountname}.fstype", undef, 'deep', undef),
        options     => lookup("${mountyaml}.${mountname}.options", undef, 'deep', undef),
        pass        => lookup("${mountyaml}.${mountname}.pass", undef, 'deep', undef),
        provider    => lookup("${mountyaml}.${mountname}.provider", undef, 'deep', undef),
        remounts    => lookup("${mountyaml}.${mountname}.remounts", undef, 'deep', undef),
        #target      => lookup("${mountyaml}.${mountname}.target", undef, 'deep', undef),
      }
    }
  }
}

class pocketprotector::mount {
  pocketprotector::mount::parse{'pocketprotector::mount':}
}
