# pocketprotector

a puppet framework for managing infrastructure services

# WARNING:
considered an alpha product and under active development.  expect breaking changes.

# VISION:
- full stack support for rhel/centos/opensuse/sles/ubuntu(LTS)

# PROGRESS:
## DONE:
- user management
## TO DO:
### NEAR TERM
- package management
- ZFS support
- samba support
- NFS export / mount support

### MID TERM
- monitoring
  - pluggable support for nagios and prometheus
  - nagios is first target, as is known entity

### LONGER TERM
- FIPS 800-53 compliance
- ZFS disk management

# BOOTSTRAP
```
# PVER=$(grep VERSION_CODENAME /etc/os-release | sed 's/.*=//g')
# wget https://apt.puppet.com/puppet7-release-${PVER}.deb
# dpkg -i puppet7-release-${PVER}.deb
# apt update;apt -y install puppet-agent r10k
```
copy .pub versions of above keys to appropriate git repositories

create /etc/puppetlabs/r10k/r10k.yaml:
```
# The location to use for storing cached Git repos
:cachedir: '/var/cache/r10k'

# A list of git repositories to create
:sources:
  # This will clone the git repository and instantiate an environment per
  # branch in /etc/puppetlabs/code/environments
  :my-org:
    remote: 'git@github.com:barryking93/pocket-inerd.git'
    basedir: '/etc/puppetlabs/code/environments'
:git:
  provider: shellgit
  repositories:
    - remote: 'git@github.com:barryking93/pocket-inerd.git'
      private_key: "/root/.ssh/id_ecdsa"
    - remote: "git@github.com:barryking93/pocketprotector.git"
      private_key: "/root/.ssh/pocketprotector-deploy"
```
deploy
```
 # r10k deploy environment -p
```
