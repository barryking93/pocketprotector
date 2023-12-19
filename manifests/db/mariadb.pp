# manifests/db/mariadb.pp

class pocketprotector::db::maridb {
  if lookup('pocketprotector::db::mariadb::enabled',undef,'deep',false) {
    include pocketprotector::db::mariadb
  }
  pocketprotector::packages::parse{'pocketprotector::db::mariadb::packages':}
}

