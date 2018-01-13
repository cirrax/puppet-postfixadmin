#
# Paramters:
#   $config_file:
#     configuration file to use
#   $configs: 
#     Hash of configuration variables to set.
#     Defaults to {}
class postfixadmin::config (
  $config_file = $postfixadmin::params::config_file,
  $configs     = {},
  $owner       = $postfixadmin::params::config_owner,
  $group       = $postfixadmin::params::config_group,
  $mode        = $postfixadmin::params::config_mode,
) inherits postfixadmin::params {

  file { $config_file:
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => epp('postfixadmin/config.epp',{ configs => $configs }),
  }
}
