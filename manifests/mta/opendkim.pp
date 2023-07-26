# manifests/mta/opendkim.pp

class pocketprotector::mta::opendkim {
  if lookup('pocketprotector::mta::opendkim::domains') {
    # To do here:  add check to fail if count for domains > 1
    include pocketprotector::mta::opendkim::package
    include pocketprotector::mta::opendkim::service
    include pocketprotector::mta::opendkim::files
  }
}

class pocketprotector::mta::opendkim::files {
  file {
    '/etc/opendkim/key.table':
      owner   => lookup('pocketprotector::mta::opendkim::user'),
      mode    => '0400',
      content => template('pocketprotector/mta/opendkim/key.table.erb'),
      notify  => Service[lookup('pocketprotector::mta::opendkim::servicename')],
      require => Package[lookup('pocketprotector::mta::opendkim::packagename')];
    '/etc/opendkim/opendkim.conf':
      owner   => lookup('pocketprotector::mta::opendkim::user'),
      mode    => '0400',
      content => template('pocketprotector/mta/opendkim/opendkim.cfg.erb'),
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

  lookup('pocketprotector::mta::opendkim::domains', undef, 'deep', undef).each | String $opendkimdomain, Hash $opendkimhash | {
    file {
      "/etc/dkimkeys/${opendkimdomain}.private":
        owner   => lookup('pocketprotector::mta::opendkim::user'),
        mode    => '0400',
        content => lookup("pocketprotector::mta::opendkim::domains." + @opendkimdomain + ".private_key" , undef, 'deep', undef),
        notify  => Service[lookup('pocketprotector::mta::opendkim::servicename')],
        require => Package[lookup('pocketprotector::mta::opendkim::packagename')];
    }
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
