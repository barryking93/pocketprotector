# manifests/services.pp
#
# service handlers
#

define pocketprotector::services::parse (
  String $servicesyaml = $name,
){

  if lookup($servicesyaml, undef, 'deep', false) {
    lookup($servicesyaml, undef, 'deep', undef).each |String $servicename, Hash $servicehash| {
      #notify {"pocketprotector::services::parse: debug service for ${servicename}":}

      service {
        "${servicename}":
          name       => lookup("(${servicesyaml}.\"${servicename}\".name", undef, 'deep', undef),
          ensure     => lookup("${servicesyaml}.\"${servicename}\".ensure", undef, 'deep', undef),
          binary     => lookup("${servicesyaml}.\"${servicename}\".binary", undef, 'deep', undef),
          control    => lookup("${servicesyaml}.\"${servicename}\".control", undef, 'deep', undef),
          enable     => lookup("${servicesyaml}.\"${servicename}\".enable", undef, 'deep', undef),
          flags      => lookup("${servicesyaml}.\"${servicename}\".flags", undef, 'deep', undef),
          hasrestart => lookup("${servicesyaml}.\"${servicename}\".hasrestart", undef, 'deep', undef),
          hasstatus  => lookup("${servicesyaml}.\"${servicename}\".hasstatus", undef, 'deep', undef),
          manifest   => lookup("${servicesyaml}.\"${servicename}\".manifest", undef, 'deep', undef),
          path       => lookup("${servicesyaml}.\"${servicename}\".path", undef, 'deep', undef),
          pattern    => lookup("${servicesyaml}.\"${servicename}\".pattern", undef, 'deep', undef),
          provider   => lookup("${servicesyaml}.\"${servicename}\".provider", undef, 'deep', undef),
          restart    => lookup("${servicesyaml}.\"${servicename}\".restart", undef, 'deep', undef),
          start      => lookup("${servicesyaml}.\"${servicename}\".start", undef, 'deep', undef),
          status     => lookup("${servicesyaml}.\"${servicename}\".status", undef, 'deep', undef),
          stop       => lookup("${servicesyaml}.\"${servicename}\".stop", undef, 'deep', undef),
          subscribe  => lookup("${servicesyaml}.\"${servicename}\".subscribe", undef, 'deep', undef),
      }
    }
  } else {
    #notify{"pocketprotector::services::parse lookup serviced for ${servicesyaml}":}
  }
}

