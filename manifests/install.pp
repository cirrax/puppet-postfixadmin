# install packages
#
# @param package_name
#  name of the package to install
# @param packages
#  additional packages to install
# @param package_ensure
#  what to ensure for packages
class postfixadmin::install (
  String $package_name   = 'postfixadmin',
  Array  $packages       = [],
  String $package_ensure = 'installed',
) {
  package { 'postfix-admin':
    ensure => $package_ensure,
    name   => $package_name,
  }

  $package_default = {
    ensure => $package_ensure,
    tag    => 'postfixadmin-packages',
  }
  ensure_packages($packages, $package_default)
}
