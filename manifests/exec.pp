# manifests/exec.pp
#
# exec management

#
# custom content type to deal with execs
#
# walks through $exechash and defines execs
#

define pocketprotector::exec::parse (
  String $execyaml = $name,
  ){
  if lookup($execyaml, undef, 'deep', false) {
    lookup($execyaml, undef, 'deep', false).each |String $execname, Hash $exechash| {
      #notify {"pocketprotector::exec: exec creation for for ${execname}":}

      exec { 
        $execname:
          name        => lookup("${execyaml}.${execname}.name", undef, 'deep', undef),
          command     => lookup("${execyaml}.${execname}.command", undef, 'deep', undef),
          creates     => lookup("${execyaml}.${execname}.creates", undef, 'deep', undef),
          cwd         => lookup("${execyaml}.${execname}.cwd", undef, 'deep', undef),
          environment => lookup("${execyaml}.${execname}.environment", undef, 'deep', undef),
          onlyif      => lookup("${execyaml}.${execname}.onlyif", undef, 'deep', undef),
          path        => lookup("${execyaml}.${execname}.path", undef, 'deep', undef),
          provider    => lookup("${execyaml}.${execname}.provider", undef, 'deep', undef),
          refresh     => lookup("${execyaml}.${execname}.refresh", undef, 'deep', undef),
          refreshonly => lookup("${execyaml}.${execname}.refreshonly", undef, 'deep', undef),
          returns     => lookup("${execyaml}.${execname}.returns", undef, 'deep', undef),
          timeout     => lookup("${execyaml}.${execname}.timeout", undef, 'deep', undef),
          tries       => lookup("${execyaml}.${execname}.tries", undef, 'deep', undef),
          try_sleep   => lookup("${execyaml}.${execname}.try_sleep", undef, 'deep', undef),
          umask       => lookup("${execyaml}.${execname}.umask", undef, 'deep', undef),
          unless      => lookup("${execyaml}.${execname}.unless", undef, 'deep', undef),
          user        => lookup("${execyaml}.${execname}.user", undef, 'deep', undef),
          notify      => lookup("${execyaml}.${execname}.notify", undef, 'deep', undef),
          subscribe   => lookup("${execyaml}.${execname}.subscribe", undef, 'deep', undef),
      }
    }
  }
}

#
# crawl pocketprotector execs in hieradata 
#
class pocketprotector::exec {
  pocketprotector::exec::parse{'pocketprotector::exec':}
}
