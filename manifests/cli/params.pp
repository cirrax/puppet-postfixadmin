#
# Class to set the postfixadmin client program to use
#
# Parameters:
# @param path
# @param cmd
#   the postfixadmin-cli program
#   defaults to:
#   'bash /usr/share/postfixadmin/scripts/postfixadmin-cli'
#
#
class postfixadmin::cli::params (
  Array  $path = ['/bin','/usr/bin'],
  String $cmd  = 'bash /usr/share/postfixadmin/scripts/postfixadmin-cli',
) {
}
