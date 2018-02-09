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

