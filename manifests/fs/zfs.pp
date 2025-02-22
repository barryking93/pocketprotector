# manifests/fs/zfs.pp

# base ZFS support
class pocketprotector::fs::zfs {
  pocketprotector::packages::repositories::parse{'pocketprotector::fs::zfs::repositories':}
  pocketprotector::packages::repositories::parse{'pocketprotector::fs::zfs::packages':}
}

# support for sanoid, a ZFS snapshot utility
class pocketprotector::fs::sanoid {

}
