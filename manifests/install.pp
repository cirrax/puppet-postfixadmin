# install packages
class postfixadmin::install (
  $package_name   = $postfixadmin::params::package_name,
  $package_ensure = 'installed',
) inherits postfixadmin::params {

  package{'postfix-admin':
    ensure => $package_ensure,
    name   => $package_name,
  }
}
