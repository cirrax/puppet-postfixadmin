#
# class to create mysql maps for postfix
#
# Parameters:
# @param dbpass
#  password to connect to the database.
# @param dbuser
#  username to connect to the database.
#  defaults to: 'postfixadmin'
# @param dbname
#  name of the database
#  defaults to: 'postfixadmin'
# @param host
#  host to connect to.
#  defaults to localhost
# @param mysql_flags
#  Array of additional flags for connecting to mysql
#  eg. ssl settings. defaults to []
# @param dir
#  directory to place the map
#  defaults to $postfixadmin::params::map_dir
# @param owner
#  owner of the map files
#  default to $postfixadmin::params::map_owner
# @param group
#  group of the map files
#  defaults to $postfixadmin::params::map_group
# @param mode
#  mode of the map files 
#  defaults to $postfixadmin::params::map_mode,
# @param default_password_scheme
#  change to match your Postfixadmin setting.
#  depends on your $CONF['encrypt'] setting
#  defaults to 'MD5-CRYPT'
# @param mboxpath
#  path to the mbailboxes
# @param uid
#  uid to use for mailboxes
#  must matche dovecot.conf AND Postfix virtual_uid_maps parameter
#  defaults to '' (not included in query)
# @param gid
#  gid to use for mailboxes
#  must matche dovecot.conf AND Postfix virtual_gid_maps parameter
#  defaults to '' (not included in query)
# @param quota
#  if true quota is included in the query
#  defaults to true
#
class postfixadmin::queries::dovecot (
  String  $dbpass                  = 'CHANGEME',
  String  $dbuser                  = 'postfixadmin',
  String  $dbname                  = 'postfixadmin',
  String  $host                    = 'localhost',
  Array   $mysql_flags             = [],
  String  $dir                     = $postfixadmin::params::dovecot_dir,
  String  $owner                   = $postfixadmin::params::dovecot_owner,
  String  $group                   = $postfixadmin::params::dovecot_group,
  String  $mode                    = $postfixadmin::params::dovecot_mode,
  String  $default_password_scheme = 'MD5-CRYPT',
  String  $mboxpath                = '',
  String  $uid                     = '',
  String  $gid                     = '',
  Boolean $quota                   = true,
) inherits postfixadmin::params {

  file{ $dir:
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
    mode   => '0750',
  }

  $maps = [
    'mysql_dovecot-sql',
    'mysql_dovecot-dict-quota',
  ]

  $maps.each | $mapname | {
    file{ "${dir}/${mapname}.conf.ext":
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      content => template("postfixadmin/dovecot/${mapname}.erb"),
    }
  }
}
