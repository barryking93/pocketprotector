# manifests/init.pp

class pocketprotector {
  include pocketprotector::accounts
  include pocketprotector::puppet
  include pocketprotector::monitoring
}
