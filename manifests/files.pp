# manifests/file.pp
#
# file handler
#

#
# crawl pocketprotector.files in hieradata for file list
#
class pocketprotector::files {
  lookup('pocketprotector::files', undef, 'deep', undef).each |String $filename, Hash $filehash| {
    #notify {"debug account for ${username}":}
    file {
      $filename:
        path                    => lookup("pocketprotector::files.${filename}.path", undef, 'first', undef),
        ensure                  => lookup("pocketprotector::files.${filename}.ensure", undef, 'first', undef),
        backup                  => lookup("pocketprotector::files.${filename}.backup", undef, 'first', undef),
        checksum                => lookup("pocketprotector::files.${filename}.checksum", undef, 'first', undef),
        checksum_value          => lookup("pocketprotector::files.${filename}.checksum_value", undef, 'first', undef),
        content                 => lookup("pocketprotector::files.${filename}.content", undef, 'first', undef),
        ctime                   => lookup("pocketprotector::files.${filename}.ctime", undef, 'first', undef),
        force                   => lookup("pocketprotector::files.${filename}.force", undef, 'first', undef),
        group                   => lookup("pocketprotector::files.${filename}.group", undef, 'first', undef),
        ignore                  => lookup("pocketprotector::files.${filename}.ignore", undef, 'first', undef),
        links                   => lookup("pocketprotector::files.${filename}.links", undef, 'first', undef),
        mode                    => lookup("pocketprotector::files.${filename}.mode", undef, 'first', undef),
        mtime                   => lookup("pocketprotector::files.${filename}.require", undef, 'first', undef),
        notify                  => lookup("pocketprotector::files.${filename}.notify", undef, 'first', undef),
        owner                   => lookup("pocketprotector::files.${filename}.owner", undef, 'first', undef),
        provider                => lookup("pocketprotector::files.${filename}.provider", undef, 'first', undef),
        purge                   => lookup("pocketprotector::files.${filename}.purge", undef, 'first', undef),
        recurse                 => lookup("pocketprotector::files.${filename}.recurse", undef, 'first', undef),
        recurselimit            => lookup("pocketprotector::files.${filename}.recurselimit", undef, 'first', undef),
        replace                 => lookup("pocketprotector::files.${filename}.replace", undef, 'first', undef),
        require                 => lookup("pocketprotector::files.${filename}.require", undef, 'first', undef),
        selinux_ignore_defaults => lookup("pocketprotector::files.${filename}.selinux_ignore_defaults", undef, 'first', undef),
        selrange                => lookup("pocketprotector::files.${filename}.selrange", undef, 'first', undef),
        selrole                 => lookup("pocketprotector::files.${filename}.selrole", undef, 'first', undef),
        seltype                 => lookup("pocketprotector::files.${filename}.seltype", undef, 'first', undef),
        seluser                 => lookup("pocketprotector::files.${filename}.seluser", undef, 'first', undef),
        show_diff               => lookup("pocketprotector::files.${filename}.show_diff", undef, 'first', undef),
        source                  => lookup("pocketprotector::files.${filename}.source", undef, 'first', undef),
        source_permissions      => lookup("pocketprotector::files.${filename}.source_permissions", undef, 'first', undef),
        sourceselect            => lookup("pocketprotector::files.${filename}.sourceselect", undef, 'first', undef),
        target                  => lookup("pocketprotector::files.${filename}.target", undef, 'first', undef),
        type                    => lookup("pocketprotector::files.${filename}.type", undef, 'first', undef),
        validate_cmd            => lookup("pocketprotector::files.${filename}.validate_cmd", undef, 'first', undef),
        validate_replacement    => lookup("pocketprotector::files.${filename}.validate_replacement", undef, 'first', undef);
    }
  }
}
