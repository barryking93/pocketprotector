# manifests/gpu.pp
#
# GPU detection and custom package installation

class pocketprotector::gpu {
  case $::facts['ppgputype'] {
    'amd': { include pocketprotector::gpu::amd }
    'nvidia': { include pocketprotector::gpu::nvidia }
    default: {}
  }
}

class pocketprotector::gpu::amd {}

class pocketprotector::gpu::nvidia {

  case lookup('pocketprotector::packages::provider') {
    'apt': {
      apt::source { nvidia:
        location => lookup('pocketprotector::gpu::nvidia::repository.location',undef,deep,undef),
        release  => lookup('pocketprotector::gpu::nvidia::repository.release',undef,deep,undef),
        repos    => lookup('pocketprotector::gpu::nvidia::repository.repos',undef,deep,undef),
        key      => {
          'id'     => lookup('pocketprotector::gpu::nvidia::repository.key.id',undef,deep,undef),
          'source' => lookup('pocketprotector::gpu::nvidia::repository.key.source',undef,deep,undef),
        }
      }

      package {
        lookup('pocketprotector::gpu::nvidia::package'):
          ensure => installed,
      }
    }
    default: {
      notify{'the package repository for your OS is not (yet?) supported':}
    }
  }
}