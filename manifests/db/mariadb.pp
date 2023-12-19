# manifests/db/mariadb.pp

class pocketprotector::db::mariadb {
  pocketprotector::packages::parse{'pocketprotector::db::mariadb::packages':}
}

