# manifests/init.pp

class pocketprotector {
  include pocketprotector::packages
  include pocketprotector::accounts
  include pocketprotector::puppet
  include pocketprotector::monitoring
  include pocketprotector::mta
}
