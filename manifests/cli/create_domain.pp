#
# Ensures, that a domain exists
# But does not modify any domains
#
# @param domain
#  The domain defaults to $title
# @param description
#  a description defaults to $title
# @param aliases
#  amount of Aliases (-1=disable, 0=unlimited)
#  defaults to false (do not use option)
# @param mailboxes
#  amount of mailboxes (-1=disable, 0=unlimited)
#  defaults to false (do not use option)
# @param quota
#  domain quota (MB | -1 = disable | 0 = unlimited)
#  defaults to false (do not use option)
# @param maxquota
#  Mailbox Quota (MB) (MB | -1 = disable | 0 = unlimited)
#  defaults to false (do not use option)
# @param default_aliases
#  If true (default) set the default aliases
#
define postfixadmin::cli::create_domain (
  String  $domain          = $title,
  String  $description     = $title,
  Integer $aliases         = -1,
  Integer $mailboxes       = -1,
  Integer $quota           = -1,
  Integer $maxquota        = -1,
  Boolean $default_aliases = true,
) {
  include postfixadmin::cli::params
  $cmd = $postfixadmin::cli::params::cmd

  if $aliases != -1 {
    $_aliases = "--aliases ${aliases}"
  } else {
    $_aliases = ''
  }

  if $mailboxes != -1 {
    $_mailboxes = "--mailboxes ${mailboxes}"
  } else {
    $_mailboxes = ''
  }

  if $quota != -1 {
    $_quota = "--quota ${quota}"
  } else {
    $_quota = ''
  }

  if $maxquota != -1 {
    $_maxquota = "--maxquota ${maxquota}"
  } else {
    $_maxquota = ''
  }

  if $default_aliases {
    $_default_aliases = '--default-aliases'
  } else {
    $_default_aliases = ''
  }

  $options= "--description '${description}' ${_aliases} ${_mailboxes} ${_maxquota} ${_quota} ${_default_aliases}"

  exec { "postfixadmin create_domain ${domain}":
    path    => $postfixadmin::cli::params::path,
    command => "${cmd} domain add ${domain} ${options}|grep 'has been added'",
    unless  => "${cmd} domain view ${domain}|grep 'Last modified: '",
  }
}
