# manifests/accounts.pp
#
# account management

#
# custom content type to deal with accounts
#

define pocketprotector::accounts (
  Hash $usershash
  ){
  $usershash.each |String $username, Hash $userhash| {
    #notify {"pocketprotector::accounts: account creation for for ${username}":}

    accounts::user {
      $username:
        home     => lookup("pocketprotector::accounts.${username}.home", undef, 'first', "/home/${username}"),
        uid      => lookup("pocketprotector::accounts.${username}.uid", undef, 'first', undef),
        groups   => lookup("pocketprotector::accounts.${username}.groups", undef, 'deep', ['users']),
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
  pocketprotector::accounts {lookup('pocketprotector::accounts', undef, 'deep', false):}
}
