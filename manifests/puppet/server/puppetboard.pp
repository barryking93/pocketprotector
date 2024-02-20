# manifests/puppet/server/puppetboard.pp
#
# managing puppetboard, the open source status panel for puppet
#

class pocketprotector::puppet::server::puppetboard {
  if lookup('pocketprotector::puppet::server::puppetboard::docker',undef,undef,false) {
    include pocketprotector::puppet::server::puppetboard::docker
  }
  else {
    include pocketprotector::puppet::server::puppetboard::native
  }
}

class pocketprotector::puppet::server::puppetboard::docker {
    include docker

    $pb_key = lookup('pocketprotector::puppet::server::puppetboard::secret_key')

    docker::image { 'ghcr.io/voxpupuli/puppetboard': }

    docker::run { 'puppetboard':
        image => 'ghcr.io/voxpupuli/puppetboard',
        env   => [
            'PUPPETDB_HOST=127.0.0.1',
            'PUPPETDB_PORT=8080',
            'PUPPETBOARD_PORT=8088',
            "SECRET_KEY=${pb_key}",
        ],
        net   => 'host',
    }
}

class pocketprotector::puppet::server::puppetboard::native {
  include pocketprotector::apache

  # set pip3 as pip provider
  #class {
  #  'python::pip::bootstrap':
  #    version       => 'pip3',
  #    manage_python => lookup('pocketprotector::python::pip3::manage_python',undef,undef,true),
  #}
  class {
    'puppetboard':
      python_version    => lookup('pocketprotector::puppet::server::puppetboard::python_version'),
      manage_virtualenv => lookup('pocketprotector::puppet::server::puppetboard::manage_virtualenv',undef,undef,true),
      secret_key        => lookup('pocketprotector::puppet::server::puppetboard::secret_key')
      #      extra_settings    => {
      #  'SECRET_KEY'     => lookup('pocketprotector::puppet::server::puppetboard::secret_key')
      #};
    'puppetboard::apache::vhost':
      vhost_name => lookup('pocketprotector::puppet::server::puppetboard::hostname', undef, 'first', "${::fqdn}"),
      port       => 80,
  }
}
