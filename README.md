# ttrss

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with ttrss](#setup)
    * [What ttrss affects](#what-ttrss-affects)
    * [Beginning with ttrss](#beginning-with-ttrss)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

A module for configuring ttrss https://tt-rss.org/gitlab/fox/tt-rss/wikis/home

## Module Description

This module ONLY deals with the install and setup of ttrss, it will not setup
your webserver or database.

## Setup

This module requires:
 puppet 4.x
 camptocamp-systemd
 puppetlabs-vcsrepo
 puppetlabs-git

The module has only been tested on Fedora Core 23 and uses puppet 4.x language features

### What ttrss affects

Mostly what this module does is check ttrss out into the document root of your
desired webserver. It can be used to setup the config.php file for ttrss but 
this is optional.

By default it will attempt to setup the systemd update_dameon2.php program to 
keep your feeds up to date.

## Usage

The module is intented to be used alongside modules such as puppetlabs-apache
and puppetlabs-postgresql to setup those resources.  Here is a example 'profile'
that could be used to setup ttrss:

```
class { 'apache':
  default_mods        => false,
  default_confd_files => false,
  mpm_module          => 'prefork',
}

apache::vhost { 'ttrss.maidak.info':
  servername => 'ttrss.maidak.info',
  port    => '80',
  docroot => '/var/www/html/ttrss',
}

apache::vhost { 'ttrss.maidak.org':
  servername => 'ttrss.maidak.org',
  port    => '80',
  docroot => '/var/www/html/ttrss',
}

include apache::mod::php

class { 'postgresql::server': }

postgresql::server::db { 'ttrss':
  user     => 'ttrss',
  password => postgresql_password('ttrss', 'password'),
}

class { 'ttrss':
  document_root     => '/var/www/html/ttrss',
  database_password => 'password'
}
```

## Limitations

Only supported on Fedora, the mysql codepath should work but hasn't been tested.

## Development

Use the github pull request workflow, all development is done master branch
