#
# an example profile for which can be used to setup ttrss
# run with puppet apply ttrss.pp, before running this you
# can use librian-puppet or r10k to download the deps in
# the puppet file
#
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
  database_password => 'password'
}

firewall { '100 allow http and https access':
  dport   => [80, 443],
  proto  => tcp,
  action => accept,
}

selinux::boolean { 'httpd_can_network_connect_db': 
  ensure     => 'on',
  persistent => true
}
