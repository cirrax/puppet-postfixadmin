#
# internal class that installs an apache vhost
# Parameters are inherited from postfixadmin::vhost
#
# @param servername
# @param serveraliases
# @param docroot
# @param apache_vhost
# @param ssl
# @param ssl_cert
# @param ssl_key
# @param ssl_chain
# @param port
# @param redirect_to_ssl
# 
class postfixadmin::vhost::apache (
  String  $servername      = $postfixadmin::vhost::servername,
  Array   $serveraliases   = $postfixadmin::vhost::serveraliases,
  String  $docroot         = $postfixadmin::vhost::docroot,
  Hash    $apache_vhost    = {},
  Boolean $ssl             = $postfixadmin::vhost::ssl,
  String  $ssl_cert        = $postfixadmin::vhost::ssl_cert,
  String  $ssl_key         = $postfixadmin::vhost::ssl_key,
  String  $ssl_chain       = $postfixadmin::vhost::ssl_chain,
  String  $port            = $postfixadmin::vhost::port,
  Boolean $redirect_to_ssl = $postfixadmin::vhost::redirect_to_ssl,
) inherits postfixadmin::vhost {
  include apache
  include apache::mod::php

  $vhost = {
    $servername => {
      'serveraliases' => $serveraliases,
      'docroot'       => $docroot,
      'ssl'           => $ssl,
      'ssl_cert'      => $ssl_cert,
      'ssl_key'       => $ssl_key,
      'ssl_chain'     => $ssl_chain,
      'port'          => $port,
    },
  }

  create_resources('apache::vhost', $vhost, $apache_vhost)

  if $ssl and $redirect_to_ssl {
    $redir_vhost = {
      "${servername}_nossl" => {
        'servername'      => $servername,
        'serveraliases'   => $serveraliases,
        'docroot'         => $docroot,
        'port'            => 80,
        'redirect_status' => 'permanent',
        'redirect_dest'   => "https://${servername}/",
      },
    }

    create_resources('apache::vhost', $redir_vhost)
  }
}
