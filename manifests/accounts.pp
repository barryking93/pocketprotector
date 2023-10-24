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

    accounts::user {
      $username:
        home     => lookup("pocketprotector::accounts.${username}.home", undef, 'first', "/home/${username}"),
        uid      => lookup("pocketprotector::accounts.${username}.uid", undef, 'first', undef),
        groups   => lookup("pocketprotector::accounts.${username}.groups", undef, 'deep', ['users']),
        locked   => lookup("pocketprotector::accounts.${username}.locked", undef, 'first', undef),
        password => lookup("pocketprotector::passwords.${username}", undef, 'first', '!!'),
        shell    => lookup("pocketprotector::accounts.${username}.shell", undef, 'first', '/bin/bash'),
        sshkeys  => lookup("pocketprotector::accounts.${username}.sshkeys", Array[String], 'deep', []),
    }
  }
}

#
# crawl pocketprotector.accounts in hieradata for user list
#
class pocketprotector::accounts {
  pocketprotector::accounts::parse{'pocketprotector::accounts':}
}
