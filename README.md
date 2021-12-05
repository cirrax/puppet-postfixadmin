# postfixadmin puppet module

[![Build Status](https://travis-ci.org/cirrax/puppet-postfixadmin.svg?branch=master)](https://travis-ci.org/cirrax/puppet-postfixadmin)
[![Puppet Forge](https://img.shields.io/puppetforge/v/cirrax/postfixadmin.svg?style=flat-square)](https://forge.puppetlabs.com/cirrax/postfixadmin)
[![Puppet Forge](https://img.shields.io/puppetforge/dt/cirrax/postfixadmin.svg?style=flat-square)](https://forge.puppet.com/cirrax/postfixadmin)
[![Puppet Forge](https://img.shields.io/puppetforge/e/cirrax/postfixadmin.svg?style=flat-square)](https://forge.puppet.com/cirrax/postfixadmin)
[![Puppet Forge](https://img.shields.io/puppetforge/f/cirrax/postfixadmin.svg?style=flat-square)](https://forge.puppet.com/cirrax/postfixadmin)

#### Table of Contents

1. [Overview](#overview)
1. [Usage - Configuration options and additional functionality](#usage)


## Overview

This module is used to configure postfixadmin.

It assumes, you are using hiera to configure.

## Usage

Just include the postfixadmin class and add some hiera definitions....

Details about the configuration possibilities are documented in the classes or in 
the [REFERENCE](https://github.com/cirrax/puppet-postfixadmin/blob/master/REFERENCE.md) file.

### Remark for Debian bullseye (11)
Debian bullseye (11) does not ship a package for postfixadmin. You need to backport the version from testing and
make it available to install.

### Examples
some example hiera configs to configure postfixadmin:

````
---

postfixadmin::db::dbtype: 'mysqli'
postfixadmin::db::dbpass: 'adminpostfix'

postfixadmin::vhost::servername: 'postfixadmin.example.com'

# we do not want ssl ;(
postfixadmin::vhost::ssl: false
postfixadmin::vhost::port: '80'
postfixadmin::vhost::docroot: '/usr/share/postfixadmin/public'

postfixadmin::ensure_database: true
postfixadmin::ensure_vhost: true
postfixadmin::ensure_postfix_queries: true
postfixadmin::admins:
  admin@example.com:
    admin: 'admin@example.com'
    password: 'P0stf1x'
    # must include two digits
    superadmin: true
    #send_mail: true
    # does not work out of the box, needs a mailer installed

postfixadmin::domains: 
  example.com:
    domain: 'example.com'

apache::mpm_module: 'prefork'
# needed by apache

````

## Manage domains using cli

using postfixadmin::cli::create_admin

using postfixadmin::cli::create_domain

using postfixadmin::cli::create_aliasdomain

you can create admins, domains and aliasdomains using puppet.

## Contributing

Please report bugs and feature request using GitHub issue tracker.

For pull requests, it is very much appreciated to check your Puppet manifest with puppet-lint
and the available spec tests  in order to follow the recommended Puppet style guidelines
from the Puppet Labs style guide.

### Authors

This module is mainly written by [Cirrax GmbH](https://cirrax.com).

See the [list of contributors](https://github.com/cirrax/puppet-postfixadmin/graphs/contributors)
for a list of all contributors.
