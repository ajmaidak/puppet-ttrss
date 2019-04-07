# Operating System Defaults
class ttrss::params {
  case $::osfamily {
    'RedHat': {
      case $::operatingsystem {
        'Fedora': {
          $database_package_name = { 'pgsql' => 'php-pgsql', 'mysql' => 'php-mysqlnd' }
          $php_extensions = ['php-mbstring', 'php-ZendFramework2-Dom', 'php-intl']
          $updater_php_extensions = 'php-process'
        }
        default: { fail("operatingsystem ${::operatingsystem} is not supported") }
      }
      $systemd_unit_path = '/etc/systemd/system'
      $webserver_user = 'apache'
    }
    'Debian': {
      $database_package_name = { 'pgsql' =>  'php7.0-pgsql', 'mysql' => 'php7.0-mysql' }
      $php_extensions = ['php-mbstring', 'zendframework', 'php7.0-intl']
      $updater_php_extensions = 'php-symfony-process'
    }
    default: { fail("osfamily ${::osfamily} is not supported") }
  }
}
