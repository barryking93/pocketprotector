# manifests/packages/apt.pp
#
# apt package (and repository) support
#

define pocketprotector::packages::repositories::apt::source::parse (
  String $sourceyaml = $name,
){
  if lookup($sourceyaml,undef,'deep',false) {
    lookup($sourceyaml,undef,'deep',undef).each | String $aptrepo, Hash $aptrepohash | {
      apt::source {
        $aptrepo:
          location => lookup("${sourceyaml}.${aptrepo}.location",undef,deep,undef),
          release  => lookup("${sourceyaml}.${aptrepo}.release",undef,deep,undef),
          repos    => lookup("${sourceyaml}.${aptrepo}.repos",undef,deep,undef),
          key      => {
            'id'     => lookup("${sourceyaml}.${aptrepo}.key.id",undef,deep,undef),
            'source' => lookup("${sourceyaml}.${aptrepo}.key.source",undef,deep,undef),
          };
      }
    }
  } else {
    notify{"pocketprotector::packages::repositories::apt::sourceparse: lookup failed for ${sourceyaml}":}
  }
}

class pocketprotector::packages::repositories::apt {
  include pocketprotector::packages::repositories::apt::init

  pocketprotector::packages::repositories::apt::source::parse{'pocketprotector::packages::repositories':}

  include pocketprotector::packages::repositories::apt::ppa
  include pocketprotector::packages::repositories::apt::pin
}

# initialize the apt module itself - has to be done first
class pocketprotector::packages::repositories::apt::init {
  class {'apt':
    purge => {
      'sources.list'   => true,
      'sources.list.d' => true
    },
  }
}

# pin any needed repos
class pocketprotector::packages::repositories::apt::pin {
  if lookup('pocketprotector::packages::pin',undef,deep,false) {
    lookup('pocketprotector::packages::pin',undef,deep,undef).each | String $aptrepo, String $aptrepopriority | {
      apt::pin { $aptrepo: priority => $aptrepopriority }
    }
  }
}

# add any ppas
class pocketprotector::packages::repositories::apt::ppa {
  if lookup('pocketprotector::packages::ppa',undef,deep,false) {
    lookup('pocketprotector::packages::ppa',undef,deep,undef).each | String $aptppa | {
      apt::ppa { $aptppa: }
    }
  }
}
