# manifests/gpu.pp
#
# GPU detection and custom package installation

class pocketprotector::gpu {
  case $::facts['pp_gputype'] {
    'amd': { include pocketprotector::gpu::amd }
    'nvidia': { include pocketprotector::gpu::nvidia }
    default: {}
  }
}

class pocketprotector::gpu::amd {
  notify{'pocketprotector::gpu::amd: AMD not (yet?) supported':}
}

class pocketprotector::gpu::nvidia {
# nvidia (read: CUDA) support

  case lookup('pocketprotector::packages::provider') {
    'apt': {
      pocketprotector::packages::repositories::apt::source::parse{'pocketprotector::gpu::nvidia::repository':}
      pocketprotector::packages::parse{'pocketprotector::gpu::nvidia::packages':}
    }
    default: {
      notify{'pocketprotector::gpu::nvidia: the package repository for your OS is not (yet?) supported':}
    }
  }
}
