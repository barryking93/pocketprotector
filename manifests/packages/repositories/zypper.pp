# manifests/packages/repositories/zypper.pp
#
# zypper repository support
#

define pocketprotector::packages::repositories::zypper::parse (
  String $sourceyaml = $name,
){
  if lookup($sourceyaml,undef,'deep',false) {    
    lookup($sourceyaml,undef,'deep',undef).each | String $zypprepo, Hash $zypprepohash | {
      zypprepo { $zypprepo:
        ensure        => lookup("${sourceyaml}.${zypprepo}.ensure",undef,deep,undef),
        baseurl       => lookup("${sourceyaml}.${zypprepo}.baseurl",undef,deep,undef),
        enabled       => lookup("${sourceyaml}.${zypprepo}.enabled",undef,deep,undef),
        autorefresh   => lookup("${sourceyaml}.${zypprepo}.autorefresh",undef,deep,undef),
        name          => lookup("${sourceyaml}.${zypprepo}.name",undef,deep,undef),
        gpgcheck      => lookup("${sourceyaml}.${zypprepo}.gpgcheck",undef,deep,undef),
        repo_gpgcheck => lookup("${sourceyaml}.${zypprepo}.repo_gpgcheck",undef,deep,undef),
        pkg_gpgcheck  => lookup("${sourceyaml}.${zypprepo}.pgk_gpgcheck",undef,deep,undef),
        priority      => lookup("${sourceyaml}.${zypprepo}.priority",undef,deep,undef),
        keeppackages  => lookup("${sourceyaml}.${zypprepo}.keeppackages",undef,deep,undef),
        type          => lookup("${sourceyaml}.${zypprepo}.type",undef,deep,undef),
      }
    }
  } else {
    notify{"pocketprotector::packages::repositories::zypper::parse: lookup failed for ${sourceyaml}":}
  }
}

