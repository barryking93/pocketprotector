# manifests/packages.pp

class pocketprotector::packages {
  case lookup('pocketprotector::packages', undef, 'deep', false) {
    false: {}
    default: {
      lookup('pocketprotector::packages', undef, 'deep', undef):
        ensure => installed;
    }
  }
  case lookup('pocketprotector::packages::latest', undef, 'deep', false) {
    false: {}
    default: {
      lookup('pocketprotector::packages::latest', undef, 'deep', undef):
        ensure => latest;
    }
  }
}
