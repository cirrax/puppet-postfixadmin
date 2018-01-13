
class postfixadmin::db::mysql (
  $dbname = $postfixadmin::db::dbname,
  $dbuser = $postfixadmin::db::dbuser,
  $dbpass = $postfixadmin::db::dbpass,
  $host   = $postfixadmin::db::host,
) inherits postfixadmin::db {

  mysql::db { $dbname :
    user     => $dbuser,
    password => $dbpass,
    host     => $host,
    grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
  }

}
