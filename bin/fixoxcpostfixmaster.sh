# !/bin/bash
# generate oxc's postfix_master implementation
# https://forge.puppet.com/modules/oxc/postfix/readme#usage
# for use in postrun

for envdir in `find /etc/puppetlabs/code/environments/ -maxdepth 1 -mindepth 1 -type d`;do
  mkdir ${envdir}/modules/postfix/data/modules
  ruby ${envdir}/modules/postfix/scripts/master2hierayaml.rb /usr/share/doc/postfix/defaults/master.cf > ${envdir}/modules/postfix/data/modules/postfix.yaml
done
