# manifests/db.pp
#

class pocketprotector::db {
  if lookup('pocketprotector::db::mariadb::enabled',undef,'deep',false) {
    include pocketprotector::db::mariadb
  }
}

