# manifests/init.pp
#
#

class pocketprotector {
  # order here matters:
  #
  # packages first to set up proper repos
  include pocketprotector::packages
  # accounts to establish fundamental owners for needed later ownership
  include pocketprotector::groups
  include pocketprotector::accounts
  # files for baseline file rollouts
  include pocketprotector::groups
  include pocketprotector::files
  # puppet to ensure that this runs a second time
  include pocketprotector::puppet
  # firewall, when supported
  #include pocketprotector::firewall
  # roles, when detected
  include pocketprotector::roles
  # everything beyond here is alphabetical
  include pocketprotector::db
  include pocketprotector::monitoring
  include pocketprotector::mta
  # gpu detection and support
  include pocketprotector::gpu
  # openbox support
  include pocketprotector::openbox
}
