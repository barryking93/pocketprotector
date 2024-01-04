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
  if lookup($groupyaml, undef, 'deep', false) {
    lookup($groupyaml, undef, 'deep', undef).each |String $groupname, Hash $grouphash| {
      #notify {"pocketprotector::groups: group creation for for ${groupname}":}

      # https://www.puppet.com/docs/puppet/8/types/group.html
      group {
        $groupname:
          allowdupe            => lookup("${groupyaml}.${groupname}.allowdupe", undef, 'first', undef),
          attribute_membership => lookup("${groupyaml}.${groupname}.attribute_membership", undef, 'first', undef),
          attributes           => lookup("${groupyaml}.${groupname}.attributes", undef, 'first', undef),
          auth_membership      => lookup("${groupyaml}.${groupname}.auth_membership", undef, 'first', undef),
          ensure               => lookup("${groupyaml}.${groupname}.ensure", undef, 'first', undef),
          forcelocal           => lookup("${groupyaml}.${groupname}.forcelocal", undef, 'first', undef),
          gid                  => lookup("${groupyaml}.${groupname}.gid", undef, 'first', undef),
          ia_load_module       => lookup("${groupyaml}.${groupname}.ia_load_module", undef, 'first', undef),
          members              => lookup("${groupyaml}.${groupname}.members", undef, 'deep', undef),
          name                 => lookup("${groupyaml}.${groupname}.name", undef, 'first', undef),
          provider             => lookup("${groupyaml}.${groupname}.provider", undef, 'first', undef),
          system               => lookup("${groupyaml}.${groupname}.system", undef, 'first', undef),
      }
    }
  }
}

#
# crawl pocketprotector.accounts in hieradata for user list
#
class pocketprotector::groups {
  pocketprotector::groups::parse{'pocketprotector::groups':}
}
