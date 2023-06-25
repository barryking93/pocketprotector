# manifests/mta.pp

class pocketprotector::mta {
  case lookup('pocketprotector::mta::default') {
    'postfix': {
      include pocketprotector::mta::postfix
    }
    default: {}
  }
}
