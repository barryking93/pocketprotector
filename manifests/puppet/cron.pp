# puppet client cron jobs
class pocketprotector::puppet::cron::client {
  cron {
    # of note: splaylimit sets the number of maximum seconds to randomly wait for
    'run-puppet':
      command => '/opt/puppetlabs/bin/puppet agent --no-daemonize --onetime --splay --splaylimit 300',
      user    => 'root',
      minute  => [0,30],
      hour    => '*',
      weekday => '*';
    # sometimes the puppet process locks, so its good to kill it once a day, just in case
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
    'run-puppet':
      command => '/opt/puppetlabs/puppet/bin/r10k deploy environment -p;puppet apply /etc/puppetlabs/code/environments/master/manifests/',
      user    => 'root',
      minute  => '*/10',
      hour    => '*',
      weekday => '*';
    'kill puppet':
      ensure => 'absent'
  }
  # avoid infinite disk growth by only keep the last 30 days of yaml reports
  tidy {
    '/opt/puppetlabs/server/data/puppetserver/reports/':
      age     => '30d',
      matches => '*.yaml',
      recurse => true,
      rmdirs  => false,
      type    => ctime,
  }
}
