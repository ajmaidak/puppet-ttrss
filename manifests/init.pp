# Class: ttrss
# ===========================
#
# entry class for the ttrss module
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `document_root`
# The document root of the ttrss website
#
# * `git_repo`
# The repo from which to clone the ttrss php code
# 
# * `git_revision`
# The git revision you want to clone
#
# * `git_update`
# Let puppet keep the ttrs code up to date
#
# * `database_type`
# This does two things:
# * installs the correct php extensions on the server to talk to
# the database host
# * sets a value set in config.php for the proper database
#
# * `setup_config`
# use the provided template to create your config.php rather then
# ttrss_site/install program, used if you are importanting your
# own database from another site...
#
# * `database_name`
# value set in config.php
#
# * `database_user`
# value set in config.php
#
# * `database_password`
# value set in config.php
#
# * `database_server`
# value set in config.php
#
# * `database_port`
# value set in config.php
#
# * `ttrss_url`
# value set in config.php
#
# * `enable_update_service`
# If set to true this will create a systemd service for the update_daemon2.php 
# updater to update your feeds automatically
#
# * `write_enable_docroot`
# Allow the webserver to write to the document root for saving config.php 
# 
#
# Variables
# ----------
#
#
# Example
# --------
#
#    class { 'ttrss':
#      database_user     => 'mydbuser',
#      database_password => 'mypasword',
#      document_root     => '/my/web/docroot'
#    }
#
# Authors
# -------
#
# Alexander J. Maidak <ajmaidak@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2016 Alexander J. Maidak
#
class ttrss (
  $document_root         = '/var/www/html/ttrss',
  $git_repo              = 'https://tt-rss.org/fox/tt-rss.git',
  $git_revision          = 'master',
  $git_update            = 'latest',
  $setup_config          = false,
  $enable_update_service = true,
  $database_type         = 'pgsql',
  $database_name         = 'ttrss',
  $database_user         = 'ttrss',
  $database_password     = 'password',
  $database_server       = 'localhost',
  $database_port         = '5432',
  $ttrss_url             = 'http://www.my-ttrss-site.info',
  $write_enable_docroot  = false,
  $webserver_user        = $::ttrss::params::webserver_user
) inherits ttrss::params {
  contain ttrss::install
  contain ttrss::config
  contain ttrss::updater

  Class['ttrss::install'] ->
  Class['ttrss::config'] ->
  Class['ttrss::updater']
}
