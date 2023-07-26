# manifests/mta.pp

class pocketprotector::mta {
  case lookup('pocketprotector::mta::default') {
    'postfix': {
      include pocketprotector::mta::postfix
    }
    default: {}
  }

  # the below can integrate with any MTA and auto-configures based on yaml
  include pocketprotector::mta::opendkim
}
