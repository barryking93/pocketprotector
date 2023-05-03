# manifests/utils.pp
#
# Utilities used by various other components
#

class pocketprotector::utils::git {
  package { lookup('pocketprotector::packages::git'):
    ensure => installed,
  }
}
