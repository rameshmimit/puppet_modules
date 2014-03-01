class java {

 package { 'debconf-utils':
  ensure => latest,
 }

 exec { 'accept-java-oracle-license':
  command => '/bin/echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections',
  unless  => 'debconf-get-selections | grep 'oracle-java7-installer.*shared/accepted-oracle-license-v1-1.*true'',
  require => Package['debconf-utils'],
 }

 package { 'oracle-java7-installer':
  ensure  => latest,
  require => Exec['accept-java-oracle-license'],
 }

 package { 'oracle-java7-set-default':
  ensure  => latest,
  require => Package['oracle-java7-installer'],
 }

}
