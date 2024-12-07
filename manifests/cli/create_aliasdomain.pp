#
# define to ensure an aliasdomain exists
#
# @param target_domain
#  the domain it points to
# @param domain
#  the domain to ensure (defaults to $title)
# @param create_domain
#  if true (default) we use postfixadmin::cli::create_domain
#  to create the domain.
#  if you set this to false you need to create the domain
#  before using this define.
#
define postfixadmin::cli::create_aliasdomain (
  String  $target_domain,
  String  $domain        = $title,
  Boolean $create_domain = true,
) {
  include postfixadmin::cli::params
  $cmd = $postfixadmin::cli::params::cmd

  if $create_domain {
    postfixadmin::cli::create_domain { $domain :
      description     => "Aliasdomain ${domain}, target: ${target_domain}",
      default_aliases => false,
      before          => Exec["postfixadmin create_aliasdomain ${domain}"],
    }
  }

  exec { "postfixadmin create_aliasdomain ${domain}":
    path    => $postfixadmin::cli::params::path,
    command => "${cmd} aliasdomain add ${domain} --target-domain ${target_domain} |grep 'has been created'",
    unless  => "${cmd} aliasdomain view ${domain}|grep 'Active: YES'",
  }
}
