# manifests/fs.pp

class pocketprotector::fs {
  include pocketprotector::fs::nfs
  include pocketprotector::fs::samba
}
