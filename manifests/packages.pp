
class pocketprotector::packages {
  if lookup("pocketprotector::packages", undef, 'deep', false) == true: {
    lookup("pocketprotector::packages", undef, 'deep', undef):
      ensure => installed;
  }
  if lookup("pocketprotector::packages::latest", undef, 'deep', false) == true: {
    lookup("pocketprotector::packages::latest", undef, 'deep', undef):
      ensure => latest;
  }
}
