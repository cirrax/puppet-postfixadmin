#
# privat class to manage mysql db
# use postfixadmin::db instead
#
# @param dbname
#   name of the database
# @param dbuser
#   username to access the database
# @param dbpass
#   password for the database
# @param host
#   hostname
# @param collate
#   collate for the database
# @param charset
#   charset for the database
#
class postfixadmin::db::mysql (
  String              $dbname  = $postfixadmin::db::dbname,
  String              $dbuser  = $postfixadmin::db::dbuser,
  String              $dbpass  = $postfixadmin::db::dbpass,
  String              $host    = $postfixadmin::db::host,
  Optional[String[1]] $collate = undef,
  Optional[String[1]] $charset = undef,
) inherits postfixadmin::db {
  mysql::db { $dbname :
    user     => $dbuser,
    password => $dbpass,
    host     => $host,
    grant    => ['ALTER', 'CREATE', 'SELECT', 'INSERT', 'UPDATE', 'DELETE'],
    collate  => $collate,
    charset  => $charset,
  }
}
