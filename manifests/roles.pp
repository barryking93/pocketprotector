# manifests/roles.pp
#

class pocketprotector::roles {
  #
  # see if roles exist, see if any are assigned, then parse the assignments
  #
  if lookup('pocketprotector::roles',undef,'deep',false) {
    if lookup('pocketprotector::roles::assigned',undef,'deep',false) {
      lookup('pocketprotector::roles::assigned', undef, 'deep', undef).each | String $rolename | {
        lookup("pocketprotector::roles.${rolename}", undef, 'deep', undef).each | String $roletype, Hash $roletypehash | {
          case $roletype {
            'accounts': {
              pocketprotector::accounts::parse{"pocketprotector::roles.${rolename}.accounts":}
            }
            'exec': {
              pocketprotector::exec::parse{"pocketprotector::roles.${rolename}.exec":}
            }
            'files': {
              pocketprotector::files::parse{"pocketprotector::roles.${rolename}.files":}
            }
            'groups': {
              pocketprotector::groups::parse{"pocketprotector::roles.${rolename}.groups":}
            }
            'includes': {
              lookup("pocketprotector::roles.${rolename}.includes", undef, 'deep', undef).each | String $includename | {
                include $includename
              }
            }
            'mount': {
              pocketprotector::files::parse{"pocketprotector::roles.${rolename}.mount":}
            }
            'repositories': {
              pocketprotector::packages::repositories::parse{"pocketprotector::roles.${rolename}.repositories":}
            }
            'packages': {
              pocketprotector::packages::parse{"pocketprotector::roles.${rolename}.packages":}
            }
            'templates': {
              pocketprotector::files::templates::parse{"pocketprotector::roles.${rolename}.templates":}
            }
            default: {}
          }
        }
      }
    } else {
      #notify{"pocketprotector::roles no roles assigned":}
    }
  }
}
