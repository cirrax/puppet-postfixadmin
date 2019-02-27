#
# Paramters:
#   $ensure_database
#     if true a database is created
#     Defaults to false
#   $ensure_vhost
#     if true a virtualhost is created
#     Defaults to false
#   $ensure_maps
#     if true the maps querying the database
#     for postfix are created
#     Defaults to false
#   $admins
#     Hash of hashes to create postfixadmin::cli::create_admin
#     Defaults to {}
#   $domains
#     Hash of hases to create postfixadmin::cli::create_domain
#     Defaults to {}
#   $aliasdomains
#     Hash of hases to create postfixadmin::cli::create_aliasdomain
#     Defaults to {}
#   $dovecot_classes
#     Array of classnames that are required for devecot
#     query installation (defaults to ['dovecot'])
#   $postfix_classes
#     Array of classnames that are required for postfix
#     query installation (defaults to ['postfix'])
#
class postfixadmin (
  Boolean $ensure_database = false,
  Boolean $ensure_vhost    = false,
  Boolean $ensure_postfix_queries = false,
  Boolean $ensure_dovecot_queries = false,
  Hash $admins          = {},
  Hash $domains         = {},
  Hash $aliasdomains    = {},
  Array $dovecot_classes = ['dovecot'],
  Array $postfix_classes = ['postfix'],
) inherits postfixadmin::params {

  Class['postfixadmin::install'] -> Class['postfixadmin::config']
  -> Postfixadmin::Cli::Create_admin <| |>
  -> Postfixadmin::Cli::Create_domain <| |>
  -> Postfixadmin::Cli::Create_aliasdomain <| |>


  if $ensure_database {
    Class['postfixadmin::install'] -> Class['postfixadmin::db'] 
    -> Postfixadmin::Cli::Create_admin <| |>
    include ::postfixadmin::db
  }

  if $ensure_vhost {
    Class['postfixadmin::config'] -> Class['postfixadmin::vhost']
    include ::postfixadmin::vhost
  }

  if $ensure_postfix_queries {
    Class[$postfix_classes] -> Class['postfixadmin::queries::postfix']
    include ::postfixadmin::queries::postfix
  }

  if $ensure_dovecot_queries {
    Class[$dovecot_classes] -> Class['postfixadmin::queries::dovecot']
    include ::postfixadmin::queries::dovecot
  }

  include ::postfixadmin::install
  include ::postfixadmin::config

  create_resources('postfixadmin::cli::create_admin', $admins)
  create_resources('postfixadmin::cli::create_domain', $domains)
  create_resources('postfixadmin::cli::create_aliasdomain', $aliasdomains)
}
