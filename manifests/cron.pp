# manifests/cron.pp
#
# cronjob management

#
# custom content type to deal with crons
#
# walks through $usershash and defines crons
#

define pocketprotector::cron::parse (
  String $cronyaml = $name,
  ){
  lookup($cronyaml, undef, 'deep', false).each |String $cronname, Hash $cronhash| {
    #notify {"pocketprotector::cron: cron creation for for ${cronname}":}

    cron { 
      $cronname:
        name        => lookup("${cronyaml}.${cronname}.name", undef, 'first', undef),
        ensure      => lookup("${cronyaml}.${cronname}.ensure", undef, 'first', undef),
        command     => lookup("${cronyaml}.${cronname}.command", undef, 'first', undef),
        environment => lookup("${cronyaml}.${cronname}.environment", undef, 'first', undef),
        hour        => lookup("${cronyaml}.${cronname}.hour", undef, 'first', undef),
        minute      => lookup("${cronyaml}.${cronname}.minute", undef, 'first', undef),
        month       => lookup("${cronyaml}.${cronname}.month", undef, 'first', undef),
        monthday    => lookup("${cronyaml}.${cronname}.monthday", undef, 'first', undef),
        provider    => lookup("${cronyaml}.${cronname}.provider", undef, 'first', undef),
        special     => lookup("${cronyaml}.${cronname}.special", undef, 'first', undef),
        target      => lookup("${cronyaml}.${cronname}.target", undef, 'first', undef),
        user        => lookup("${cronyaml}.${cronname}.user", undef, 'first', undef),
        weekday     => lookup("${cronyaml}.${cronname}.weekday", undef, 'first', undef),
        notify      => lookup("${cronyaml}.${cronname}.notify", undef, 'first', undef),
        subscribe   => lookup("${cronyaml}.${cronname}.subscribe", undef, 'first', undef),
    }
  }
}

#
# crawl pocketprotector.crons in hieradata for user list
#
class pocketprotector::cron {
  pocketprotector::cron::parse{'pocketprotector::cron':}
}
