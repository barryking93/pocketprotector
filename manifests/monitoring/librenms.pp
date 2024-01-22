# manifests/monitoring/librenms.pp

class pocketprotector::monitoring::librenms {
  # is this a librenms host?
  case $::fqdn {
    lookup('pocketprotector::monitoring::librenms::server'): {
      # if no separate mariadb host specified, its local
      if lookup('pocketprotector::monitoring::librenms::mariadb',undef,'deep',false) {} else {
        include pocketprotector::db::mariadb
      }
      include nginx
      include pocketprotector::utils::git

      $librenms_server = lookup('pocketprotector::monitoring::librenms::server',undef,'first',false)

      pocketprotector::accounts::parse{'pocketprotector::monitoring::librenms::accounts':}
      pocketprotector::files::parse{'pocketprotector::monitoring::librenms::files':}
      pocketprotector::files::templates::parse{'pocketprotector::monitoring::librenms::templates':}
      if lookup('pocketprotector::monitoring::librenms::repositories',undef,'deep',false) {
        case lookup('pocketprotector::packages::provider') {
          'apt': {
            apt::ppa {lookup('pocketprotector::monitoring::librenms::repositories'):}
          }
          default: {
            notify{'pocketprotector::packages::repositories: the package repository for your OS is not (yet?) supported':}
          }
        }
      }
      pocketprotector::packages::parse{'pocketprotector::monitoring::librenms::packages':}

      exec {
        'librenms git init':
          command => '/usr/bin/git init;/usr/bin/git remote add origin https://github.com/librenms/librenms.git;/usr/bin/git fetch origin;/usr/bin/git checkout -b master --track origin/master',
          creates => '/opt/librenms/.git',
          cwd     => '/opt/librenms',
          user    => 'librenms'
      }
      
      posix_acl { lookup('pocketprotector::monitoring::librenms::acldirs',undef,'first',undef):
        permission => [
          "group::rwx",
          "default:group::rwx",
        ],
      }

      service {
        'librenms-scheduler.timer':
          enable => true,
          ensure => true,
      }
    }
    default: {}
  }
  include pocketprotector::monitoring::snmp
}

