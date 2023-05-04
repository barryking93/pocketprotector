# pocketprotector

a puppet framework for managing infrastructure services

# VISION:
- full stack support for rhel/centos/opensuse/sles/ubuntu(LTS)

# TO DO:
## NEAR TERM
- user management
- package management
- ZFS support
- samba support
- NFS export / mount support

## MID TERM
- monitoring
  - pluggable support for nagios and prometheus
  - nagios is first target, as is known entity

## LONGER TERM
- FIPS 800-53 compliance
- ZFS disk management

# BOOTSTRAP
```
PVER=$(grep VERSION_CODENAME /etc/os-release | sed 's/.*=//g')
wget https://apt.puppet.com/puppet7-release-${PVER}.deb
sudo dpkg -i puppet7-release-${PVER}.deb
sudo apt update;sudo apt -y install puppet-agent
sudo /opt/puppetlabs/puppet/bin/gem install rugged r10k
ssh-keygen
cd ~/.ssh ; ssh-keygen -f pocketprotector-deploy
```

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
  # must use rugged to get per-repo custom private_key
  provider: rugged
  repositories:
    - remote: "git@github.com:barryking93/pocketprotector.git"
      private_key: "/root/.ssh/pocketprotector-deploy"
```
