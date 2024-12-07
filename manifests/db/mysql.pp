#
# privat class to manage mysql db
# use postfixadmin::db instead
#
# @param dbname
# @param dbuser
# @param dbpass
# @param host
#
class postfixadmin::db::mysql (
  String $dbname = $postfixadmin::db::dbname,
  String $dbuser = $postfixadmin::db::dbuser,
  String $dbpass = $postfixadmin::db::dbpass,
  String $host   = $postfixadmin::db::host,
) inherits postfixadmin::db {
  mysql::db { $dbname :
    user     => $dbuser,
    password => $dbpass,
    host     => $host,
    grant    => ['ALTER', 'CREATE', 'SELECT', 'INSERT', 'UPDATE', 'DELETE'],
  }
}
