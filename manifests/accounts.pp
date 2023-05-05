# manifests/accounts.pp
#

class pocketprotector::accounts {
  lookup('pocketprotector.accounts', undef, 'hash', undef).each |String $username| {
    #
    # accounts module doesn't like it if you specify the default home dir
    #
    if lookup("pocketprotector::accounts.${username}.home", undef, 'first', "/home/${username}") == "/home/${username}" {
      $tmphomedir = undef
    }
    else {
      $tmphomedir = $home
    }
    accounts::user { "${username}":
      home     => $tmphomedir,
      uid      => lookup("pocketprotector::accounts.${username}.uid", undef, 'first', undef),
      groups   => lookup("pocketprotector::accounts.${username}.groups", undef, 'hash', ['users']),
      password => lookup("pocketprotector::passwords.${username}", undef, 'first', '!!'),
      shell    => lookup("pocketprotector::accounts.${username}.shell", undef, 'first', '/bin/bash'),
      sshkeys  => lookup("pocketprotector::accounts.${username}.sshkeys", Array[String], 'hash', []),
    }
  }
}
