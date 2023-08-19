# manifests/packages/zypper.pp
#
# zypper package (and repository) support
#
class pocketprotector::packages::repositories::zypper {
  include pocketprotector::packages::repositories::zypper::repositories
}

# add any zypper repos
class pocketprotector::packages::repositories::zypper::repositories {
  lookup('pocketprotector::packages::repositories',undef,deep,undef).each | String $zypprepo, Hash $zypprepohash | {
    zypprepo { $zypprepo:
      ensure        => lookup("pocketprotector::packages::repositories.${zypprepo}.ensure",undef,deep,undef),
      baseurl       => lookup("pocketprotector::packages::repositories.${zypprepo}.baseurl",undef,deep,undef),
      enabled       => lookup("pocketprotector::packages::repositories.${zypprepo}.enabled",undef,deep,undef),
      autorefresh   => lookup("pocketprotector::packages::repositories.${zypprepo}.enabled",undef,deep,undef),
      name          => lookup("pocketprotector::packages::repositories.${zypprepo}.name",undef,deep,undef),
      gpgcheck      => lookup("pocketprotector::packages::repositories.${zypprepo}.gpgcheck",undef,deep,undef),
      repo_gpgcheck => lookup("pocketprotector::packages::repositories.${zypprepo}.repo_gpgcheck",undef,deep,undef),
      pkg_gpgcheck  => lookup("pocketprotector::packages::repositories.${zypprepo}.pgk_gpgcheck",undef,deep,undef),
      priority      => lookup("pocketprotector::packages::repositories.${zypprepo}.priority",undef,deep,undef),
      keeppackages  => lookup("pocketprotector::packages::repositories.${zypprepo}.keeppackages",undef,deep,undef),
      type          => lookup("pocketprotector::packages::repositories.${zypprepo}.type",undef,deep,undef),
    }
  }
}
