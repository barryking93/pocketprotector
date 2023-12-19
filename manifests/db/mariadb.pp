# manifests/db/mariadb.pp

class pocketprotector::db::maridb {
  pocketprotector::packages::parse{'pocketprotector::db::mariadb::packages':}
}

