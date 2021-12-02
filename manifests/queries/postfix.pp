#
# class to create mysql maps for postfix
#
# @param dbpass
#  password to connect to the database.
# @param dbuser
#  username to connect to the database.
#  defaults to: 'postfixadmin'
# @param dbname
#  name of the database
#  defaults to: 'postfixadmin'
# @param hosts
#  Array of hosts to connect to.
#  defaults to ['localhost']
# @param dir
#  directory to place the map
# @param owner
#  owner of the map files
# @param group
#  group of the map files
# @param mode
#  mode of the map files 
# @param allow_account_as_sender
#  used for mysql_sender_access if set to true
#  add the account as a permitted sender address. 
#  this allows to create send only accounts which do not
#  receive any mails (eg. sender address is aliased to another
#  mailbox). Accounts needs to be formated as email adresses for
#  this to work !
#
class postfixadmin::queries::postfix (
  String  $dbpass                  = 'CHANGEME',
  String  $dbuser                  = 'postfixadmin',
  String  $dbname                  = 'postfixadmin',
  Array   $hosts                   = [ 'localhost' ],
  String  $dir                     = '/etc/postfix/postfixadmin',
  String  $owner                   = 'root',
  String  $group                   = 'postfix',
  String  $mode                    = '0640',
  Boolean $allow_account_as_sender = false,
) {

  file{ $dir:
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
    mode   => '0750',
  }

  $maps = [
    'mysql_virtual_alias_domain_catchall_maps',
    'mysql_virtual_alias_domain_maps',
    'mysql_virtual_alias_maps',
    'mysql_virtual_mailbox_limit_maps',
    'mysql_virtual_domains_maps',
    'mysql_virtual_mailbox_maps',
    'mysql_virtual_alias_domain_mailbox_maps',
    'mysql_virtual_domains_no_srs_maps',
    'mysql_sender_access',
  ]

  $maps.each | $mapname | {
    file{ "${dir}/${mapname}.cf":
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      content => template("postfixadmin/postfix/${mapname}.erb"),
    }
  }
}
