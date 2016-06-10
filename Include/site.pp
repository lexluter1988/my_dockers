
class { 'docker':
  manage_kernel => false,
  version => 'latest',
}

docker_network { 'crossover-net':
  ensure   => present,
  driver   => 'bridge',
}

docker::image { 'lexluter1988/httpd':
  image_tag => 'centos6'
}

docker::image { 'lexluter1988/mysqld':
  image_tag => 'centos6'
}

docker::image { 'jordan/icinga2':
  image_tag => 'latest'
}

docker::run { 'webserver':
  image           => 'lexluter1988/httpd:centos6',
  net             => 'crossover-net',
  ports          => ['80:80'],
  hostname        => 'web.crossover-net',
  dns             => ['8.8.8.8', '8.8.4.4'],
}

docker::run { 'mysqlserver':
  image           => 'lexluter1988/mysqld:centos6',
  net             => 'crossover-net',
  ports          => ['3306:3306'],
  hostname        => 'mysql.crossover-net',
  dns             => ['8.8.8.8', '8.8.4.4'],
}

docker::run { 'icinga':
  image           => 'jordan/icinga2',
  net             => 'crossover-net',
  ports          => ['3080:80'],
  hostname        => 'icinga.crossover-net',
  dns             => ['8.8.8.8', '8.8.4.4'],
}
