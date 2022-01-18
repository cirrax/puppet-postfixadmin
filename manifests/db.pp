#
# install database
#
# @param dbpass
#  password to connect to the database.
# @param dbtype
#  database type to use currently mysql or mysqli
#  is supported.
# @param dbname
#  name of the database
#  defaults to: 'postfixadmin'
# @param dbuser
#  username to connect to the database.
#  defaults to: 'postfixadmin'
# @param basepath
#  basepath for database, defaults to ''
# @param dbport
#  port to connect to db defaults to '3306' (mysql)
# @param host
#  host that is allowed to connect for database creation
#  defaults to 'localhost'
# @param host_config
#  host that is used to connect to database
#  defaults to same as host.
# @param dbconfig_inc
#  where to write the db config.
#  defaults to '/etc/postfixadmin/dbconfig.inc.php'
#  if you do not want to write, set it to ''
#
class postfixadmin::db (
  String           $dbpass       = 'CHANGEME',
  String           $dbtype       = 'mysql',
  String           $dbname       = 'postfixadmin',
  String           $dbuser       = 'postfixadmin',
  String           $host         = 'localhost',
  Optional[String] $host_config  = undef,
  String           $basepath     = '',
  String           $dbport       = '3306',
  String           $dbconfig_inc = '/etc/postfixadmin/dbconfig.inc.php',
){

  case $dbtype {
    'mysql': { include ::postfixadmin::db::mysql }
    'mysqli': { include ::postfixadmin::db::mysql }
    default: { fail("Database '${dbtype}' is not supported") }
  }

  if $dbconfig_inc != '' {
    file { $dbconfig_inc:
      owner   => 'root',
      group   => 'www-data',
      mode    => '0640',
      content => epp('postfixadmin/dbconfig.inc.epp', {
        'dbpass'   => $dbpass,
        'dbtype'   => $dbtype,
        'dbname'   => $dbname,
        'dbuser'   => $dbuser,
        'host'     => pick($host_config, $host),
        'basepath' => $basepath,
        'dbport'   => $dbport,
      }),
    }
  }
}
