# manifests/accounts.pp
#
# account management

#
# custom content type to deal with accounts
#
# walks through $usershash and defines accounts
#

define pocketprotector::accounts::parse (
  String $usersyaml = $name,
  ){
  lookup($usersyaml, undef, 'deep', false).each |String $username, Hash $userhash| {
    #notify {"pocketprotector::accounts: account creation for for ${username}":}

    # https://forge.puppet.com/modules/puppetlabs/accounts/reference
    accounts::user {
      $username:
        comment                  => lookup("${usersyaml}.${username}.comment", undef, 'first', undef),
        home                     => lookup("${usersyaml}.${username}.home", undef, 'first', "/home/${username}"),
        gid                      => lookup("${usersyaml}.${username}.gid", undef, 'first', undef),
        group                    => lookup("${usersyaml}.${username}.group", undef, 'deep', undef),
        groups                   => lookup("${usersyaml}.${username}.groups", undef, 'deep', undef),
        ignore_password_if_empty => lookup("${usersyaml}.${username}.ignore_password_if_empty", undef, 'deep', undef),
        locked                   => lookup("${usersyaml}.${username}.locked", undef, 'first', undef),
        name                     => lookup("${usersyaml}.${username}.name", undef, 'first', undef),
        password                 => lookup("pocketprotector::passwords.${username}", undef, 'first', '!!'),
        shell                    => lookup("${usersyaml}.${username}.shell", undef, 'first', '/bin/bash'),
        sshkeys                  => lookup("${usersyaml}.${username}.sshkeys", Array[String], 'deep', []),
        uid                      => lookup("${usersyaml}.${username}.uid", undef, 'first', undef),
    }
  }
}

#
# crawl pocketprotector.accounts in hieradata for user list
#
class pocketprotector::accounts {
  pocketprotector::accounts::parse{'pocketprotector::accounts':}
}
