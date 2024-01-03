# manifest/groups.pp
#
# group management

#
# custom content type to deal with groups
#
# walks through $grouphash and defines groups
# 

define pocketprotector::groups::parse (
  String $groupyaml = $name,
  ){
  lookup($groupyaml, undef, 'deep', false).each |String $groupname, Hash $grouphash| {
    #notify {"pocketprotector::groups: group creation for for ${groupname}":}

    # https://www.puppet.com/docs/puppet/8/types/group.html
    group {
      $groupname:
        allowdupe            => lookup("${usersyaml}.${username}.allowdupe", undef, 'first', undef),
        attribute_membership => lookup("${usersyaml}.${username}.attribute_membership", undef, 'first', undef),
        attributes           => lookup("${usersyaml}.${username}.attributes", undef, 'first', undef),
        auth_membership      => lookup("${usersyaml}.${username}.auth_membership", undef, 'first', undef),
        ensure               => lookup("${usersyaml}.${username}.ensure", undef, 'first', undef),
        forcelocal           => lookup("${usersyaml}.${username}.forcelocal", undef, 'first', undef),
        gid                  => lookup("${usersyaml}.${username}.gid", undef, 'first', undef),
        ia_load_module       => lookup("${usersyaml}.${username}.ia_load_module", undef, 'first', undef),
        members              => lookup("${usersyaml}.${username}.members", undef, 'first', undef),
        name                 => lookup("${usersyaml}.${username}.name", undef, 'first', undef),
        provider             => lookup("${usersyaml}.${username}.provider", undef, 'first', undef),
        system               => lookup("${usersyaml}.${username}.system", undef, 'first', undef),
    }
  }
}

#
# crawl pocketprotector.accounts in hieradata for user list
#
class pocketprotector::groups {
  pocketprotector::groups::parse{'pocketprotector::groups':}
}
