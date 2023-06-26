# manifests/mta/postfix.pp

class pocketprotector::mta::postfix {
  class { 'postfix': }
#  case lookup('pocketprotector::mta::postfix::options::satellite') {
#    true: {
#      class { 'postfix':
#        relayhost           => lookup('pocketprotector::mta::options::relayhost'),
#        myorigin            => $::fqdn,
#        root_mail_recipient => lookup('pocketprotector::mta::options::root_alias'),
#        satellite           => true,
#      }
#    }
#    false: {
#      class { 'postfix':
#        relayhost           => direct,
#        smtp_listen         => lookup('pocketprotector::mta::options::smtp_listen'),
#        root_mail_recipient => lookup('pocketprotector::mta::options::root_alias'),
#        mta                 => true,
#      }
#    }
#  }
}
