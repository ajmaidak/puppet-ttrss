#
# Installs ttrss using vcsrepo/git
#
class ttrss::install {

  include 'git'

  vcsrepo { $ttrss::document_root:
    ensure   => $ttrss::git_update,
    provider => git,
    source   => $ttrss::git_repo,
    revision => $ttrss::git_revision
  }

  package { $ttrss::database_package_name[$ttrss::database_type]:
    ensure => present
  }

  package { $ttrss::php_extensions:
    ensure => present
  }

  file { ["${ttrss::document_root}/cache/images",
          "${ttrss::document_root}/cache/upload",
          "${ttrss::document_root}/cache/export",
          "${ttrss::document_root}/cache/js",
          "${ttrss::document_root}/feed-icons",
          "${ttrss::document_root}/lock"]:
    ensure  => 'directory',
    owner   => $ttrss::webserver_user,
    seltype => 'httpd_sys_rw_content_t',
    mode    => '0755',
    require => Vcsrepo[$ttrss::document_root]
  }

  if($ttrss::write_enable_docroot) {
    file { $ttrss::document_root:
      ensure  => 'directory',
      owner   => $ttrss::webserver_user,
      mode    => '0755',
      seltype => 'httpd_sys_rw_content_t',
      require => Vcsrepo[$ttrss::document_root]
    }
  }
}
