# manifests/mta/opendkim.pp

class pocketprotector::mta::opendkim {
  # detect opendkim, install and configure if needed
  if lookup('pocketprotector::mta::opendkim::domain',undef,undef,false) {
    # To do here:  add check to fail if count for domains > 1
    include pocketprotector::mta::opendkim::package
    include pocketprotector::mta::opendkim::service
    include pocketprotector::mta::opendkim::files
  }
}

class pocketprotector::mta::opendkim::files {
  # extract vars here to avoid deep merge weirdness inside of erb
  $odkfqdn = lookup('pocketprotector::mta::opendkim::domain.fqdn',undef,'deep',false)
  $odktrustedhosts = lookup('pocketprotector::mta::opendkim::domain.trustedhosts',undef,'deep',false)
  $odkselector = lookup('pocketprotector::mta::opendkim::domain.selector',undef,'deep',false)

  file {
    '/etc/dkimkeys/opendkim.private':
      owner   => lookup('pocketprotector::mta::opendkim::user'),
      mode    => '0400',
      content => lookup("pocketprotector::mta::opendkim::domain.private_key" , undef, 'deep', ""),
      notify  => Service[lookup('pocketprotector::mta::opendkim::servicename')],
      require => Package[lookup('pocketprotector::mta::opendkim::packagename')];
    '/etc/opendkim.conf':
      owner   => lookup('pocketprotector::mta::opendkim::user'),
      mode    => '0400',
      content => template('pocketprotector/mta/opendkim/opendkim.conf.erb'),
      notify  => Service[lookup('pocketprotector::mta::opendkim::servicename')],
      require => Package[lookup('pocketprotector::mta::opendkim::packagename')];
    '/etc/opendkim':
      ensure  => 'directory',
      owner   => lookup('pocketprotector::mta::opendkim::user'),
      mode    => '0400',
      notify  => Service[lookup('pocketprotector::mta::opendkim::servicename')],
      require => Package[lookup('pocketprotector::mta::opendkim::packagename')];
    '/etc/opendkim/key.table':
      owner   => lookup('pocketprotector::mta::opendkim::user'),
      mode    => '0400',
      content => template('pocketprotector/mta/opendkim/key.table.erb'),
      notify  => Service[lookup('pocketprotector::mta::opendkim::servicename')],
      require => Package[lookup('pocketprotector::mta::opendkim::packagename')];
    '/etc/opendkim/signing.table':
      owner   => lookup('pocketprotector::mta::opendkim::user'),
      mode    => '0400',
      content => template('pocketprotector/mta/opendkim/signing.table.erb'),
      notify  => Service[lookup('pocketprotector::mta::opendkim::servicename')],
      require => Package[lookup('pocketprotector::mta::opendkim::packagename')];
    '/etc/opendkim/trusted.hosts':
      owner   => lookup('pocketprotector::mta::opendkim::user'),
      mode    => '0400',
      content => template('pocketprotector/mta/opendkim/trusted.hosts.erb'),
      notify  => Service[lookup('pocketprotector::mta::opendkim::servicename')],
      require => Package[lookup('pocketprotector::mta::opendkim::packagename')];
  }

  case lookup('pocketprotector::mta::default') {
    'postfix': {
      file {
        '/var/spool/postfix/opendkim':
          ensure  => 'directory',
          owner   => lookup('pocketprotector::mta::opendkim::user'),
          group   => 'postfix',
          mode    => '0640',
          notify  => Service[lookup('pocketprotector::mta::opendkim::servicename')],
          require => Package[lookup('pocketprotector::mta::opendkim::packagename')];
      }
    }
    default: {}
  }
}

class pocketprotector::mta::opendkim::package {
  package { lookup('pocketprotector::mta::opendkim::packagename'):
    ensure => installed,
  }
}

class pocketprotector::mta::opendkim::service {
  service {
    lookup('pocketprotector::mta::opendkim::servicename'):
      ensure => 'running',
      enable => true,
  }
}
