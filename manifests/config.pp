#
# Paramters:
#   $config_file:
#     configuration file to use
#   $configs: 
#     Hash of configuration variables to set.
#     Defaults to {}
class postfixadmin::config (
  String $config_file = $postfixadmin::params::config_file,
  Hash   $configs     = {},
  String $owner       = $postfixadmin::params::config_owner,
  String $group       = $postfixadmin::params::config_group,
  String $mode        = $postfixadmin::params::config_mode,
) inherits postfixadmin::params {

  file { $config_file:
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => epp('postfixadmin/config.epp',{ configs => $configs }),
  }
}
