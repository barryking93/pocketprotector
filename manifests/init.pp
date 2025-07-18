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
  include pocketprotector::exec
  # files for baseline file rollouts
  include pocketprotector::groups
  include pocketprotector::files
  # puppet to ensure that this runs a second time
  include pocketprotector::puppet
  include pocketprotector::cron
  # firewall, when supported
  #include pocketprotector::firewall
  # roles, when detected
  include pocketprotector::roles
  # alphabetical general support
  include pocketprotector::db
  include pocketprotector::fs
  include pocketprotector::monitoring
  include pocketprotector::mta
  include pocketprotector::netsvc
  include pocketprotector::security
  # gpu detection and support
  include pocketprotector::gpu
  # hpc support
  include pocketprotector::hpc
}
