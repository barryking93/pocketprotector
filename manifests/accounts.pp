# manifests/accounts.pp
#

class pocketprotector::accounts {
  lookup('pocketprotector.accounts', undef, 'unique', undef).each |String $username| {
    #
    # accounts module doesn't like it if you specify the default home dir
    #
    if lookup("pocketprotector::accounts.${name}.home", undef, 'first', "/home/${name}") == "/home/${name}" {
      $tmphomedir = undef
    }
    else {
      $tmphomedir = $home
    }
    accounts::user { "${username}":
      home     => $tmphomedir,
      uid      => lookup("pocketprotector::accounts.${name}.uid", undef, 'first', undef),
      groups   => lookup("pocketprotector::accounts.${name}.groups", undef, 'hash', ['users']),
      password => lookup("pocketprotector::passwords.${name}", undef, 'first', '!!'),
      shell    => lookup("pocketprotector::accounts.${name}.shell", undef, 'first', '/bin/bash'),
      sshkeys  => lookup("pocketprotector::accounts.${name}.sshkeys", Array[String], 'hash', []),
    }
  }
}
