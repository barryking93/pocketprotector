# manifests/init.pp
#
#

class pocketprotector {
  # order here matters:
  #
  # packages first to set up proper repos
  include pocketprotector::packages
  # accounts to establish fundamental owners for needed later ownership
  include pocketprotector::accounts
  # files for baseline file rollouts
  include pocketprotector::files
  # etc to roll out custom facts/etc
  include pocketprotector::etc
  # puppet to ensure that this runs a second time
  include pocketprotector::puppet
  # firewall, when supported
  #include pocketprotector::firewall
  # everything beyond here is alphabetical
  include pocketprotector::monitoring
  include pocketprotector::mta
  # gpu detection and support
  include pocketprotector::gpu
  # openbox support
  include pocketprotector::openbox
}
