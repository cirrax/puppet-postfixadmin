# Parameters:
# $dbpass
#   password to connect to the database.
# $type
#   database type to use currently only mysql is
#   supported. 
#   defaults to 'mysql'
# $dbname
#   name of the database
#   defaults to: 'postfixadmin'
# $dbuser
#   username to connect to the database.
#   defaults to: 'postfixadmin'
# $host
#   host that is allowed to connect
#   defaults to 'localhost'
#
class postfixadmin::db (
  $dbpass = 'CHANGEME',
  $type   = 'mysql',
  $dbname = 'postfixadmin',
  $dbuser = 'postfixadmin',
  $host   = 'localhost',
){

  case $type {
    'mysql': { include ::postfixadmin::db::mysql }
    default: { fail("Database '${type}' is not supported") }
  }
}


