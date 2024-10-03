# manifests/hpc.pp
#
# for HPC-related technologies
#

class pocketprotector::hpc {
  include pocketprotector::hpc::slurm
}
