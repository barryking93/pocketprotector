# manifests/mta/postfix.pp

define pocketprotector::mta::postfix::parse (
    String $postfixyaml = $name,
){
    if lookup($postfixyaml, undef, 'deep', false) {
        lookup($postfixyaml, undef, 'deep', undef).each |String $postconfvar, String $postconfval| {
            #notify {"pocketprotector::mta::postfix::parse: debug postfix config for ${postconfvar}":}

            if $postconfval != '' {
                exec {
                    "postconf -e ${postconfvar} ${postconfval}":
                        timeout     => 300,
                        command     => "/usr/sbin/postconf -e ${postconfvar}='${postconfval}'",
                        logoutput   => true,
                        unless      => "/usr/sbin/postconf ${postconfvar}|grep -q '${postconfval}'",
                        environment => ['PAGER=/bin/cat','DISPLAY=:9'];
                }
            } else {
                exec {
                    "postconf -X ${postconfvar}":
                        timeout     => 300,
                        command     => "/usr/sbin/postconf -X ${postconfvar}",
                        logoutput   => true,
                        unless      => "/usr/sbin/postconf ${postconfvar}|grep -qx '${postconfvar} ='",
                        environment => ['PAGER=/bin/cat','DISPLAY=:9'];
                }
            }
        }
    } else {
        notify{"pocketprotector::mta::postfix::parse: lookup filed for file for ${postfixyaml}":}
    }
}

class pocketprotector::mta::postfix {
  include pocketprotector::mta::postfix::aliases
  pocketprotector::packages::parse{'pocketprotector::mta::postfix::packages':}
  pocketprotector::mta::postfix::parse{'pocketprotector::mta::postfix::config':}
}

class pocketprotector::mta::postfix::aliases {
  $postfix_virtual = lookup('pocketprotector::mta::postfix::virtual',undef,deep,undef)
  $postfix_transport = lookup('pocketprotector::mta::postfix::transport',undef,deep,undef)

  exec {
    'postmap transport':
      refreshonly => true,
      timeout     => 300,
      command     => '/usr/sbin/postmap /etc/postfix/transport',
      logoutput   => true,
      environment => ['PAGER=/bin/cat','DISPLAY=:9'];
    'postmap virtual':
      refreshonly => true,
      timeout     => 300,
      command     => '/usr/sbin/postmap /etc/postfix/virtual',
      logoutput   => true,
      environment => ['PAGER=/bin/cat','DISPLAY=:9'];
    'run newaliases':
      refreshonly => true,
      timeout     => 300,
      command     => '/usr/bin/newaliases',
      logoutput   => true,
      environment => ['PAGER=/bin/cat','DISPLAY=:9'];
  }
  file {
    '/etc/aliases':
      mode    => '0444',
      content => template('pocketprotector/mta/postfix/aliases.erb'),
      notify  => Exec['run newaliases'];
    '/etc/postfix/transport':
      mode    => '0444',
      content => template('pocketprotector/mta/postfix/transport.erb'),
      notify  => Exec['postmap transport'];
    '/etc/postfix/virtual':
      mode    => '0444',
      content => template('pocketprotector/mta/postfix/virtual.erb'),
      notify  => Exec['postmap virtual'];
  }
}
