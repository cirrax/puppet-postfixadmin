#
# helper define to create domains
#
# @param domain
#  The domain name defaults to $title
# @param target_domain
#  if set, an alias domain is created, defaults to undef
# @param cli_parameters
#  additional parameters for postfixadmin::cli::create_domain
#  or postfixadmin::cli::create_aliasdomain
#
define postfixadmin::domain (
  String              $domain         = $title,
  Optional[String[1]] $target_domain  = undef,
  Hash                $cli_parameters = {},
) {
  if $target_domain {
    ensure_resources('postfixadmin::cli::create_aliasdomain',
      { $domain => { 'target_domain' => $target_domain }, },
      $cli_parameters,
    )
  } else {
    # domain
    ensure_resources('postfixadmin::cli::create_domain',
      { $domain => {}, },
      $cli_parameters,
    )
  }
}
