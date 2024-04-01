# manifests/security/password.pp
#
# enforcing password requirements
#

class pocketprotector::security::password {
  case lookup('pocketprotector::security::password::enforcer') {
    'cracklib': {
      include pocketprotector::security::password::cracklib
    }
    'pwquality': {
      include pocketprotector::security::password::pwquality
    }
    default: {
      notify{'pocketprotector::security::password: password enforcement mechanism undefined':}
    }
  }
}

class pocketprotector::security::password::cracklib {
  # initialize policy arguments & grep statement
  $passpol_args = lookup('pocketprotector::security::password::policy', undef, 'deep', undef).map |String $policyname, Integer $policyvalue| {
    "--cracklib-$policyname=$policyvalue"
  }.join(" ")
  $passpol_grep = lookup('pocketprotector::security::password::policy', undef, 'deep', undef).map |String $policyname, Integer $policyvalue| {
    "$policyname=$policyvalue"
  }.join("|")

  #notify{"passpol_args is $passpol_args and passpol_grep is $passpol_grep":}

  # run pam-config if something needs updates
  exec {
    "/usr/sbin/pam-config -a $passpol_args":
      onlyif =>  "/usr/bin/grep cracklib /etc/pam.d/common-password | /usr/bin/grep -vqE \"$passpol_grep\""
  }
}

class pocketprotector::security::password::pwquality {
  # populate vars w/ deep merge
  #  lookup('pocketprotector::security::password::policy', undef, 'deep', undef).each |String $policyname, Integer $policyvalue| {
  #  $passpol_$policyname = $policyvalue
  #}

  pocketprotector::packages::parse{'pocketprotector::security::password::packages::pwquality':}
  pocketprotector::files::templates::parse{'pocketprotector::security::password::pwquality::templates':}
}
