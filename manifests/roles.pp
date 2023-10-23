# manifests/roles.pp
#

class pocketprotector::roles {
  #
  # see if roles exist, see if any are assigned, then parse the assignments
  #
  if lookup('pocketprotector::roles') {
    if lookup('pocketprotector::roles::assigned') {
      lookup('pocketprotector::roles::assigned', undef, 'deep', undef).each | String $rolename | {
        lookup("pocketprotector::roles.${rolename}", undef, 'deep', undef).each | String $roletype, Hash $roletypehash | {
          case $roletype {
            'accounts': {
              pocketprotector::accounts::parse{"pocketprotector::roles.${rolename}.files":}
            }
            'files': {
              pocketprotector::files::parse{"pocketprotector::roles.${rolename}.files":}
            }
            'includes': {
              lookup("pocketprotector::roles.${rolename}.includes", undef, 'deep', undef).each | String $includename | {
                include $includename
              }
            }
            'repositories': {
              case lookup('pocketprotector::packages::provider') {
                'apt': {
                  pocketprotector::packages::repositories::apt::repoparse{"pocketprotector::roles.${rolename}.repositories":}
                }
                'zypper': {
                  pocketprotector::packages::repositories::zypper::repoparse{"pocketprotector::roles.${rolename}.repositories":}
                }
                default: {
                  notify{'pocketprotector::roles: the package repository for your OS is not (yet?) supported':}
                }
              }
            }
            'templates': {
              pocketprotector::files::templates{lookup("pocketprotector::roles.${rolename}.templates", undef, 'deep', undef):}
            }
            default: {}
          }
      }
    }
  }
}
