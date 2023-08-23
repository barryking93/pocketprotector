# manifests/etc.pp
#
# write out base configs to /etc
# which is created by pocketprotector::files
#

class pocketprotector::etc {
  include pocketprotector::etc::pocketprotector::groups

  file {
    # write out location
    '/etc/pocketprotector/location':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => lookup('pocketprotector::location');
  }
}

class pocketprotector::etc::pocketprotector::groups {
  $pocketgroups = lookup('pocketprotector::groups',undef,deep,undef)

  if $pocketgroups!= undef {
    file {
      # write out groups
      '/etc/pocketprotector/groups':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('pocketprotector/etc/pocketprotector/groups.erb');
    }
  }
}
