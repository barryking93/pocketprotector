# manifests/accounts.pp
#

class pocketprotector::accounts {
  lookup('pocketprotector.accounts', undef, 'deep', undef).each |String $username| {
    #
    # accounts module doesn't like it if you specify the default home dir
    #
    if lookup("pocketprotector::accounts.${name}.home", undef, 'deep', "/home/${name}") == "/home/${name}" {
      $tmphomedir = undef
    }
    else {
      $tmphomedir = $home
    }
    accounts::user { "${username}":
      home     => $tmphomedir,
      uid      => lookup("pocketprotector::accounts.${name}.uid", undef, 'deep', undef),
      groups   => lookup("pocketprotector::accounts.${name}.groups", undef, 'deep', ['users']),
      password => lookup("pocketprotector::accounts.${name}.password", undef, 'deep', '!!'),
      shell    => lookup("pocketprotector::accounts.${name}.shell", undef, 'deep', '/bin/bash'),
      sshkeys  => lookup("pocketprotector::accounts.${name}.sshkeys", Array[String], 'deep', []),
    }
  }
}
