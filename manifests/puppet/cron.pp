# puppet client cron jobs
class pocketprotector::puppet::cron::client {
  cron {
    'puppet':
      command => lookup('pocketprotector::puppet::cron::client::command'),
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
  $puppet_branch = lookup('pocketprotector::puppet::git::branch')

  cron {
    # run-puppet syntax is different for servers for bootstrap purposes
    'puppet':
      command => "bash -c \"/opt/puppetlabs/puppet/bin/r10k deploy environment -p > /dev/null 2>&1;/opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/environments/${puppet_branch}/manifests/ --environment ${puppet_branch}\" > /dev/null 2>&1",
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
