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
  $passpol_args = ''
  $passpol_grep = ''

  # build passpol_args and $passpol_grep
  lookup('pocketprotector::security::password::policy', undef, 'deep', undef).each |String $policyname, Integer $policyvalue| {
    $passpol_args = "$passpol_args --cracklib-$policyname=$policyvalue"
    $passpol_grep = "$policyname=$policyvalue|$passpol_grep"
  }

  notify{"passpol_args is $passpol_args and passpol_grep is $passpol_grep":}

  # run pam-config if something needs updates
  #exec {
  #  "/usr/sbin/pam-config -a $passpol_args":
  #    onlyif =>  "grep cracklib /etc/pam.d/common-password| grep -vqE \"$passpol_grep\""
  #}
}

class pocketprotector::security::password::pwquality {
  pocketprotector::files::templates::parse{'pocketprotector::security::password::pwquality::templates':}
}
