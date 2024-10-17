# manifests/packages/apt.pp
#
# apt repository, ppa, and pin support
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
    notify{"pocketprotector::packages::repositories::apt::source::parse: lookup failed for ${sourceyaml}":}
  }
}

define pocketprotector::packages::repositories::apt::pin::parse (
  String $pinyaml = $name,
){
  if lookup($pinyaml,undef,'deep',false) {
    lookup($pinyaml,undef,'deep',undef).each | String $aptrepo, Hash $aptrepopriority | {
      apt::pin { $aptrepo: priority => $aptrepopriority }
    }
  } else {
    notify{"pocketprotector::packages::repositories::apt::pin::parse: lookup failed for ${pinyaml}":}
  }
}

define pocketprotector::packages::repositories::apt::ppa::parse (
  String $ppayaml = $name,
){
  if lookup($ppayaml,undef,'deep',false) {
    lookup($ppayaml,undef,'deep',undef).each | String $aptppa | {
      apt::ppa { $aptppa: }
    }
  } else {
    notify{"pocketprotector::packages::repositories::apt::ppa::parse: lookup failed for ${ppayaml}":}
  }
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

