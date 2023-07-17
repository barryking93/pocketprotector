# manifests/etc.pp
#
# write out config variables to /etc/pocketprotector
# which is created by pocketprotector::files
#
class pocketprotector::etc {
  include pocketprotector::etc::groups
  file {
    # write out location
    '/etc/pocketprotector/location':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => lookup('pocketprotector::location');
  }
}

class pocketprotector::etc::groups {
  $pocketgroups = lookup('pocketprotector::groups',undef,deep,undef)

  if defined($pocketgroups) {
    file {
      # write out groups
      '/etc/pocketprotector/groups':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('pocketprotector/etc/groups.erb');
    }
  }
}
