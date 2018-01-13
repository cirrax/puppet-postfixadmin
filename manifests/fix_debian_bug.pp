#
# This fixes debian bug #856338
#
# see:
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=856338

class postfixadmin::fix_debian_bug (
  $docroot = $postfixadmin::params::docroot,
) inherits postfixadmin::params {

  file { "${docroot}/templates_c":
    ensure => 'directory',
    owner  => 'root',
    group  => 'www-data',
    mode   => '0770',
  }
}
