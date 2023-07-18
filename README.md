# pocketprotector

a puppet framework for managing infrastructure services

# WARNING:
considered an alpha product and under active development.  expect breaking changes.

# VISION:
- full stack support for rhel/centos/opensuse/sles/ubuntu(LTS)

# PROGRESS:
Now tracked in github here:  <https://github.com/barryking93/pocketprotector/issues>

# BOOTSTRAP (UBUNTU)
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
# USAGE
add some equivalent to the following to your Puppetfile
```
# pocketprotector and dependencies

mod 'pocketprotector',
 :git => 'https://github.com/barryking93/pocketprotector.git',
 :branch => 'development'

mod 'puppetlabs-accounts', :latest
mod 'puppetlabs-stdlib', :latest
mod 'puppetlabs-nagios_core', :latest

# PuppetDB + requirements
mod 'puppetlabs-puppetdb', :latest
mod 'puppetlabs-postgresql', :latest
mod 'puppet-puppetboard', :latest
mod 'puppetlabs-firewall', :latest
mod 'puppetlabs-inifile', :latest

# Ubuntu package mgmt
mod 'puppetlabs-apt', :latest
mod 'puppetlabs-concat', :latest

# postfix dependencies
mod 'oxc-postfix', :latest
```
