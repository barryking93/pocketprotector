# manifests/file.pp
#
# file handlers
#

define pocketprotector::files (
  Hash $fileshash,
  ){
  $fileshash.each |String $filename, Hash $filehash| {
    #notify {"pocketprotector::files: debug file for ${filename}":}

    file {
      $filename:
        path                    => lookup("pocketprotector::files.${filename}.path", undef, 'deep', undef),
        ensure                  => lookup("pocketprotector::files.${filename}.ensure", undef, 'deep', undef),
        backup                  => lookup("pocketprotector::files.${filename}.backup", undef, 'deep', undef),
        checksum                => lookup("pocketprotector::files.${filename}.checksum", undef, 'deep', undef),
        checksum_value          => lookup("pocketprotector::files.${filename}.checksum_value", undef, 'deep', undef),
        content                 => lookup("pocketprotector::files.${filename}.content", undef, 'deep', undef),
        ctime                   => lookup("pocketprotector::files.${filename}.ctime", undef, 'deep', undef),
        force                   => lookup("pocketprotector::files.${filename}.force", undef, 'deep', undef),
        group                   => lookup("pocketprotector::files.${filename}.group", undef, 'deep', undef),
        ignore                  => lookup("pocketprotector::files.${filename}.ignore", undef, 'deep', undef),
        links                   => lookup("pocketprotector::files.${filename}.links", undef, 'deep', undef),
        mode                    => lookup("pocketprotector::files.${filename}.mode", undef, 'deep', undef),
        mtime                   => lookup("pocketprotector::files.${filename}.require", undef, 'deep', undef),
        notify                  => lookup("pocketprotector::files.${filename}.notify", undef, 'deep', undef),
        owner                   => lookup("pocketprotector::files.${filename}.owner", undef, 'deep', undef),
        provider                => lookup("pocketprotector::files.${filename}.provider", undef, 'deep', undef),
        purge                   => lookup("pocketprotector::files.${filename}.purge", undef, 'deep', undef),
        recurse                 => lookup("pocketprotector::files.${filename}.recurse", undef, 'deep', undef),
        recurselimit            => lookup("pocketprotector::files.${filename}.recurselimit", undef, 'deep', undef),
        replace                 => lookup("pocketprotector::files.${filename}.replace", undef, 'deep', undef),
        require                 => lookup("pocketprotector::files.${filename}.require", undef, 'deep', undef),
        selinux_ignore_defaults => lookup("pocketprotector::files.${filename}.selinux_ignore_defaults", undef, 'deep', undef),
        selrange                => lookup("pocketprotector::files.${filename}.selrange", undef, 'deep', undef),
        selrole                 => lookup("pocketprotector::files.${filename}.selrole", undef, 'deep', undef),
        seltype                 => lookup("pocketprotector::files.${filename}.seltype", undef, 'deep', undef),
        seluser                 => lookup("pocketprotector::files.${filename}.seluser", undef, 'deep', undef),
        show_diff               => lookup("pocketprotector::files.${filename}.show_diff", undef, 'deep', undef),
        source                  => lookup("pocketprotector::files.${filename}.source", undef, 'deep', undef),
        source_permissions      => lookup("pocketprotector::files.${filename}.source_permissions", undef, 'deep', undef),
        sourceselect            => lookup("pocketprotector::files.${filename}.sourceselect", undef, 'deep', undef),
        target                  => lookup("pocketprotector::files.${filename}.target", undef, 'deep', undef),
        type                    => lookup("pocketprotector::files.${filename}.type", undef, 'deep', undef),
        validate_cmd            => lookup("pocketprotector::files.${filename}.validate_cmd", undef, 'deep', undef),
        validate_replacement    => lookup("pocketprotector::files.${filename}.validate_replacement", undef, 'deep', undef);
    }
  }
}

define pocketprotector::files::templates (
  Hash $fileshash,
){
  $fileshash.each |String $filename, Hash $filehash| {
    #notify {"pocketprotector::files::templates debug file for ${filename}":}

    file {
      $filename:
        path                    => lookup("pocketprotector::files::templates.${filename}.path", undef, 'deep', undef),
        ensure                  => lookup("pocketprotector::files::templates.${filename}.ensure", undef, 'deep', undef),
        backup                  => lookup("pocketprotector::files::templates.${filename}.backup", undef, 'deep', undef),
        checksum                => lookup("pocketprotector::files::templates.${filename}.checksum", undef, 'deep', undef),
        checksum_value          => lookup("pocketprotector::files::templates.${filename}.checksum_value", undef, 'deep', undef),
        content                 => template(lookup("pocketprotector::files::templates.${filename}.content", undef, 'deep', undef)),
        ctime                   => lookup("pocketprotector::files::templates.${filename}.ctime", undef, 'deep', undef),
        force                   => lookup("pocketprotector::files::templates.${filename}.force", undef, 'deep', undef),
        group                   => lookup("pocketprotector::files::templates.${filename}.group", undef, 'deep', undef),
        ignore                  => lookup("pocketprotector::files::templates.${filename}.ignore", undef, 'deep', undef),
        links                   => lookup("pocketprotector::files::templates.${filename}.links", undef, 'deep', undef),
        mode                    => lookup("pocketprotector::files::templates.${filename}.mode", undef, 'deep', undef),
        mtime                   => lookup("pocketprotector::files::templates.${filename}.require", undef, 'deep', undef),
        notify                  => lookup("pocketprotector::files::templates.${filename}.notify", undef, 'deep', undef),
        owner                   => lookup("pocketprotector::files::templates.${filename}.owner", undef, 'deep', undef),
        provider                => lookup("pocketprotector::files::templates.${filename}.provider", undef, 'deep', undef),
        purge                   => lookup("pocketprotector::files::templates.${filename}.purge", undef, 'deep', undef),
        recurse                 => lookup("pocketprotector::files::templates.${filename}.recurse", undef, 'deep', undef),
        recurselimit            => lookup("pocketprotector::files::templates.${filename}.recurselimit", undef, 'deep', undef),
        replace                 => lookup("pocketprotector::files::templates.${filename}.replace", undef, 'deep', undef),
        require                 => lookup("pocketprotector::files::templates.${filename}.require", undef, 'deep', undef),
        selinux_ignore_defaults => lookup("pocketprotector::files::templates.${filename}.selinux_ignore_defaults", undef, 'deep', undef),
        selrange                => lookup("pocketprotector::files::templates.${filename}.selrange", undef, 'deep', undef),
        selrole                 => lookup("pocketprotector::files::templates.${filename}.selrole", undef, 'deep', undef),
        seltype                 => lookup("pocketprotector::files::templates.${filename}.seltype", undef, 'deep', undef),
        seluser                 => lookup("pocketprotector::files::templates.${filename}.seluser", undef, 'deep', undef),
        show_diff               => lookup("pocketprotector::files::templates.${filename}.show_diff", undef, 'deep', undef),
        #source                  => lookup("pocketprotector::files::templates.${filename}.source", undef, 'deep', undef),
        source_permissions      => lookup("pocketprotector::files::templates.${filename}.source_permissions", undef, 'deep', undef),
        sourceselect            => lookup("pocketprotector::files::templates.${filename}.sourceselect", undef, 'deep', undef),
        target                  => lookup("pocketprotector::files::templates.${filename}.target", undef, 'deep', undef),
        type                    => lookup("pocketprotector::files::templates.${filename}.type", undef, 'deep', undef),
        validate_cmd            => lookup("pocketprotector::files::templates.${filename}.validate_cmd", undef, 'deep', undef),
        validate_replacement    => lookup("pocketprotector::files::templates.${filename}.validate_replacement", undef, 'deep', undef);
    }
  }
}
#
# feed pocketprotector::files and pocketprotector::files::tempaltes to appropriate generators
#
class pocketprotector::files {
  pocketprotector::files{lookup('pocketprotector::files', undef, 'deep', undef):}
  pocketprotector::files::templates{lookup('pocketprotector::files::templates', undef, 'deep', undef):}
}
