# manifests/roles.pp
#

class pocketprotector::roles {
  if lookup('pocketprotector::roles') {
    #
    # go through roles
    #
    lookup('pocketprotector::roles', undef, 'deep', undef).each | String $rolename, Hash $rolehash | {
      #
      # interate through types
      #
      lookup("pocketprotector::roles.${rolename}", undef, 'deep', undef).each | String $roletype, Hash $roletypehash | {
        case $roletype {
          'accounts': {
            pocketprotector::accounts{lookup("pocketprotector::roles.${rolename}.files", undef, 'deep', undef):}
          }
          'files': {
            pocketprotector::files{lookup("pocketprotector::roles.${rolename}.files", undef, 'deep', undef):}
          }
          'includes': {
            lookup("pocketprotector::roles.${rolename}.includes", undef, 'deep', undef).each | String $includename | {
              include $includename  
            }
          }
          'templates': {
              pocketprotector::files::templates{lookup("pocketprotector::roles.${rolename}.templates", undef, 'deep', undef):}
          }
        }

    }
  }
}
