#
# This define just ensures that a
# an admin account exists.
#
# Parameters:
# $admin
#   the name of the admin account (needs to be an Email)
#   Defaults to $title
# $password
#   The passord to initialy set. If set to '' (the default) an
#   random password is generated
# $superadmin
#   if set to true the admin is a superadmin with access to all domains
#   Default to false
#
#
define postfixadmin::cli::create_admin (
  String  $admin      = $title,
  String  $password   = '',
  Boolean $superadmin = false,
){

  include ::postfixadmin::cli::params
  $cmd  = $postfixadmin::cli::params::cmd

  if $password=='' {
    $pw=postfixadmin_generate_pw()
  } else {
    $pw=$password
  }

  if $superadmin {
    $_suadmin = '--superadmin'
  } else {
    $_suadmin = ''
  }

  exec {"postfixadmin create_admin ${admin}":
    path     => $postfixadmin::cli::params::path,
    provider => 'shell',
    command  => "${cmd} admin add ${admin} --password ${pw} --password2 ${pw} ${_suadmin}| grep 'has been added'",
    unless   => "${cmd} admin view ${admin} | grep 'Active: YES' 2>/dev/null",
  }

}
