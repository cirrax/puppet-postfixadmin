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
#
class postfixadmin (
  Boolean $ensure_database = false,
  Boolean $ensure_vhost    = false,
  Boolean $ensure_postfix_queries = false,
  Boolean $ensure_dovecot_queries = false,
  Hash $admins          = {},
  Hash $domains         = {},
  Hash $aliasdomains    = {},
) inherits postfixadmin::params {

  if $ensure_database {
    include ::postfixadmin::db
  }

  if $ensure_vhost {
    include ::postfixadmin::vhost
  }

  if $ensure_postfix_queries {
    include ::postfixadmin::queries::postfix
  }

  if $ensure_dovecot_queries {
    include ::postfixadmin::queries::dovecot
  }

  include ::postfixadmin::install
  include ::postfixadmin::config

  Class['postfixadmin::install'] -> Class['postfixadmin::config']

  create_resources('postfixadmin::cli::create_admin', $admins)
  create_resources('postfixadmin::cli::create_domain', $domains)
  create_resources('postfixadmin::cli::create_aliasdomain', $aliasdomains)

}
