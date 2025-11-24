# manifests/gpu.pp
#
# GPU detection and custom package installation

class pocketprotector::gpu {
  case $facts['pp_gputype'] {
    'amd': { include pocketprotector::gpu::amd }
    'nvidia': { include pocketprotector::gpu::nvidia }
    default: {}
  }
}

class pocketprotector::gpu::amd {
  notify{'pocketprotector::gpu::amd: AMD not (yet?) supported':}
}

# nvidia / CUDA support
class pocketprotector::gpu::nvidia {
  pocketprotector::packages::repositories::parse{'pocketprotector::gpu::nvidia::repository':}
  pocketprotector::packages::parse{'pocketprotector::gpu::nvidia::packages':}
}
