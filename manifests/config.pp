class ttrss::config {
  if ($ttrss::setup_config) {
    file { 'config.php':
      ensure  => file,
      path    => "${ttrss::document_root}/config.php",
      content => epp('ttrss/config.php.epp'),
      mode    => '0644',
      owner   => 0,
      group   => 0,
    }
  }
}
