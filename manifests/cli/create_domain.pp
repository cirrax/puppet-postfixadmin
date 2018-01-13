#
# Ensures, that a domain exists
# But does not modify any domains
#
# Parameters:
#  $domain      = $title,
#    The domain defaults to $title
#  $description = $title,
#    a description defaults to $title
#  $aliases     = unset,
#    amount of Aliases (-1=disable, 0=unlimited)
#    defaults to false (do not use option)
#  $mailboxes   = unset,
#    amount of mailboxes (-1=disable, 0=unlimited)
#    defaults to false (do not use option)
#  $quota       = unset,
#    domain quota (MB | -1 = disable | 0 = unlimited)
#    defaults to false (do not use option)
#  $maxquota    = unset,
#    Mailbox Quota (MB) (MB | -1 = disable | 0 = unlimited)
#    defaults to false (do not use option)
# $default_aliases
#    If true (default) set the default aliases
#
#
define postfixadmin::cli::create_domain (
  $domain          = $title,
  $description     = $title,
  $aliases         = false,
  $mailboxes       = false,
  $quota           = false,
  $maxquota        = false,
  $default_aliases = true,
){

  include ::postfixadmin::cli::params
  $cmd = $postfixadmin::cli::params::cmd

  if $aliases {
    $_aliases = "--aliases ${aliases}"
  } else {
    $_aliases = ''
  }

  if $mailboxes {
    $_mailboxes = "--mailboxes ${mailboxes}"
  } else {
    $_mailboxes = ''
  }

  if $quota {
    $_quota = "--quota ${quota}"
  } else {
    $_quota = ''
  }

  if $maxquota {
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

  exec {"postfixadmin create_domain ${domain}":
    path    => $postfixadmin::cli::params::path,
    command => "${cmd} domain add ${domain} ${options}|grep 'has been added'",
    unless  => "${cmd} domain view ${domain}|grep 'Active: YES'",
  }
}
