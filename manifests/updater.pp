#
# enables the update_daemon2.php as a systemd service
#
class ttrss::updater {
  if($ttrss::enable_update_service) {
    package { $ttrss::updater_php_extensions:
      ensure => present
    }

    include ::systemd

    file { '/usr/lib/systemd/system/ttrss-update.service':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => epp('ttrss/ttrss-update.epp'),
    } ~>
    Exec['systemctl-daemon-reload']
  }
}
