#
# class for postfixadmin configuration 
#
# @param config_file
#  configuration file to use
# @param configs
#  Hash of configuration variables to set.
#  Defaults to {}
# @param owner
#  configfile owner
# @param group
#  configfile group
# @param mode
#  configfile mode
#
class postfixadmin::config (
  String $config_file = '/etc/postfixadmin/config.local.php',
  Hash   $configs     = {},
  String $owner       = 'root',
  String $group       = 'www-data',
  String $mode        = '0640',
) {
  file { $config_file:
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => epp('postfixadmin/config.epp', { configs => $configs }),
  }
}
