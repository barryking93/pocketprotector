# manifests/fs/samba.pp
#

define pocketprotector::fs::samba::mounts::parse (
  String $mountyaml = $name,
){
  if lookup($mountyaml, undef, 'deep', false) {
    $fstypedefault = lookup('pocketprotector::fs::samba::defaults.fstype', undef, 'first', undef)
    $optionsdefault = lookup('pocketprotector::fs::samba::defaults.options', undef, 'first', undef)

    pocketprotector::packages::parse{'pocketprotector::fs::samba::client::packages':}

    lookup($mountyaml, undef, 'deep', undef).each |String $mountname, Hash $mounthash| {
      #notify {"pocketprotector::fs::samba::mounts::parse: debug file for ${mountname}":}

      mount { $mountname:
        name        => lookup("(${mountyaml}.\"${mountname}\".name", undef, 'deep', undef),
        ensure      => lookup("(${mountyaml}.\"${mountname}\".ensure", undef, 'deep', undef),
        atboot      => lookup("(${mountyaml}.\"${mountname}\".atboot", undef, 'deep', undef),
        blockdevice => lookup("(${mountyaml}.\"${mountname}\".blockdevice", undef, 'deep', undef),
        device      => lookup("(${mountyaml}.\"${mountname}\".device", undef, 'deep', undef), 
        dump        => lookup("(${mountyaml}.\"${mountname}\".dump", undef, 'deep', undef),
        fstype      => lookup("(${mountyaml}.\"${mountname}\".fstype", undef, 'deep', $fstypedefault),
        options     => lookup("(${mountyaml}.\"${mountname}\".options", undef, 'deep', $optionsdefault),
        pass        => lookup("(${mountyaml}.\"${mountname}\".pass", undef, 'deep', undef),
        provider    => lookup("(${mountyaml}.\"${mountname}\".provider", undef, 'deep', undef),
        remounts    => lookup("(${mountyaml}.\"${mountname}\".remounts", undef, 'deep', undef),
        target      => lookup("(${mountyaml}.\"${mountname}\".target", undef, 'deep', undef),
      }
    }
  }
}

# 
# TO DO:  samba exports
#
# define pocketprotector::fs::samba::exports::parse (
#   String $mountyaml = $name,
# ){
# }

class pocketprotector::fs::samba {
  pocketprotector::fs::samba::mounts::parse{'pocketprotector::fs::samba::mounts':}
  include pocketprotector::fs::samba::server
}

class pocketprotector::fs::samba::server {
  if lookup('pocketprotector::fs::samba::server::config', undef, 'deep', false) {
    pocketprotector::packages::parse{'pocketprotector::fs::samba::server::packages':}
    pocketprotector::files::templates::parse{'pocketprotector::fs::samba::server::templates':}

    service {
      lookup('pocketprotector::fs::samba::server::servicename'):
        ensure => 'running',
        enable => true,
    }
  }
}

