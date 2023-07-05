# manifests/mta/postfix.pp

class pocketprotector::mta::postfix {
  class { 'postfix': }
  include pocketprotector::mta::postfix::aliases
}

class pocketprotector::mta::postfix::aliases {
  exec {
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
      notify  => Exec['run newaliases'],
  }
}
