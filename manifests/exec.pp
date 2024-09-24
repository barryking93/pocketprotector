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
          name        => lookup("${execyaml}.${execname}.name", undef, 'first', undef),
          command     => lookup("${execyaml}.${execname}.command", undef, 'first', undef),
          creates     => lookup("${execyaml}.${execname}.creates", undef, 'first', undef),
          cwd         => lookup("${execyaml}.${execname}.cwd", undef, 'first', undef),
          environment => lookup("${execyaml}.${execname}.environment", undef, 'first', undef),
          onlyif      => lookup("${execyaml}.${execname}.onlyif", undef, 'first', undef),
          path        => lookup("${execyaml}.${execname}.path", undef, 'first', undef),
          provider    => lookup("${execyaml}.${execname}.provider", undef, 'first', undef),
          refresh     => lookup("${execyaml}.${execname}.refresh", undef, 'first', undef),
          refreshonly => lookup("${execyaml}.${execname}.refreshonly", undef, 'first', undef),
          returns     => lookup("${execyaml}.${execname}.returns", undef, 'first', undef),
          timeout     => lookup("${execyaml}.${execname}.timeout", undef, 'first', undef),
          tries       => lookup("${execyaml}.${execname}.tries", undef, 'first', undef),
          try_sleep   => lookup("${execyaml}.${execname}.try_sleep", undef, 'first', undef),
          umask       => lookup("${execyaml}.${execname}.umask", undef, 'first', undef),
          unless      => lookup("${execyaml}.${execname}.unless", undef, 'first', undef),
          user        => lookup("${execyaml}.${execname}.user", undef, 'first', undef),
          weekday     => lookup("${execyaml}.${execname}.weekday", undef, 'first', undef),
          notify      => lookup("${execyaml}.${execname}.notify", undef, 'first', undef),
          subscribe   => lookup("${execyaml}.${execname}.subscribe", undef, 'first', undef),
      }
    }
  }
}

#
# crawl pocketprotector.execs in hieradata for user list
#
class pocketprotector::exec {
  pocketprotector::exec::parse{'pocketprotector::exec':}
}
