# manifests/security.pp
#
# stub for future security layer support (apparmor / selinux / etc)
#

class pocketprotector::security {
  include pocketprotector::security::password
}
