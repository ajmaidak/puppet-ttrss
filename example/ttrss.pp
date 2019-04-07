#
# An example profile for which can be used to setup ttrss
# run with puppet apply ttrss.pp, before running this you
# can use librarian-puppet or r10k to download the deps in
# the puppet file.
# 
# gem install librarian-puppet
# librarian-puppet install --path /etc/puppet/modules
# puppet apply ttrss.pp
#
class { 'apache':
  default_mods        => false,
  default_confd_files => false,
  mpm_module          => 'prefork',
}

apache::vhost { 'ttrss.maidak.info':
  servername => 'ttrss.maidak.info',
  port       => '80',
  docroot    => '/var/www/html/ttrss',
}

apache::vhost { 'ttrss.maidak.org':
  servername => 'ttrss.maidak.org',
  port       => '80',
  docroot    => '/var/www/html/ttrss',
}

class { 'apache::mod::php':
  php_version  => '7',
}

class { 'postgresql::server': }

postgresql::server::db { 'ttrss_db':
  user     => 'ttrss_user',
  password => postgresql_password('ttrss_user', 'password'),
}

class { 'ttrss':
  database_password    => 'password',
  database_name        => 'ttrss_db',
  database_user        => 'ttrss_user',
  write_enable_docroot => true,
}

firewall { '100 allow http and https access':
  dport  => [80, 443],
  proto  => tcp,
  action => accept,
}

selinux::boolean { 'httpd_can_network_connect_db':
  ensure     => 'on',
  persistent => true
}
