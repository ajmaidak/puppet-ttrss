#
# enables the update_daemon2.php as a systemd service
#
class ttrss::updater inherits ttrss {
  if($ttrss::enable_update_service) {
    package { $ttrss::updater_php_extensions:
      ensure => present
    }

    file { "${::ttrss::params::systemd_unit_path}/ttrss-update.service":
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => epp('ttrss/ttrss-update.epp'),
      before  => Service['ttrss-update'],
    }

    exec { 'systemctl-daemon-reload':
      path        => '/bin:/sbin:/usr/bin:/usr/sbin',
      command     => 'systemctl daemon-reload',
      subscribe   => File["${::ttrss::params::systemd_unit_path}/ttrss-update.service"],
      refreshonly => true,
    }

    service { 'ttrss-update':
      ensure => 'running',
    }
  }
}
