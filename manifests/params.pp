#
class postfixadmin::params{

  $package_name = 'postfixadmin'
  $config_file  = '/etc/postfixadmin/config.local.php'
  $config_owner = 'root'
  $config_group = 'www-data'
  $config_mode  = '0640'
  $docroot      = '/usr/share/postfixadmin'

  # postfix maps
  $map_dir        = '/etc/postfix/postfixadmin'
  $map_owner      = 'root'
  $map_group      = 'postfix'
  $map_mode       = '0640'

  # dovecot queries
  $dovecot_dir    = '/etc/dovecot/postfixadmin'
  $dovecot_owner  = 'root'
  $dovecot_group  = 'root'
  $dovecot_mode   = '0640'

}
