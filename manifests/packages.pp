# manifests/packages.pp
#

define pocketprotector::packages::parse (
  String $packagesyaml = $name,
){
  if lookup($packagesyaml, undef, 'deep', false) {
    lookup($packagesyaml, undef, 'deep', undef).each |String $packagename, Hash $packagehash| {
      #notify {"pocketprotector::files: debug file for ${packagename}":}
      package {
        $packagename:
          name                 => lookup("${packagesyaml}.${packagename}.name", undef, 'deep', undef), # (namevar) The package name.  This is the name that the...
          command              => lookup("${packagesyaml}.${packagename}.command", undef, 'deep', undef), # (namevar) The targeted command to use when managing a...
          ensure               => lookup("${packagesyaml}.${packagename}.ensure", undef, 'deep', undef), # What state the package should be in. On...
          adminfile            => lookup("${packagesyaml}.${packagename}.adminfile", undef, 'deep', undef), # A file containing package defaults for...
          allow_virtual        => lookup("${packagesyaml}.${packagename}.allow_virtual", undef, 'deep', undef), # Specifies if virtual package names are allowed...
          allowcdrom           => lookup("${packagesyaml}.${packagename}.allowcdrom", undef, 'deep', undef), # Tells apt to allow cdrom sources in the...
          category             => lookup("${packagesyaml}.${packagename}.category", undef, 'deep', undef), # A read-only parameter set by the...
          configfiles          => lookup("${packagesyaml}.${packagename}.configfiles", undef, 'deep', undef), # Whether to keep or replace modified config files
          description          => lookup("${packagesyaml}.${packagename}.description", undef, 'deep', undef), # A read-only parameter set by the...
          enable_only          => lookup("${packagesyaml}.${packagename}.enable_only", undef, 'deep', undef), # Tells `dnf module` to only enable a specific...
          flavor               => lookup("${packagesyaml}.${packagename}.flavor", undef, 'deep', undef), # OpenBSD and DNF modules support 'flavors', which
          install_only         => lookup("${packagesyaml}.${packagename}.install_only", undef, 'deep', undef), # It should be set for packages that should only...
          install_options      => lookup("${packagesyaml}.${packagename}.install_options", undef, 'deep', undef), # An array of additional options to pass when...
          instance             => lookup("${packagesyaml}.${packagename}.instance", undef, 'deep', undef), # A read-only parameter set by the...
          mark                 => lookup("${packagesyaml}.${packagename}.mark", undef, 'deep', undef), # Set to hold to tell Debian apt/Solaris pkg to...
          package_settings     => lookup("${packagesyaml}.${packagename}.package_settings", undef, 'deep', undef), # Settings that can change the contents or...
          platform             => lookup("${packagesyaml}.${packagename}.platform", undef, 'deep', undef), # A read-only parameter set by the...
          provider             => lookup("${packagesyaml}.${packagename}.provider", undef, 'deep', undef), # The specific backend to use for this `package...
          reinstall_on_refresh => lookup("${packagesyaml}.${packagename}.reinstall_on_refresh", undef, 'deep', undef), # Whether this resource should respond to refresh...
          responsefile         => lookup("${packagesyaml}.${packagename}.responsefile", undef, 'deep', undef), # A file containing any necessary answers to...
          root                 => lookup("${packagesyaml}.${packagename}.root", undef, 'deep', undef), # A read-only parameter set by the...
          source               => lookup("${packagesyaml}.${packagename}.source", undef, 'deep', undef), # Where to find the package file. This is mostly...
          status               => lookup("${packagesyaml}.${packagename}.status", undef, 'deep', undef), # A read-only parameter set by the...
          uninstall_options    => lookup("${packagesyaml}.${packagename}.uninstall_options", undef, 'deep', undef), # An array of additional options to pass when...
          vendor               => lookup("${packagesyaml}.${packagename}.vendor", undef, 'deep', undef), # A read-only parameter set by the...
      }
    }
  } else {
    notify{"pocketprotector::packages: lookup filed for file for ${packagesyaml}":}
  }
}

define pocketprotector::packages::repositories::parse (
  String $repositoriesyaml = $name,
){
  case lookup('pocketprotector::packages::provider') {
    'apt': {
      pocketprotector::packages::repositories::apt::source::parse{$repositoriesyaml:}
    }
    'zypper': {
      pocketprotector::packages::repositories::zypper::parse{$repositoriesyaml:}
    }
}

class pocketprotector::packages {
  include pocketprotector::packages::repositories

  if lookup('pocketprotector::packages', undef, 'deep', false) {
    pocketprotector::packages::parse{'pocketprotector::packages':}
    pocketprotector::packages::repositories::parse{'pocketprotector::packages::repositories':}
  }
}

# build repository list & pass to appropriate module
class pocketprotector::packages::repositories {
  case lookup('pocketprotector::packages::provider') {
    'apt': {
      include pocketprotector::packages::repositories::apt::init
      pocketprotector::packages::repositories::apt::pin::parse{'pocketprotector::packages::pin':}
      pocketprotector::packages::repositories::apt::ppa::parse{'pocketprotector::packages::ppa':}
      include pocketprotector::packages::updates::apt
    }
    'zypper': {
      # if we ever need any special init for zypper, it'll go here
    }
    default: {
      notify{'pocketprotector::packages::repositories: the package repository for your OS is not (yet?) supported':}
    }
  }
  pocketprotector::packages::repositories::parse{'pocketprotector::packages::repositories':}
}
