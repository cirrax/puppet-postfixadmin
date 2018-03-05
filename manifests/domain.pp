#
# helper define to create domains
#
# Parameters:
# $domain
#   The domain name defaults to $title
# $target_domain
#   if set, an alias domain is created, defaults to ''
# $cli_parameters
#   additional parameters for postfixadmin::cli::create_domain
#   or postfixadmin::cli::create_aliasdomain

define postfixadmin::domain (
  String $domain         = $title,
  String $target_domain  = '',
  Hash   $cli_parameters = {},
) {

  if $target_domain == '' {
    # domain
    ensure_resources('postfixadmin::cli::create_domain',
      { $domain => {}, },
      $cli_parameters,
    )
  } else {
    ensure_resources('postfixadmin::cli::create_aliasdomain',
      { $domain => { 'target_domain' => $target_domain }, },
      $cli_parameters,
    )
  }
}
