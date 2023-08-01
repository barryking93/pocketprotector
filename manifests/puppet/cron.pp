# puppet client cron jobs
class pocketprotector::puppet::cron::client {
  cron {
    'puppet':
      command => '/opt/puppetlabs/bin/puppet agent --no-daemonize --onetime --splay --splaylimit 180 > /dev/null',
      user    => 'root',
      minute  => [0,30],
      hour    => '*',
      weekday => '*';
    # puppet locks up, sometimes
    'kill puppet':
      command => '/usr/bin/killall -6 puppet > /dev/null 2>&1;/bin/rm -f /var/lib/puppet/state/puppetdlock',
      user    => 'root',
      minute  => 55,
      hour    => '9',
      weekday => '*',
  }
}

# puppet server cron jobs
class pocketprotector::puppet::cron::server {
  cron {
    # run-puppet syntax is different for servers for bootstrap purposes
    'puppet':
      command => 'bash -c "/opt/puppetlabs/puppet/bin/r10k deploy environment -p;/opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/environments/main/manifests/" > /dev/null',
      user    => 'root',
      minute  => '*/10',
      hour    => '*',
      weekday => '*';
    'kill puppet':
      ensure => 'absent',
  }
  # avoid infinite disk growth by only keep the last 30 days of yaml reports
  if lookup('pocketprotector::puppet::server::report::directory::tidy') == true {
    tidy {
      lookup('pocketprotector::puppet::server::report::directory'):
        age     => lookup('pocketprotector::puppet::server::report::directory::tidy::period'),
        matches => '*.yaml',
        recurse => true,
        rmdirs  => false,
        type    => ctime,
      }
    }
}
