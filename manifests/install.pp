# install packages
class postfixadmin::install (
  String $package_name   = $postfixadmin::params::package_name,
  String $package_ensure = 'installed',
) inherits postfixadmin::params {

  package{'postfix-admin':
    ensure => $package_ensure,
    name   => $package_name,
  }
}
