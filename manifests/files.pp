# manifests/file.pp
#
# file handlers
#

define pocketprotector::files::parse (
  String $filesyaml = $name,
){

  if lookup($filesyaml, undef, 'deep', false) {
    lookup($filesyaml, undef, 'deep', undef).each |String $filename, Hash $filehash| {
      #notify {"pocketprotector::files: debug file for ${filename}":}

      file {
        $filename:
          path                    => lookup("(${filesyaml}.${filename}.path", undef, 'deep', undef),
          ensure                  => lookup("${filesyaml}.${filename}.ensure", undef, 'deep', undef),
          backup                  => lookup("${filesyaml}.${filename}.backup", undef, 'deep', undef),
          checksum                => lookup("${filesyaml}.${filename}.checksum", undef, 'deep', undef),
          checksum_value          => lookup("${filesyaml}.${filename}.checksum_value", undef, 'deep', undef),
          content                 => lookup("${filesyaml}.${filename}.content", undef, 'deep', undef),
          ctime                   => lookup("${filesyaml}.${filename}.ctime", undef, 'deep', undef),
          force                   => lookup("${filesyaml}.${filename}.force", undef, 'deep', undef),
          group                   => lookup("${filesyaml}.${filename}.group", undef, 'deep', undef),
          ignore                  => lookup("${filesyaml}.${filename}.ignore", undef, 'deep', undef),
          links                   => lookup("${filesyaml}.${filename}.links", undef, 'deep', undef),
          mode                    => lookup("${filesyaml}.${filename}.mode", undef, 'deep', undef),
          mtime                   => lookup("${filesyaml}.${filename}.require", undef, 'deep', undef),
          notify                  => lookup("${filesyaml}.${filename}.notify", undef, 'deep', undef),
          owner                   => lookup("${filesyaml}.${filename}.owner", undef, 'deep', undef),
          provider                => lookup("${filesyaml}.${filename}.provider", undef, 'deep', undef),
          purge                   => lookup("${filesyaml}.${filename}.purge", undef, 'deep', undef),
          recurse                 => lookup("${filesyaml}.${filename}.recurse", undef, 'deep', undef),
          recurselimit            => lookup("${filesyaml}.${filename}.recurselimit", undef, 'deep', undef),
          replace                 => lookup("${filesyaml}.${filename}.replace", undef, 'deep', undef),
          require                 => lookup("${filesyaml}.${filename}.require", undef, 'deep', undef),
          selinux_ignore_defaults => lookup("${filesyaml}.${filename}.selinux_ignore_defaults", undef, 'deep', undef),
          selrange                => lookup("${filesyaml}.${filename}.selrange", undef, 'deep', undef),
          selrole                 => lookup("${filesyaml}.${filename}.selrole", undef, 'deep', undef),
          seltype                 => lookup("${filesyaml}.${filename}.seltype", undef, 'deep', undef),
          seluser                 => lookup("${filesyaml}.${filename}.seluser", undef, 'deep', undef),
          show_diff               => lookup("${filesyaml}.${filename}.show_diff", undef, 'deep', undef),
          source                  => lookup("${filesyaml}.${filename}.source", undef, 'deep', undef),
          source_permissions      => lookup("${filesyaml}.${filename}.source_permissions", undef, 'deep', undef),
          sourceselect            => lookup("${filesyaml}.${filename}.sourceselect", undef, 'deep', undef),
          target                  => lookup("${filesyaml}.${filename}.target", undef, 'deep', undef),
          type                    => lookup("${filesyaml}.${filename}.type", undef, 'deep', undef),
          validate_cmd            => lookup("${filesyaml}.${filename}.validate_cmd", undef, 'deep', undef),
          validate_replacement    => lookup("${filesyaml}.${filename}.validate_replacement", undef, 'deep', undef);
      }
    }
  } else {
    notify{"pocketprotector::files::parse lookup filed for ${filesyaml}":}
  }
}

# another file definition with a different content lookup
define pocketprotector::files::templates::parse (
  String $filesyaml = $name,
){
  if lookup($filesyaml, undef, 'deep', false) {
    lookup($filesyaml, undef, 'deep', undef).each |String $filename, Hash $filehash| {
      #notify {"pocketprotector::files::templates debug file for ${filename}":}

      file {
        $filename:
          path                    => lookup("${filesyaml}::templates.${filename}.path", undef, 'deep', undef),
          ensure                  => lookup("${filesyaml}::templates.${filename}.ensure", undef, 'deep', undef),
          backup                  => lookup("${filesyaml}::templates.${filename}.backup", undef, 'deep', undef),
          checksum                => lookup("${filesyaml}::templates.${filename}.checksum", undef, 'deep', undef),
          checksum_value          => lookup("${filesyaml}::templates.${filename}.checksum_value", undef, 'deep', undef),
          content                 => template(lookup("${filesyaml}::templates.${filename}.content", undef, 'deep', undef)),
          ctime                   => lookup("${filesyaml}::templates.${filename}.ctime", undef, 'deep', undef),
          force                   => lookup("${filesyaml}::templates.${filename}.force", undef, 'deep', undef),
          group                   => lookup("${filesyaml}::templates.${filename}.group", undef, 'deep', undef),
          ignore                  => lookup("${filesyaml}::templates.${filename}.ignore", undef, 'deep', undef),
          links                   => lookup("${filesyaml}::templates.${filename}.links", undef, 'deep', undef),
          mode                    => lookup("${filesyaml}::templates.${filename}.mode", undef, 'deep', undef),
          mtime                   => lookup("${filesyaml}::templates.${filename}.require", undef, 'deep', undef),
          notify                  => lookup("${filesyaml}::templates.${filename}.notify", undef, 'deep', undef),
          owner                   => lookup("${filesyaml}::templates.${filename}.owner", undef, 'deep', undef),
          provider                => lookup("${filesyaml}::templates.${filename}.provider", undef, 'deep', undef),
          purge                   => lookup("${filesyaml}::templates.${filename}.purge", undef, 'deep', undef),
          recurse                 => lookup("${filesyaml}::templates.${filename}.recurse", undef, 'deep', undef),
          recurselimit            => lookup("${filesyaml}::templates.${filename}.recurselimit", undef, 'deep', undef),
          replace                 => lookup("${filesyaml}::templates.${filename}.replace", undef, 'deep', undef),
          require                 => lookup("${filesyaml}::templates.${filename}.require", undef, 'deep', undef),
          selinux_ignore_defaults => lookup("${filesyaml}::templates.${filename}.selinux_ignore_defaults", undef, 'deep', undef),
          selrange                => lookup("${filesyaml}::templates.${filename}.selrange", undef, 'deep', undef),
          selrole                 => lookup("${filesyaml}::templates.${filename}.selrole", undef, 'deep', undef),
          seltype                 => lookup("${filesyaml}::templates.${filename}.seltype", undef, 'deep', undef),
          seluser                 => lookup("${filesyaml}::templates.${filename}.seluser", undef, 'deep', undef),
          show_diff               => lookup("${filesyaml}::templates.${filename}.show_diff", undef, 'deep', undef),
          #source                  => lookup("${filesyaml}::templates.${filename}.source", undef, 'deep', undef),
          source_permissions      => lookup("${filesyaml}::templates.${filename}.source_permissions", undef, 'deep', undef),
          sourceselect            => lookup("${filesyaml}::templates.${filename}.sourceselect", undef, 'deep', undef),
          target                  => lookup("${filesyaml}::templates.${filename}.target", undef, 'deep', undef),
          type                    => lookup("${filesyaml}::templates.${filename}.type", undef, 'deep', undef),
          validate_cmd            => lookup("${filesyaml}::templates.${filename}.validate_cmd", undef, 'deep', undef),
          validate_replacement    => lookup("${filesyaml}::templates.${filename}.validate_replacement", undef, 'deep', undef);
        }
    }
  } else {
    notify{"pocketprotector::files::templates::parse lookup failed for ${filesyaml}":}
  }

}
#
# feed pocketprotector::files and pocketprotector::files::tempaltes to appropriate generators
#
class pocketprotector::files {
  pocketprotector::files::parse{'pocketprotector::files':}
  pocketprotector::files::templates::parse{'pocketprotector::files::templates':}

  include pocketprotector::files::base
}

class pocketprotector::files::base {
  # deep searches have to happen outside of templates
  $hostshosts = lookup('pocketprotector::etc::hosts',undef,'deep',undef)

  file {
    '/etc/hosts':
      content => template('pocketprotector/etc/hosts.erb')
  }
}
