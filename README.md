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

Example for a `hiera.yaml`

````
---
version: 5
defaults:
  # The default value for "datadir" is "data" under the same directory as the hiera.yaml
  # file (this file)
  # When specifying a datadir, make sure the directory exists.
  # See https://puppet.com/docs/puppet/latest/environments_about.html for further details on environments.
  # datadir: data
  # data_hash: yaml_data
hierarchy:
  - name: "Per-node data (yaml version)"
    path: "nodes/%{::trusted.certname}.yaml"
  - name: "Other YAML hierarchy levels"
    paths:
      - "common.yaml"

````

And example for `data/common.yaml` with various parameters:

````
---

postfixadmin::db::dbtype: 'mysqli'
postfixadmin::db::dbpass: 'adminpostfix'

postfixadmin::vhost::apache::servername: '10.11.12.100'

postfixadmin::vhost::ssl: false
# postfixadmin::vhost::docroot: '/usr/share/postfixadmin/public'
# fixed

postfixadmin::ensure_database: true
postfixadmin::ensure_vhost: true
postfixadmin::ensure_maps: true
postfixadmin::admins:
    admin@example.com:
        admin: 'admin@example.com'
        password: 'P0stf1x'
        # must include two digits
        superadmin: true
        #send_mail: true
        # does not work out of teh box, needs a mailer installed

postfixadmin::domains: 
    example.com:
        domain: 'example.com'

apache::mpm_module: 'prefork'
# needed by apache

````

Details about the configuration possibilities are documented in the classes.

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
