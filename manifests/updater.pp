#
# enables the update_daemon2.php as a systemd service
#
class ttrss::updater {
  if($ttrss::enable_update_service) {
    package { $ttrss::updater_php_extensions:
      ensure => present
    }

    include ::systemd

    if ( str2bool($::systemd_available) ) {
      file { "${::systemd::params::unit_path}/ttrss-update.service":
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => epp('ttrss/ttrss-update.epp'),
        before  => Service['ttrss-update'],
        notify  => Exec['systemd-daemon-reload'],
      }
    }
    service { 'ttrss-update':
      ensure => 'running',
    }
  }
}
