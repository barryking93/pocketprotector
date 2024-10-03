# manifests/hpc/slurm.pp
#
# SLURM, the job scheduler
#

class pocketprotector::hpc::slurm {
  if lookup('pocketprotector::hpc::slurm::server',undef,'deep',false) {
    case $::fqdn {
      lookup('pocketprotector::hpc::slurm::server'): {
        include pocketprotector::hpc::slurm::server
      }
      default: {
        include pocketprotector::hpc::slurm::client
      }
    }
  }
}

class pocketprotector::hpc::slurm::server {
  if lookup('pocketprotector::monitoring::nagios::server',undef,'deep',false) {
    # push nagios check scripts for slurm
    pocketprotector::files::parse{'pocketprotector::hpc::slurm::server::nagios::files':}

    $nagconfigd = lookup('pocketprotector::monitoring::nagios::server::configd')

    # tell nagios to use these checks
    @@nagios_service { "${::fqdn}_check_slurm_jobs}":
      ensure              => present,
      use                 => 'generic-service',
      host_name           => $::fqdn,
      service_description => "${::fqdn} slurm jobs",
      check_command       => "check_slurm_jobs",
      target                => "${nagconfigd}/host_${::fqdn}.cfg";
    }
    @@nagios_service { "${::fqdn}_check_slurm_nodes}":
      ensure              => present,          
      use                 => 'generic-service',
      host_name           => $::fqdn,          
      service_description => "${::fqdn} slurm nodes",
      check_command       => "check_slurm_nodes",
      target                => "${nagconfigd}/host_${::fqdn}.cfg";
    }   
  }
}

class pocketprotector::hpc::slurm::client {
  pocketprotector::files::templates::parse{'pocketprotector::hpc::slurm::client::nagios::files::templates':}
}
