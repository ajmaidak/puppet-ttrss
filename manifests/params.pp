# Operating System Defaults
class ttrss::params {
  case $::osfamily {
    'RedHat': {
      case $::operatingsystem {
        'Fedora': {
          $database_package_name = { 'pgsql' => 'php-pgsql', 'mysql' => 'php-mysqlnd' }
          $php_extensions = ['php-mbstring', 'php-ZendFramework2-Dom']
          $updater_php_extensions = 'php-process'
        }
        default: { fail("operatingsystem ${::operatingsystem} is not supported") }
      }
    }
    default: { fail("osfamily ${::osfamily} is not supported") }
  }
}
