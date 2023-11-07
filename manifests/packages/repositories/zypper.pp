# manifests/packages/zypper.pp
#
# zypper package (and repository) support
#

define pocketprotector::packages::repositories::zypper::repositories::parse (
  String $sourceyaml = $name,
){
  if lookup($sourceyaml,undef,'deep',false) {    
   lookup($sourceyaml,undef,'deep',undef).each | String $zypprepo, Hash $zypprepohash | {
    zypprepo { $zypprepo:
      ensure        => lookup("${soureceyaml}.${zypprepo}.ensure",undef,deep,undef),
      baseurl       => lookup("${soureceyaml}.${zypprepo}.baseurl",undef,deep,undef),
      enabled       => lookup("${soureceyaml}.${zypprepo}.enabled",undef,deep,undef),
      autorefresh   => lookup("${soureceyaml}.${zypprepo}.enabled",undef,deep,undef),
      name          => lookup("${soureceyaml}.${zypprepo}.name",undef,deep,undef),
      gpgcheck      => lookup("${soureceyaml}.${zypprepo}.gpgcheck",undef,deep,undef),
      repo_gpgcheck => lookup("${soureceyaml}.${zypprepo}.repo_gpgcheck",undef,deep,undef),
      pkg_gpgcheck  => lookup("${soureceyaml}.${zypprepo}.pgk_gpgcheck",undef,deep,undef),
      priority      => lookup("${soureceyaml}.${zypprepo}.priority",undef,deep,undef),
      keeppackages  => lookup("${soureceyaml}.${zypprepo}.keeppackages",undef,deep,undef),
      type          => lookup("${soureceyaml}.${zypprepo}.type",undef,deep,undef),
    }
  }
}

class pocketprotector::packages::repositories::zypper {
  pocketprotector::packages::repositories::zypper::repositories::parse{'pocketprotector::packages::repositories'):}
}
