# manifests/accounts.pp
#
# account management
#
# crawl pocketprotector.accounts in all

class pocketprotector::accounts {
  lookup('pocketprotector.accounts', undef, 'unique', undef).each |String $username, Hash $userhash| {
    notify {"debug account for ${username}":}
    #accounts::user { "${username}":
    #  home     => lookup("pocketprotector::accounts.${username}.home", undef, 'first', "/home/${username}"),
    #  uid      => lookup("pocketprotector::accounts.${username}.uid", undef, 'first', undef),
    #  groups   => lookup("pocketprotector::accounts.${username}.groups", undef, 'hash', ['users']),
    #  password => lookup("pocketprotector::passwords.${username}", undef, 'first', '!!'),
    #  shell    => lookup("pocketprotector::accounts.${username}.shell", undef, 'first', '/bin/bash'),
    #  sshkeys  => lookup("pocketprotector::accounts.${username}.sshkeys", Array[String], 'hash', []),
    #}
  }
}
