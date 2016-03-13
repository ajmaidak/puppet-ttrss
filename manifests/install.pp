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
    owner   => 'apache',
    mode    => '0755',
    require => Vcsrepo[$ttrss::document_root]
  }
}